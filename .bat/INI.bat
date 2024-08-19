@echo off
::Description: This script will search for all .ini in C:\ and write PATHs to a csv subdir.
::No output in terminal from loop.
::'!' Not required for vars.
setlocal enabledelayedexpansion 
REM Create the .CSV subdir if needed.
if not exist ..\.csv mkdir ..\.csv
    echo URL > ..\.csv\ini_files.csv
    REM Search for .ini files & append PATHs in .CSV.
    for /r C:\ %%f in (*.ini) do (
        echo file://%%f >> ..\.csv\ini_files.csv
        REM No output in terminal   
    )

echo '.ini files written to .csv\ini_files.csv'
exit /b 0 rem End of script if no errors.



