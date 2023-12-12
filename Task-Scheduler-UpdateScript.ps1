# Define the path to your PowerShell script
$scriptPath = "C:\stash\dr-greenwalt-automation-main\Get-Latest-Changes-Daily.ps1"

# Define the action for the task (run a PowerShell script)
$action = New-ScheduledTaskAction -Execute 'PowerShell.exe' -Argument "-NoProfile -ExecutionPolicy Bypass -File $scriptPath"

# Define the trigger for the task (daily at 7:30 pm)
$trigger = New-ScheduledTaskTrigger -Daily -At "7:00pm"

# Define the settings for the task (wake the computer to run)
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -DontStopIfGoingOffIdle

# Register the task with Task Scheduler
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "Frank-dr-greenwalt-automationupdate" -TaskPath "\" -Settings $settings

# Set the task to wake the computer
Set-ScheduledTask -TaskName "Frank-dr-greenwalt-automationupdate" -WakeToRun $true

# Optional: Display a confirmation message
Write-Host "Scheduled task 'Frank-dr-greenwalt-automationupdate' has been created."
