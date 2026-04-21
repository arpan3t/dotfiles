# PSREADLINE MODS #
Import-Module c:\code\personal\psvim\ascii.psm1
Import-Module c:\code\personal\psvim\block.psm1
Import-Module c:\code\personal\psvim\buffer.psm1
Import-Module c:\code\personal\psvim\change.psm1
Import-Module c:\code\personal\psvim\handler.psm1
Import-Module c:\code\personal\psvim\line.psm1
Import-Module c:\code\personal\psvim\textobject.psm1
Import-Module c:\code\personal\psvim\token.psm1
Import-Module c:\code\personal\psvim\word.psm1
Import-Module c:\code\personal\psvim\yank.psm1


# Prompt
Set-PSReadLineOption -ContinuationPrompt '   '

# Vi Mode
Set-PSReadLineOption -EditMode Vi

function OnViModeChange {
    if ($args[0] -eq 'Command') {
        # Set the cursor to a blinking block.
        Write-Host -NoNewLine "`e[2 q"
    }
    else {
        # Set the cursor to a blinking line.
        Write-Host -NoNewLine "`e[3 q"
    }
}

Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler $Function:OnViModeChange

# VIM - change operation
Set-PSReadLineKeyHandler -Chord 'c' -ViMode Command -ScriptBlock {
    param ($Key, $Arg)
    $ChangeParams = @{ Operation = 'c' }
    $NextKeyChar  = ([console]::ReadKey($true)).KeyChar

    if ($NextKeyChar -eq "a" -or $NextKeyChar -eq "i") {
        $MotionKeyChar = ([console]::ReadKey($true)).KeyChar
        $ChangeParams.Add("Selection", $NextKeyChar)
        $ChangeParams.Add("Motion",  $MotionKeyChar)
    }
    else {
        $ChangeParams.Add("Motion", $NextKeyChar)
    }

    $BufferState = Get-BufferState
    $ChangeParams.Add("BufferState", $BufferState)

    ($Arg -is [int]) ? ($ChangeParams.Add("Count", $Arg)) : ($null)

    Invoke-VimHandler @ChangeParams
}

# VIM - delete operation
Set-PSReadLineKeyHandler -Chord 'd' -ViMode Command -ScriptBlock {
    param ($Key, $Arg)
    $DeleteParams = @{ Operation = 'd' }
    $NextKeyChar  = ([console]::ReadKey($true)).KeyChar

    if ($NextKeyChar -eq "a" -or $NextKeyChar -eq "i") {
        $MotionKeyChar = ([console]::ReadKey($true)).KeyChar
        $DeleteParams.Add("Selection", $NextKeyChar)
        $DeleteParams.Add("Motion",  $MotionKeyChar)
    }
    else {
        $DeleteParams.Add("Motion", $NextKeyChar)
    }

    $BufferState = Get-BufferState
    $DeleteParams.Add("BufferState", $BufferState)

    ($Arg -is [int]) ? ($DeleteParams.Add("Count", $Arg)) : ($null)

    Invoke-VimHandler @DeleteParams
}

