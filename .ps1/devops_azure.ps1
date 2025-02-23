# Description: Boxstarter Script
# Author: Microsoft
# Common settings for azure devops

Disable-UAC

# Get the base URI path from the ScriptToCall value
$bstrappackage = "-bootstrapPackage"
$helperUri = $Boxstarter['ScriptToCall']
$strpos = $helperUri.IndexOf($bstrappackage)
$helperUri = $helperUri.Substring($strpos + $bstrappackage.Length)
$helperUri = $helperUri.TrimStart("'", " ")
$helperUri = $helperUri.TrimEnd("'", " ")
$helperUri = $helperUri.Substring(0, $helperUri.LastIndexOf("/"))
$helperUri += "/scripts"
Write-Host "helper script base URI is $helperUri"

function executeScript {
    Param ([string]$script)
    Write-Host "executing $helperUri/$script ..."
    iex ((New-Object net.webclient).DownloadString("$helperUri/$script"))
}

#--- Setting up Windows ---
executeScript "subdir/FileExplorerSettings.ps1";
executeScript "subdir/SystemConfiguration.ps1";
executeScript "subdir/RemoveDefaultApps.ps1";
executeScript "subdir/WSL.ps1";
executeScript "subdir/HyperV.ps1";
executeScript "subdir/Docker.ps1";
executeScript "subdir/Browsers.ps1";

# TODO: Expand on tools/configuration options here
# Azure CLI, Azure PS, Azure SDK, Ansible, TerraForms

Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula
