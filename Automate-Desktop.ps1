
function Click-mouse {
    $LeftButtonDown = 0x00000002
    $LeftButtonUp = 0x00000004

    $signature = @"
        [DllImport("user32.dll")]
        public static extern void mouse_event(uint dwFlags, int dx, int dy, uint dwData, IntPtr dwExtraInfo);
"@

    $SendMouseClick = Add-Type -MemberDefinition $signature -Name "SendMouseClick" -Namespace "Win32" -PassThru

    $SendMouseClick::mouse_event($LeftButtonDown, 0, 0, 0, 0)
    $SendMouseClick::mouse_event($LeftButtonUp, 0, 0, 0, 0)
}


function Move-MouseSlowly {
    param (
        [int]$TargetX,
        [int]$TargetY,
        [int]$Speed = 10
    )

    Add-Type -TypeDefinition @"
        using System;
        using System.Runtime.InteropServices;
        public class Mouse {
            [DllImport("user32.dll")]
            public static extern bool SetCursorPos(int x, int y);
        }
"@

    $CurrentX = [System.Windows.Forms.Cursor]::Position.X
    $CurrentY = [System.Windows.Forms.Cursor]::Position.Y

    $DeltaX = $TargetX - $CurrentX
    $DeltaY = $TargetY - $CurrentY

    $StepsX = [Math]::Abs($DeltaX) / $Speed
    $StepsY = [Math]::Abs($DeltaY) / $Speed

    $StepX = if ($DeltaX -lt 0) { -$Speed } else { $Speed }
    $StepY = if ($DeltaY -lt 0) { -$Speed } else { $Speed }

    for ($i = 1; $i -le $StepsX; $i++) {
        $CurrentX += $StepX
        [void][Mouse]::SetCursorPos($CurrentX, $CurrentY)
        Start-Sleep -Milliseconds 10
    }

    for ($i = 1; $i -le $StepsY; $i++) {
        $CurrentY += $StepY
        [void][Mouse]::SetCursorPos($CurrentX, $CurrentY)
        Start-Sleep -Milliseconds 10
    }

    [void][Mouse]::SetCursorPos($TargetX, $TargetY) # final positioning
}

function Send-Keys {
    param (
        [string]$keys
    )

    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.SendKeys]::SendWait($keys)
}

#Import Credentials
. "C:\stash\credentials\credentials.ps1"

# Start the Citrix Self Service Plugin
Start-Process -WorkingDirectory 'C:\Program Files (x86)\Citrix\ICA Client\SelfServicePlugin\' -FilePath .\SelfService.exe

# Clicks on Icon
Start-Sleep -Seconds 6
Move-MouseSlowly -TargetX 780 -TargetY 450 -Speed 5
Click-mouse

# Clicks on OK on Notice
Start-Sleep -Seconds 10
Move-MouseSlowly -TargetX 750 -TargetY 720 -Speed 5
Click-mouse
Start-Sleep -Seconds 10

# Clicks on Username field
Move-MouseSlowly -TargetX 915 -TargetY 553 -Speed 5
Click-mouse
Send-Keys $username
Start-Sleep -Seconds 2

# Clicks on Password field
Move-MouseSlowly -TargetX 911 -TargetY 582 -Speed 5
Start-Sleep -Seconds 1
Click-mouse
Send-Keys $password

#Click Ok button
Start-Sleep -Seconds 2
Move-MouseSlowly -TargetX 922 -TargetY 615 -Speed 5
Click-mouse



