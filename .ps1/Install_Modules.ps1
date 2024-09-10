# Description: Install 895 modules containing "Az" from PS Gallery.

# Import the PowerShellGet module for installing modules as Admin.
Start-Process powershell -Verb runAs #Admin
Import-Module PowerShellGet -Force -Scope Local #PowerShellGet Installation Module.
# Get modules with names containing "Az" in the PS Gallery
$azModules = Find-Module -Name *Az* -Repository PSGallery

# Check if any modules were found
if ($azModules) {
    foreach ($module in $azModules) {
        try {
            Install-Module -Name $module.Name -Repository PSGallery -Force -AllowClobber # Install each module
            Write-Host "Successfully installed module: $($module.Name)"
        }
        catch {
            Write-Host "Failed to install module: $($module.Name). Error: $_"
        }
    }
}