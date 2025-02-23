## Enable WSL 2, VM Platform & Install Ubuntu 20.04 LTS

# This PowerShell script enables WSL and the Virtual Machine Platform, downloads and installs the Linux kernel update, sets WSL 2 as the default version, and checks if Ubuntu is installed. If Ubuntu is installed, it prompts the user to decide whether to reinstall it. Finally, it starts Ubuntu and opens the Microsoft Store to install Windows Terminal. The script ensures efficient setup

# Ignore: C:\Users\Esteban\Desktop\Projects\Github\Repos_To-do\Languages\Other\Repositories\Azure-Modules\.ps1\WSL_fix.ps1

# Clear the contents of .wslconfig if it exists to avoid WslRegisterDistribution errors.
$wslConfigPath = "$env:USERPROFILE\.wslconfig"
if (Test-Path -Path $wslConfigPath) {
    Clear-Content -Path $wslConfigPath
    Write-Host "Cleared the contents of .wslconfig."
}
else {
    Write-Host ".wslconfig file does not exist."
}

# Enable WSL and Virtual Machine Platform (Can be done manually in Windows Features)
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# Check and fix volumes using Repair-Volume
Write-Host "Checking and fixing volumes using Repair-Volume..."
Repair-Volume -DriveLetter C -OfflineScanAndFix

# Restart & update to WSL 2
Write-Host "Linux update will restart the PC in 3 seconds..."
Start-Sleep -Seconds 3

# Download the Linux update pkg.
$updateUrl = "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi"
$updateFile = "wsl_update_x64.msi"
Invoke-WebRequest -Uri $updateUrl -OutFile $updateFile

if (Test-Path $updateFile) {
    Start-Process -FilePath .\$updateFile -Wait
}
else {
    Write-Host "Failed to download the WSL update package."
    exit 1
}

# WSL 2: Default faster & more efficient version.
wsl.exe --set-default-version 2

# Check if Ubuntu 20.04 is already installed
$ubuntuInstalled = wsl.exe --list --verbose | Select-String -Pattern "Ubuntu-20.04" -Quiet
if ($ubuntuInstalled) {
    $response = Read-Host "Ubuntu 20.04 LTS is already installed. Do you want to reinstall it? (Y/N)"
    if ($response -eq "Y") {
        # Unregister (delete) the existing Ubuntu-20.04 installation
        wsl.exe --unregister Ubuntu-20.04
        # Install Ubuntu
        try {
            wsl.exe --install -d Ubuntu-20.04
        }
        catch {
            Write-Host "Failed to install Ubuntu 20.04 LTS. Error: $_"
            exit 1
        }
    }
    else {
        Write-Host "Skipping unregistration of Ubuntu 20.04 LTS."
    }
}
else {
    # Install Ubuntu 20.04 LTS
    try {
        wsl.exe --install -d Ubuntu-20.04
    }
    catch {
        Write-Host "Failed to install Ubuntu 20.04 LTS. Error: $_"
        exit 1
    }
}

wsl --update
shutdown /r /t 10 /f

# Start the new Linux distribution
try {
    wsl.exe -d Ubuntu-20.04
}
catch {
    Write-Host "Failed to start Ubuntu 20.04 LTS. Error: $_"
    exit 5
}

# Open the Microsoft Store to install Windows Terminal
Start-Process -FilePath "ms-windows-store://pdp/?productid=291c676"