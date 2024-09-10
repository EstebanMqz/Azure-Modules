
# Log in to Azure using the Azure CLI. This will prompt for user credentials.
az login

# Retrieve the tenant ID of the currently logged-in Azure account and store it in the TENANT_ID variable.
# The 'az account show' command shows details of the current Azure account.
# The '--query tenantId' option extracts the tenantId property from the account details.
# The '-o tsv' option formats the output as tab-separated values, which removes quotes.
TENANT_ID=$(az account show --query tenantId -o tsv) && echo $TENANT_ID

# Retrieve the subscription ID of the currently logged-in Azure account and store it in the Subscription_ID variable.
# The 'az account show' command shows details of the current Azure account.
# The '--query id' option extracts the id property (which is the subscription ID) from the account details.
# The '-o tsv' option formats the output as tab-separated values, which removes quotes.
Subscription_ID=$(az account show --query id -o tsv) && echo $Subscription_ID

# Log in to Azure CLI using the specified tenant ID.
az login --tenant $TENANT_ID
