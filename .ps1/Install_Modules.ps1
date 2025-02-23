# Description: Install 895 modules containing "Az" from PS Gallery.
#PowerShellGet module for installing modules as Admin.
Start-Process -Verb runAs #PS with Admin rights.
Import-Module PowerShellGet -Force -Scope Local 
#PS Gallery VM modules installation. 
$VMModules = Find-Module -Name *VM* -Repository PSGallery  # Find modules with "Az" in their names
# Check if any modules were found
if ($VMModules) {
    foreach ($module in $VMModules) {
        try {
            Install-Module -Name $module.Name -Repository PSGallery -Force -AllowClobber  # Install each module
            Write-Host "Successfully installed module: $($module.Name)"  # Output success message
        }
        catch {
            Write-Host "Failed to install module: $($module.Name). Error: $_"  # Output error message
        }
    }
}
else { Write-Host "No modules found with names containing 'Az' in the PS Gallery." }  

#Count the $VMModules array len.
echo $VMModules.Length
