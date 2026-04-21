# HELPER FUNCTIONS #

# Zoxide
Invoke-Expression (& { (zoxide init powershell | Out-String) })

function Disable-LaptopKeyboard {
    $LaptopKeyboard = Get-PnpDevice -InstanceId 'ACPI\DLLK0B1A\4&34C2B845&0'
    pnputil /remove-device $LaptopKeyboard.InstanceId
    logoff
}
function New-Password {
    <#
    .SYNOPSIS
    This function generates a random password.
    .PARAMETER AsSecureString
    This switch parameter will return the password as a secure string.
    .PARAMETER Length
    The length of the password to generate.
    .EXAMPLE
    New-Password -Length 16 -AsSecureString
    #>
    param (
        [Parameter()]
        [switch] $AsSecureString,
        [Parameter()]
        [ValidateRange(1,1000)]
        [int] $Length = 16
    )
    $NonAlphaChars = @(0x21,0x23,0x24,0x25,0x26,0x2A,0x2B,0x3F,0x40)
    $CharSet = ((0x30..0x39) + ( 0x41..0x5A) + ( 0x61..0x7A) + $NonAlphaChars)
    $RNG = [System.Security.Cryptography.RandomNumberGenerator]::Create()
    $Password = [System.Collections.ArrayList]::new()
    while ($Password.Count -lt $Length) {
        $RngByte = [byte[]]::CreateInstance([byte], 1)
        $RNG.GetBytes($RngByte) 
        if ($CharSet -contains [int]$RngByte[0]){
            $Password.Add([char]$RngByte[0]) | Out-Null
        }
    }
    if ($AsSecureString) {
        return -join $Password | ConvertTo-SecureString -AsPlainText -Force
    }
    else {
        return -join $Password
    }
}
function ConvertFrom-Base64($Base64) {
    return [System.Text.Encoding]::ASCII.GetString([System.Convert]::FromBase64String($Base64))
}

function ConvertTo-Base64($Plain) {
    return [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes($Plain))
}
