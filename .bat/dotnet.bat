@echo off
setlocal

REM Check if dotnet.exe exists
if not exist "%programfiles%\dotnet\dotnet.exe" (
    echo dotnet.exe not found in %programfiles%\dotnet
    exit /b 1
)

REM Create a temporary batch file to run dotnet.exe with elevated privileges
set TEMP_BATCH_FILE=%TEMP%\run_dotnet_temp.bat
echo @echo off > "%TEMP_BATCH_FILE%"
echo "%programfiles%\dotnet\dotnet.exe" --version >> "%TEMP_BATCH_FILE%"

REM Run the temporary batch file as administrator
echo Running dotnet.exe with elevated privileges...
powershell -Command "Start-Process cmd -ArgumentList '/c %TEMP_BATCH_FILE%' -Verb RunAs"

REM Clean up the temporary batch file
del "%TEMP_BATCH_FILE%"

endlocal
pause