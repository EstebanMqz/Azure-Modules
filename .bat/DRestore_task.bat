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