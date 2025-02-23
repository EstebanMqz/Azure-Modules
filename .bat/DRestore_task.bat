
:: Elevated PowerShell script to create a 'DailySystemRestore' point at '22:00'.

Rem Daily System Restore Point Automatic Task
@echo off

:: Access network to verify admin. priv.
net session >nul 2>&1
if %errorlevel% neq 0 (
    :: If not, run it as admin.
    echo This script requires administrative privileges. Attempting to run as administrator...
    runas /user:Administrator "%~dp0%~nx0"
    exit /b
)

:: Define vars for name and time.
set "taskName=DailySystemRestore" && set "taskTime=13:18"

:: Create a scheduled task to run a PowerShell command for creating a Daily System Restore point.
schtasks /create /tn "%taskName%" /tr "powershell.exe -ExecutionPolicy Bypass -Command \"Checkpoint-Computer -Description 'Daily Restore Point' -RestorePointType 'MODIFY_SETTINGS'\"" /sc daily /st %taskTime% /f /rl highest

:: Check if the task creation was successful.
if %errorlevel% equ 0 (
    echo Test Passed: Scheduled task "%taskName%" created successfully.
    : Set the WakeToRun property using PowerShell.
    powershell -Command "$task = Get-ScheduledTask -TaskName '%taskName%'; $task.Settings.WakeToRun = $true; Set-ScheduledTask -InputObject $task" 
    :: Run the task for testing.
    schtasks /run /tn "%taskName%"
    :: Verify if the task ran successfully.
    if %errorlevel% equ 0 (
        echo Test Passed: Scheduled task "%taskName%" ran successfully.
    ) else (
        echo Test Failed: Scheduled task "%taskName%" did not run successfully.
    )
    : Send PC to sleep after confirmation.
    powercfg -h on
    : Retrieve and display the hibernation file size and the exact PATH location
    dir %SYSTEMDRIVE%\hiberfil.sys /A: /S /Q
) else (
    echo Test Failed: Failed to create scheduled task "%taskName%".
)

pause

:: Documentation:
:: /create: Creates a new scheduled task
:: /tn: Task name.
:: /tr: Task to run. 
:: /sc: Daily schedule.
:: /st: Start time
:: /f: Forces task creation
:: /rl:  Highest priv. run level
:: schtasks: Manage tasks
:: /run: Run the task
:: /h: Hibernate
:: /A: Attributes
:: /S: Subdirectories
:: /Q: Display file ownership

: PATH: %windir%\System32\Tasks\
: Run: DRestore_task.bat