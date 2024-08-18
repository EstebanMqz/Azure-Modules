@echo off

:: Attempt to run the script as administrator
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo This script requires administrative privileges. Attempting to run as administrator...
    runas /user:Administrator "%~dp0%~nx0"
    exit /b
)

:: Variables 
set "taskName=DailySystemRestore" && set "taskTime=22:00"

:: Powershell script to create task for consecutive System Restore Points.
schtasks /create /tn "%taskName%" /tr "powershell.exe -ExecutionPolicy Bypass -Command \"Checkpoint-Computer -Description 'Daily Restore Point' -RestorePointType 'MODIFY_SETTINGS'\"" /sc daily /st %taskTime% /f /rl highest

:: Use PowerShell to set the WakeToRun property
powershell -Command "Get-ScheduledTask -TaskName '%taskName%' | Set-ScheduledTask -Settings (New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -WakeToRun)"

:: Confirm task creation
if %errorlevel% equ 0 (
    echo Scheduled task "%taskName%" created successfully to run daily at %taskTime%.
    :: Run the task for testing
    schtasks /run /tn "%taskName%"
    :: Open Task Scheduler
    start taskschd.msc
) else (
    echo Failed to create scheduled task "%taskName%".
)



for /F %%i in ('whoami') do set "user=%%i"

:: Give permission to the user
icacls "C:\Windows\System32\Tasks\Microsoft\Windows\SystemRestore" /grant %user%:(OI)(CI)F /t

:: Pause to view the
echo %user%
pause & echo %user%