# Description: This script runs with elevated privileges, counts & lists modules installed on system.
function Unlock-File {
    param (
        [Parameter(Mandatory = $true)]
        [string]$FilePath
    )

    try {
        $file = [System.IO.File]::Open($FilePath, 'Open', 'ReadWrite', 'None')
        $file.Close()
        Write-Host "File unlocked successfully."
    }
    catch {
        Write-Host "Failed to unlock file: $_"
    }
}

(Set-ExecutionPolicy Unrestricted -Scope Process -Force -ErrorAction SilentlyContinue -WarningAction SilentlyContinue) # Set the execution policy to Unrestricted for process.
$cwd = Get-Location #Get the cwd PATH.
if (-Not (Test-Path "$cwd\..\.csv")) {
    New-Item -Path "$cwd\..\.csv" -ItemType Directory
} #Create a .csv directory if it doesn't exist in the $ParentDir.

$modulePaths = $env:PSModulePath -split ';' # Get the module paths
$data = @()  # Initialize an empty array to store data

foreach ($Path in $ModulePaths) {
    $data += [PSCustomObject]@{
        Type    = 'Path'
        Name    = $Path
        Command = ''
    }
}

#Get ALL available modules.
Get-Module -ListAvailable -ErrorAction SilentlyContinue -WarningAction SilentlyContinue

$moduleCount = 0  # Initialize the module count to 0

foreach ($path in $modulePaths) {
    # Loop through each module path
    if ($path -and (Test-Path $path)) {
        # Check if the path is valid and exists
        $modules = Get-ChildItem -Path $path -Directory  # Get directories in the current path
        $moduleCount += $modules.Count  # Increment the module count       
        foreach ($module in $modules) {
            # Add each module to the data array
            $data += [PSCustomObject]@{
                Count = ++$moduleCount
                Name  = $module.Name
                Path  = $module.FullName
            }
        }
    }
}

Unlock-File -FilePath "$cwd\..\.csv\Modules.csv" # Unlock the file before writing.
# Parent directory CSV export
$parentDir = Split-Path -Parent $PSScriptRoot # Root directory.
$csvDir = Join-Path -Path $parentDir -ChildPath '.csv' # Path to the .csv subdirectory
$csvFilePath = Join-Path -Path $csvDir 'Modules.csv'

$data | Export-Csv -Path $csvFilePath -NoTypeInformation -Forc
Write-Host "Total number of modules in all paths:"  # Display the results.

Write-Host $moduleCount "Installed modules:"  
$data | Format-Table -AutoSize  # List installed modules

if (-not (Test-Path -Path $csvDir)) {
    # Create it if needed.
    New-Item -Path $csvDir -ItemType Directory  
    # Creation of the .csv subdir.
}
$csvFilePath = Join-Path -Path $csvDir 'Modules.csv' 
$data | Export-Csv -Path $csvFilePath -NoTypeInformation -Force

$url = "https://download.sysinternals.com/files/SysinternalsSuite.zip"
$destination = "C:\Users\Esteban\Downloads\SysInternalSuite.zip"
$extractPath = "C:\Users\Esteban\Downloads\SysInternalSuite"  
$zipFile = "C:\Users\Esteban\Downloads\SysInternalSuite.zip" 
Invoke-WebRequest -Uri $url -OutFile $destination ; Expand-Archive -Path $zipFile -DestinationPath $extractPath ; Remove-Item -Path $zipFile