# VIM - yank operation
Set-PSReadLineKeyHandler -Chord 'y' -ViMode Command -ScriptBlock {
    param ($Key, $Arg)
    $YankParams  = @{ Operation = 'y' }
    $NextKeyChar = ([console]::ReadKey($true)).KeyChar

    if ($NextKeyChar -eq "a" -or $NextKeyChar -eq "i") {
        $MotionKeyChar = ([console]::ReadKey($true)).KeyChar
        $YankParams.Add("Selection", $NextKeyChar)
        $YankParams.Add("Motion",  $MotionKeyChar)
    }
    else {
        $YankParams.Add("Motion", $NextKeyChar)
    }

    $BufferState = Get-BufferState
    $YankParams.Add("BufferState", $BufferState)

    ($Arg -is [int]) ? ($YankParams.Add("Count", $Arg)) : ($null)

    Invoke-VimHandler @YankParams
}
# VIM - word motion
Set-PSReadLineKeyHandler -Chord 'w' -ViMode Command -ScriptBlock {
    param ($Key, $Arg)
    $Global:BufferState = $BufferState = Get-BufferState
    $MotionParams  = @{
        BufferState = $BufferState
        Motion      = 'w'
    }

    ($Arg -is [int]) ? ($MotionParams.Add("Count", $Arg)) : ($null)

    Invoke-VimHandler @MotionParams
}
Set-PSReadLineKeyHandler -Chord 'W' -ViMode Command -ScriptBlock {
    param ($Key, $Arg)
    $Global:BufferState = $BufferState = Get-BufferState
    $MotionParams  = @{
        BufferState = $BufferState
        Motion      = 'W'
    }

    ($Arg -is [int]) ? ($MotionParams.Add("Count", $Arg)) : ($null)

    Invoke-VimHandler @MotionParams
}
Set-PSReadLineKeyHandler -Chord 'b' -ViMode Command -ScriptBlock {
    param ($Key, $Arg)
    $Global:BufferState = $BufferState = Get-BufferState
    $MotionParams  = @{
        BufferState = $BufferState
        Motion      = 'b'
    }

    ($Arg -is [int]) ? ($MotionParams.Add("Count", $Arg)) : ($null)

    Invoke-VimHandler @MotionParams
}
Set-PSReadLineKeyHandler -Chord 'B' -ViMode Command -ScriptBlock {
    param ($Key, $Arg)
    $Global:BufferState = $BufferState = Get-BufferState
    $MotionParams  = @{
        BufferState = $BufferState
        Motion      = 'B'
    }

    ($Arg -is [int]) ? ($MotionParams.Add("Count", $Arg)) : ($null)

    Invoke-VimHandler @MotionParams
}
Set-PSReadLineKeyHandler -Chord 'e' -ViMode Command -ScriptBlock {
    param ($Key, $Arg)
    $Global:BufferState = $BufferState = Get-BufferState
    $MotionParams  = @{
        BufferState = $BufferState
        Motion      = 'e'
    }

    ($Arg -is [int]) ? ($MotionParams.Add("Count", $Arg)) : ($null)

    Invoke-VimHandler @MotionParams
}
Set-PSReadLineKeyHandler -Chord 'E' -ViMode Command -ScriptBlock {
    param ($Key, $Arg)
    $Global:BufferState = $BufferState = Get-BufferState
    $MotionParams  = @{
        BufferState = $BufferState
        Motion      = 'E'
    }

    ($Arg -is [int]) ? ($MotionParams.Add("Count", $Arg)) : ($null)

    Invoke-VimHandler @MotionParams
}

# Sets tab to handle line indentation for multi-line prompts
Set-PSReadLineKeyHandler -Chord 'Tab' -ViMode Insert -ScriptBlock {
    $Buffer = $null
    $Cursor = $null

    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$Buffer, [ref]$Cursor)

    $PrevChar = $Cursor - 1
    $BufferArray = $Buffer.ToCharArray()
    if ($BufferArray[$PrevChar] -eq "`n") {
        $Indent = "    "
        [Microsoft.PowerShell.PSConsoleReadLine]::Insert($Indent)
        $ReadKey = [Console]::ReadKey($true)
        $KeyValue = $ReadKey.KeyChar
        $Esc = $false
        while (!$Esc) {
            switch ($KeyValue) {
                "`t" {
                    [Microsoft.PowerShell.PSConsoleReadLine]::Insert($Indent)
                    $ReadKey = [Console]::ReadKey($true)
                    $KeyValue = $ReadKey.KeyChar
                }
                "`b" {
                    [Microsoft.PowerShell.PSConsoleReadLine]::Undo()
                    $ReadKey = [Console]::ReadKey($true)
                    $KeyValue = $ReadKey.KeyChar
                }
                "`r" {
                    [Microsoft.PowerShell.PSConsoleReadLine]::InsertLineBelow()
                    $Esc = $true
                }
                Default {
                    [Microsoft.PowerShell.PSConsoleReadLine]::Insert($KeyValue)
                    $Esc = $true
                }
            }
        }
    }
    else {
        [Microsoft.PowerShell.PSConsoleReadLine]::ViTabCompleteNext()
    }
}

