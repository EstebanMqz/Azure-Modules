#Description: Modules_cmdlets.ps1 Lists all modules in the PSModulePaths and their exported commands to a .CSV file.

Set-ExecutionPolicy Unrestricted -Scope Process -Force

$cwd = Get-Location #Get the current working directory
if (-Not (Test-Path "$cwd\..\.csv")) {
    New-Item -Path "$cwd\..\.csv" -ItemType Directory
} #Create a .csv directory if it doesn't exist in the parent directory.

$ModulePaths = $env:PSModulePath -split ';'
$data = @()

foreach ($Path in $ModulePaths) {
    $data += [PSCustomObject]@{
        Type    = 'Path'
        Name    = $Path
        Command = ''
    }
} #Have the Module Command & Descriptions made for each cmdlet


# Get all available modules
$availableModules = Get-Module -ListAvailable

# Iterate through each module and get its commands
foreach ($module in $availableModules) {
    # Add module to the data list
    $data += [PSCustomObject]@{
        Type    = 'Module'
        Name    = $module.Name
        Command = ''
    }

    # Add commands to the data list
    foreach ($command in $module.ExportedCommands.Keys) {
        $commandObject = $module.ExportedCommands[$command]
        $data += [PSCustomObject]@{
            Type    = 'Command'
            Name    = $module.Name
            #Have the cmdlets help function retrieved after "Description:"
            Command = "${command}: (Description: $($commandObject.DetailedDescription))"
        }
    }
}

# Export the data to a CSV file
# Parent directory 
$parentDir = Split-Path -Parent $PSScriptRoot

# Define the path for the .csv.
$csvDir = Join-Path -Path $parentDir -ChildPath '.csv'

# If it doesn't exist, create it.
if (-not (Test-Path -Path $csvDir)) {
    New-Item -Path $csvDir -ItemType Directory
}

# Define the path for the CSV file in the .csv subdirectory
$csvFilePath = Join-Path -Path $csvDir -ChildPath 'ModulesAndCommands.csv'

# Export the data to the CSV file
$data | Export-Csv -Path $csvFilePath -NoTypeInformation -Force

#The CSV file is created in the .csv directory
Write-Host "The CSV file has been created at: ..$csvFilePath"