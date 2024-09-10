:: Turn echo off to hide comments
@echo off
:: Enable delayed variable expansion for more flexible variable usage
setlocal enabledelayedexpansion
:: (Re)write a CSV file for INI PATHs clickable URLs.
    if not exist ..\csv mkdir ..\csv (
        echo PATH > ..\csv\ini_files.csv
    ) else (
        (
            echo PATH
        ) > ..\csv\ini_files.csv
    )
    :: Recursively search for .ini files in C:\ and write their clickable PATHs.
    for /r C:\ %%f in (*.ini) do (
        echo file://%%f >> ..\csv\ini_files.csv'
    )

    :: End the local env
echo 'The INI files in the CSV have been updated.
exit /b 0