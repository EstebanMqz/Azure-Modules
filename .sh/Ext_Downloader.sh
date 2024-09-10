#!/bin/bash

#!/bin/bash

# Sign in to Azure
TENANT_ID=$(az account show --query "tenantId" -o tsv)
az login --tenant/-t 

# Check if there are any subscriptions
subscriptions=$(az account list --query "[].{name:name, id:id}" -o tsv)
if [ -z "$subscriptions" ]; then
  echo "No subscriptions are found for your account."
  exit 1
fi

# Set the default subscription if not already set
default_subscription=$(az account show --query "id" -o tsv)
if [ -z "$default_subscription" ]; then
  echo "No default subscription is set. Setting the first available subscription as default."
  first_subscription_id=$(echo "$subscriptions" | head -n 1 | awk '{print $2}')
  az account set --subscription "$first_subscription_id"
fi

# List all available stable extensions
available_extensions=$(az extension list-available --query "[?metadata.status=='Stable'].name" -o tsv)

# List currently installed extensions
installed_extensions=$(az extension list --query "[].name" -o tsv)

# Install missing extensions
for extension in $available_extensions; do
  if ! echo "$installed_extensions" | grep -q "$extension"; then
	echo "Installing extension: $extension"
	az extension add --name "$extension"
  else
	echo "Extension already installed: $extension"
  fi
done

# Retrieve additional account details
account_details=$(az account show --query "{id: id, name: name, user: user, state: state, isDefault: isDefault, environmentName: environmentName, homeTenantId: homeTenantId}" -o json)
echo "Account details: $account_details"

#cd C:/Users/Esteban/Desktop/Projects/Github/Repos_To-do/Languages/Other/Repositories/Azure-Modules/.sh
#chmod +x Ext_Downloader.sh && ./Ext_Downloader.sh