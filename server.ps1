param(
    [int]$Port = 8080,
    [string]$Root = $PSScriptRoot
)

if (-not $Root) {
    $Root = (Get-Location).Path
}

$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$Port/")
$listener.Prefixes.Add("http://127.0.0.1:$Port/")

try {
    $listener.Start()
} catch {
    Write-Error "Failed to start listener on port $Port : $_"
    exit 1
}

Write-Host "==================================================" -ForegroundColor Cyan
Write-Host " Local Web Server Running!" -ForegroundColor Green
Write-Host " URL: http://localhost:$Port/" -ForegroundColor Yellow
Write-Host " Root Directory: $Root" -ForegroundColor Gray
Write-Host " Press Ctrl+C to stop." -ForegroundColor DarkGray
Write-Host "==================================================" -ForegroundColor Cyan

$mimeTypes = @{
    ".html" = "text/html; charset=utf-8"
    ".htm"  = "text/html; charset=utf-8"
    ".css"  = "text/css; charset=utf-8"
    ".js"   = "application/javascript; charset=utf-8"
    ".json" = "application/json; charset=utf-8"
    ".png"  = "image/png"
    ".jpg"  = "image/jpeg"
    ".jpeg" = "image/jpeg"
    ".gif"  = "image/gif"
    ".svg"  = "image/svg+xml"
    ".ico"  = "image/x-icon"
    ".pdf"  = "application/pdf"
    ".woff" = "font/woff"
    ".woff2"= "font/woff2"
    ".ttf"  = "font/ttf"
}

try {
    while ($listener.IsListening) {
        $context = $listener.GetContext()
        $request = $context.Request
        $response = $context.Response

        $urlPath = [System.Uri]::UnescapeDataString($request.Url.AbsolutePath)
        if ($urlPath -eq "/" -or $urlPath -eq "") {
            $relPath = "index.html"
        } else {
            $relPath = $urlPath.TrimStart('/')
        }

        # Sanitize path to prevent directory traversal
        $filePath = [System.IO.Path]::GetFullPath([System.IO.Path]::Combine($Root, $relPath))

        if (-not $filePath.StartsWith($Root, [System.StringComparison]::OrdinalIgnoreCase)) {
            $response.StatusCode = 403
            $msg = [System.Text.Encoding]::UTF8.GetBytes("403 Forbidden")
            $response.ContentLength64 = $msg.Length
            $response.OutputStream.Write($msg, 0, $msg.Length)
            $response.Close()
            continue
        }

        if ([System.IO.File]::Exists($filePath)) {
            $ext = [System.IO.Path]::GetExtension($filePath).ToLower()
            $contentType = if ($mimeTypes.ContainsKey($ext)) { $mimeTypes[$ext] } else { "application/octet-stream" }

            $response.ContentType = $contentType
            $response.StatusCode = 200

            try {
                $bytes = [System.IO.File]::ReadAllBytes($filePath)
                $response.ContentLength64 = $bytes.Length
                if ($request.HttpMethod -ne "HEAD") {
                    $response.OutputStream.Write($bytes, 0, $bytes.Length)
                }
                Write-Host "[$([System.DateTime]::Now.ToString('HH:mm:ss'))] 200 OK: $relPath" -ForegroundColor Green
            } catch {
                $response.StatusCode = 500
                Write-Host "[$([System.DateTime]::Now.ToString('HH:mm:ss'))] 500 Internal Error: $relPath" -ForegroundColor Red
            }
        } else {
            $response.StatusCode = 404
            $msg = [System.Text.Encoding]::UTF8.GetBytes("404 Not Found: $relPath")
            $response.ContentType = "text/plain"
            $response.ContentLength64 = $msg.Length
            if ($request.HttpMethod -ne "HEAD") {
                $response.OutputStream.Write($msg, 0, $msg.Length)
            }
            Write-Host "[$([System.DateTime]::Now.ToString('HH:mm:ss'))] 404 Not Found: $relPath" -ForegroundColor Yellow
        }

        $response.Close()
    }
} finally {
    if ($listener.IsListening) {
        $listener.Stop()
    }
    $listener.Close()
}
