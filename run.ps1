$root = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $root
Write-Host "Starting Roblox Profile Website on http://localhost:8080"
Start-Process powershell -ArgumentList '-NoExit','-Command',"Set-Location '$root'; py -m http.server 8080"
Start-Sleep -Seconds 2
Start-Process 'http://localhost:8080/index.html'
