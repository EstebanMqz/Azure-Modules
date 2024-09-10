
:: Elevated PowerShell script to create a 'DailySystemRestore' at '22:00'.

:: The WakeToRun property for the scheduled task is set using PowerShell.
:: If the task creation is successful, the script confirms the task creation, runs the task for testing, and opens Task Scheduler.
:: If the task creation fails, an error message is displayed.
:: The current user is obtained and granted full permissions to the SystemRestore task folder.
:: The script then displays the current user and pauses execution.

@echo off
:: Check if the script is running as an administrator by attempting to access a network session
net session >nul 2>&1
if %errorlevel% neq 0 (
    :: If not running as administrator, attempt to run the script as administrator
    echo This script requires administrative privileges. Attempting to run as administrator...
    runas /user:Administrator "%~dp0%~nx0"
    exit /b
)
:: Define variables for the task name and time
set "taskName=DailySystemRestore" && set "taskTime=22:00"
:: Create a scheduled task to run a PowerShell command for creating a daily system restore point
schtasks /create /tn "%taskName%" /tr "powershell.exe -ExecutionPolicy Bypass -Command \"Checkpoint-Computer -Description 'Daily Restore Point' -RestorePointType 'MODIFY_SETTINGS'\"" /sc daily /st %taskTime% /f /rl highest
:: Use PowerShell to set the WakeToRun property for the scheduled task
powershell -Command "$task = Get-ScheduledTask -TaskName '%taskName%'; Set-ScheduledTask -TaskName $task.TaskName -Settings (New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -WakeToRun)"
:: Check if the task creation was successful
if %errorlevel% equ 0 (
    :: If successful, confirm task creation and run the task for testing
    echo Scheduled task "%taskName%" created successfully to run daily at %taskTime%.
    schtasks /run /tn "%taskName%"
    :: Open Task Scheduler
    start taskschd.msc
) else (
    :: If failed, display an error message
    echo Failed to create scheduled task "%taskName%".
)
:: Get the current user and store it in the "user" variable
for /F %%i in ('whoami') do set "user=%%i"
:: Grant the current user full permissions to the SystemRestore task folder
icacls "C:\Windows\System32\Tasks\Microsoft\Windows\SystemRestore" /grant %user%:(OI)(CI)F /t
:: Display the current user and pause the script
pause && echo %windir%\System32\Tasks\
runas /user:Administrator -eq "WakeToRun" -and $Value -eq $true