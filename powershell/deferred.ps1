Register-EngineEvent -SourceIdentifier PowerShell.OnIdle -MaxTriggerCount 1 -Action {
    $ResourcesPath = "$PSScriptRoot\resources"

    # unlock key vault
    $pw = Get-Content -Path "$ResourcesPath\zpw.txt" | ConvertTo-SecureString
    Unlock-SecretVault -Name ZBC1-SSKV -Password $pw
    Unlock-SecretStore -Password $pw -PasswordTimeout 3600

    # Import Modules
    Import-Module Terminal-Icons
    Import-Module posh-git
} | Out-Null
