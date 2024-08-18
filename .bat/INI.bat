@echo off
setlocal enabledelayedexpansion

REM Create the csv subdirectory if it doesn't exist
if not exist ..\csv mkdir ..\csv

REM Initialize the CSV file in the csv subdirectory
echo URL > ..\csv\ini_files.csv

REM Search for .ini files and append their paths and URLs to the CSV file
for /r C:\ %%f in (*.ini) do (
    echo file://%%f >> ..\csv\ini_files.csv
)
echo '.ini files written to .csv\ini_files.csv'
exit 
