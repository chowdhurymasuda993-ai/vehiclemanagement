@echo off
title Install Palm Springs MCST Parking App
echo =========================================================
echo  Installing Palm Springs MCST Parking App to Desktop...
echo =========================================================

powershell -NoProfile -ExecutionPolicy Bypass -Command "$ws = New-Object -ComObject WScript.Shell; $desktop = [Environment]::GetFolderPath('Desktop'); $shortcut = $ws.CreateShortcut(\"$desktop\Palm Springs MCST Parking.lnk\"); $iconPath = (Resolve-Path '.\app.ico').Path; $shortcut.TargetPath = 'msedge.exe'; $shortcut.Arguments = '--app=\"https://chowdhurymasuda993-ai.github.io/vehiclemanagement/\"'; $shortcut.IconLocation = \"$iconPath,0\"; $shortcut.Description = 'Palm Springs MCST Vehicle Parking Portal'; $shortcut.Save(); Write-Host 'Shortcut created successfully at: ' $shortcut.FullName"

pause
