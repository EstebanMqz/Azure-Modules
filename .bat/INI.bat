@echo on
:: This script will search for all .ini in C:\ and write PATHs to a csv subdir.
setlocal enabledelayedexpansion

REM Create the csv subdirectory if it doesn't exist
if not exist ..\csv mkdir ..\csv
    echo URL > ..\csv\ini_files.csv

    REM Search for .ini files and append their paths and URLs to the CSV file
    for /r C:\ %%f in (*.ini) do (
        echo file://%%f >> ..\csv\ini_files.csv
        timeout /t 3 /nobreak >nul
    )
    
echo '.ini files written to .csv\ini_files.csv'
exit /b 0

