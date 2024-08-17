#Retrieves the paths of the all PowerShell modules Paths and cmdlets in modules that can be loaded from any PS session.

# Get the module paths
$ModulePaths = $env:PSModulePath -split ';'

# Create a list to store the data
$data = @()

# Add paths to the data list
foreach ($Path in $ModulePaths) {
    $data += [PSCustomObject]@{
        Type    = 'Path'
        Name    = $Path
        Command = ''
    }
}

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
            Command = "${command}: (Description: $($commandObject.Definition))"
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

