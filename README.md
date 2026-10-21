# Palm Springs Residence - MCST Vehicle Parking Management System

An interactive vehicle parking management portal and resident guidelines web application for Palm Springs Residence MCST Plan No. 4281, governed under the Building Maintenance and Strata Management Act (BMSMA) 2004, Singapore.

## Features

- **Guidelines & Bylaws Directory**: Detailed breakdown of 1st vs 2nd vehicle rules, visitor parking grace periods, EV charging, and wheel clamping policies.
- **Season Parking Registration**: Interactive registration form for resident vehicle IUs and log card submissions.
- **Overnight Visitor Parking Application**: Instant digital passes for visitor overnight parking with automated pass generation.
- **Carpark Status & Lot Finder**: Interactive map and lot availability viewer for Basement 1 and Level 1.
- **Fee Calculator**: Calculate daytime visitor parking, overnight visitor parking, and resident season parking costs.
- **AI Parking Concierge (Gemini-Powered)**: Integrated AI chatbot powered by Google Gemini to answer questions regarding parking rules, fee calculation, and step-by-step guidance.
- **Admin Management Portal**: Administrative overview of registered units, active IU database, pending logcards, and active passes.

## Getting Started

### Option 1: Double-Click Launcher (Windows)
Double-click `start.bat` to automatically start the local web server and open the portal in your default browser at `http://localhost:8080/`.

### Option 2: PowerShell
Run the included PowerShell server:
```powershell
powershell -ExecutionPolicy Bypass -File .\server.ps1 -Port 8080
```
Then navigate to [http://localhost:8080/](http://localhost:8080/) in your web browser.

### Option 3: Static Browser
You can open `index.html` directly in any modern web browser.
