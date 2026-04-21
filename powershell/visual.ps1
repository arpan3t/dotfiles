# VISUAL MODS #
$ResourcePath = "$PSScriptRoot\resources"

$Term = (Get-Process -Id $PID).Parent.ProcessName

# Tab Color
if ($Term -ne 'wezterm-gui') {
    $TabColorNum = Get-Random -Minimum 1 -Maximum 16
    $TabColor = "`e[2;15;{0},|" -f $TabColorNum
    Write-Host $TabColor
}

# Oh-My-Posh
oh-my-posh init pwsh --config "$ResourcePath\zbtheme.omp.json" | Invoke-Expression

# Morning Banner
$CutoffTime = '9:00:00 AM'
if ((Get-Date) -lt $CutoffTime) {
    Get-Content -Path "$ResourcePath\banner.txt" | Write-Output
}

# PSReadLine Color Scheme
$ColorScheme = . "$PSScriptRoot\colorscheme.ps1"
Set-PSReadLineOption -Colors $ColorScheme