# Captures current buffer attributes for testing
Set-PSReadLineKeyHandler -Chord 'Alt+l' -ViMode Command -ScriptBlock {
    $Global:Bufferstate = Get-BufferState
}

# Start to emulate Vim select mode
Set-PSReadLineKeyHandler -Chord v -ViMode Command -ScriptBlock {
    $Buffer = $null
    $Cursor = $null

    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$Buffer, [ref]$Cursor)

    $NextChar = $Cursor + 1

    [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($NextChar)
    [Microsoft.PowerShell.PSConsoleReadLine]::SelectBackwardChar()

    $ReadKey = [Console]::ReadKey($true)
    $KeyValue = $ReadKey.KeyChar
    $Esc = $false

    while (!$Esc) {
        switch ($KeyValue) {
            'h' {
                [Microsoft.PowerShell.PSConsoleReadLine]::SelectBackwardChar()
                $ReadKey = [Console]::ReadKey($true)
                $KeyValue = $ReadKey.KeyChar
            }
            'l' {
                [Microsoft.PowerShell.PSConsoleReadLine]::SelectForwardChar()
                $ReadKey = [Console]::ReadKey($true)
                $KeyValue = $ReadKey.KeyChar
            }
            'b' {
                [Microsoft.PowerShell.PSConsoleReadLine]::SelectBackwardWord()
                $ReadKey = [Console]::ReadKey($true)
                $KeyValue = $ReadKey.KeyChar
            }
            'w' {
                [Microsoft.PowerShell.PSConsoleReadLine]::SelectForwardWord()
                $ReadKey = [Console]::ReadKey($true)
                $KeyValue = $ReadKey.KeyChar
            }
            'd' {
                $Start = $null
                $Length = $null
                [Microsoft.PowerShell.PSConsoleReadLine]::GetSelectionState([ref]$Start, [ref]$Length)
                [Microsoft.PowerShell.PSConsoleReadLine]::Delete($Start, $Length)
                [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($Start)
                [Microsoft.PowerShell.PSConsoleReadLine]::ViInsertMode()
                [Microsoft.PowerShell.PSConsoleReadLine]::ViCommandMode()
                $Esc = $true
            }
            'y' {
                $Start = $null
                $Length = $null
                [Microsoft.PowerShell.PSConsoleReadLine]::GetSelectionState([ref]$Start, [ref]$Length)
                [Microsoft.PowerShell.PSConsoleReadLine]::CopyOrCancelLine()
                [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($Start)
                [Microsoft.PowerShell.PSConsoleReadLine]::ViInsertMode()
                [Microsoft.PowerShell.PSConsoleReadLine]::ViCommandMode()
                $Esc = $true
            }
            'x' {
                $Start = $null
                $Length = $null
                [Microsoft.PowerShell.PSConsoleReadLine]::GetSelectionState([ref]$Start, [ref]$Length)
                [Microsoft.PowerShell.PSConsoleReadLine]::Cut()
                [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($Start)
                [Microsoft.PowerShell.PSConsoleReadLine]::ViInsertMode()
                [Microsoft.PowerShell.PSConsoleReadLine]::ViCommandMode()
                $Esc = $true
            }
            Default {
                [Microsoft.PowerShell.PSConsoleReadLine]::ViInsertMode()
                $Esc = $true
            }
        }
    }
}

Set-PSReadLineKeyHandler -Chord 'V' -ViMode Command -ScriptBlock {
    $Buffer = $null
    $Cursor = $null

    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$Buffer, [ref]$Cursor)

    [Microsoft.PowerShell.PSConsoleReadLine]::BeginningOfLine()
    [Microsoft.PowerShell.PSConsoleReadLine]::SelectLine()

    $ReadKey = [Console]::ReadKey($true)
    $KeyValue = $ReadKey.KeyChar
    $Esc = $false

    while (!$Esc) {
        switch ($KeyValue) {
            'j' {
                [Microsoft.PowerShell.PSConsoleReadLine]::SelectForwardWord()
                [Microsoft.PowerShell.PSConsoleReadLine]::SelectLine()
                $ReadKey = [Console]::ReadKey($true)
                $KeyValue = $ReadKey.KeyChar
            }
            'k' {
                [Microsoft.PowerShell.PSConsoleReadLine]::SelectBackwardsLine()
                [Microsoft.PowerShell.PSConsoleReadLine]::SelectBackwardChar()
                [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$Buffer, [ref]$Cursor)
                $ReadKey = [Console]::ReadKey($true)
                $KeyValue = $ReadKey.KeyChar
            }
            'b' {
                [Microsoft.PowerShell.PSConsoleReadLine]::SelectBackwardWord()
                $ReadKey = [Console]::ReadKey($true)
                $KeyValue = $ReadKey.KeyChar
            }
            'w' {
                [Microsoft.PowerShell.PSConsoleReadLine]::SelectForwardWord()
                $ReadKey = [Console]::ReadKey($true)
                $KeyValue = $ReadKey.KeyChar
            }
            'd' {
                $Start = $null
                $Length = $null
                [Microsoft.PowerShell.PSConsoleReadLine]::GetSelectionState([ref]$Start, [ref]$Length)
                [Microsoft.PowerShell.PSConsoleReadLine]::Delete($Start, $Length)
                [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($Start)
                [Microsoft.PowerShell.PSConsoleReadLine]::ViInsertMode()
                [Microsoft.PowerShell.PSConsoleReadLine]::ViCommandMode()
                $Esc = $true
            }
            'y' {
                $Start = $null
                $Length = $null
                [Microsoft.PowerShell.PSConsoleReadLine]::GetSelectionState([ref]$Start, [ref]$Length)
                [Microsoft.PowerShell.PSConsoleReadLine]::CopyOrCancelLine()
                [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($Start)
                [Microsoft.PowerShell.PSConsoleReadLine]::ViInsertMode()
                [Microsoft.PowerShell.PSConsoleReadLine]::ViCommandMode()
                $Esc = $true
            }
            'x' {
                $Start = $null
                $Length = $null
                [Microsoft.PowerShell.PSConsoleReadLine]::GetSelectionState([ref]$Start, [ref]$Length)
                [Microsoft.PowerShell.PSConsoleReadLine]::Cut()
                [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($Start)
                [Microsoft.PowerShell.PSConsoleReadLine]::ViInsertMode()
                [Microsoft.PowerShell.PSConsoleReadLine]::ViCommandMode()
                $Esc = $true
            }
            Default {
                [Microsoft.PowerShell.PSConsoleReadLine]::ViInsertMode()
                $Esc = $true
            }
        }
    }
}

# Escape Insert Mode
$PsReadlineStopwatch = [System.Diagnostics.Stopwatch]::new()

Set-PSReadLineKeyHandler -Key j -ViMode Insert -ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert("j")
    $PsReadlineStopwatch.Restart()
}

Set-PSReadLineKeyHandler -Key k -ViMode Insert -ScriptBlock {
    $ElapsedMs = $PsReadlineStopwatch.ElapsedMilliseconds

    if (!$PsReadlineStopwatch.IsRunning -or ($ElapsedMs -lt 20 -or $ElapsedMs -gt 1000)) {
        [Microsoft.PowerShell.PSConsoleReadLine]::Insert("k")
    }
    else {
        [Microsoft.PowerShell.PSConsoleReadLine]::Undo()
        [Microsoft.PowerShell.PSConsoleReadLine]::ViCommandMode()
    }
}

