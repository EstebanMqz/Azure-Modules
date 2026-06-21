# Azure PowerShell (Az) Command Reference

## 1. Authentication & Account
Essential for starting your session and managing multiple subscriptions.

- `Connect-AzAccount`: Interactive login to your Azure account.
- `Get-AzSubscription`: Lists all subscriptions available to your account.
- `Set-AzContext -SubscriptionId <ID>`: Switches the active subscription for the current session.
- `Disconnect-AzAccount`: Logs out of the current session.

## 2. Global Configuration
Use these to customize module behavior (useful for CI/CD environments).

- `Get-AzConfig`: View all current Azure PowerShell configurations.
- `Update-AzConfig -DisplaySecretsWarning $false`: Disables warnings when secrets are output to the console.
- `Update-AzConfig -EnableLoginByWam $true`: Enables Web Account Manager for a more modern login experience.

## 3. Resource Management (Az.Resources)
Managing the lifecycle of your resource groups and general resources.

- `Get-AzResourceGroup`: Lists all resource groups in the active subscription.
- `New-AzResourceGroup -Name <Name> -Location <Region>`: Creates a new resource group.
- `Remove-AzResourceGroup -Name <Name>`: Deletes a resource group and everything inside it.
- `Get-AzResource`: Lists all resources across the subscription.

## 4. Virtual Machines (Az.Compute)
Commands for managing IaaS infrastructure.

- `Get-AzVM`: Lists all virtual machines and their current status.
- `Start-AzVM -ResourceGroupName <RG> -Name <VM>`: Starts a stopped/deallocated VM.
- `Stop-AzVM -ResourceGroupName <RG> -Name <VM>`: Shuts down a running VM (use `-Force` to deallocate).
- `Restart-AzVM -ResourceGroupName <RG> -Name <VM>`: Reboots a virtual machine.

## 5. Networking (Az.Network)
Inspecting connectivity and IP assignments.

- `Get-AzVirtualNetwork`: Lists all VNETs.
- `Get-AzNetworkInterface`: Displays details for all Network Interface Cards (NICs).
- `Get-AzPublicIpAddress`: Shows public IP addresses and their associated resources.

## 6. Storage (Az.Storage)
Managing data at rest.

- `Get-AzStorageAccount`: Lists all storage accounts in the subscription.
- `Get-AzStorageAccountKey`: Retrieves access keys for a specific storage account.
- `New-AzStorageContainer -Name <Name> -Context <Context>`: Creates a new blob container.

## 7. Help & Discovery
- `Get-Command -Module Az.*`: Lists every command available in the Az module.
- `Get-Help <CommandName> -Examples`: Shows real-world usage examples for any cmdlet.

