###########  STEP 1 ###########################################################################
# Set the Azure context to the desired subscription
Set-AzContext -SubscriptionName 'DEV-DATA-LAKE'


###########  STEP 2 ###########################################################################
# Define new tags
$tags = @{
    "BusinessUnit"="Manufacturing";
    "CostCenter"="900 4955";
    "ApplicationName"="OMS";
    "Environment"="PROD";
    "BusinessCriticality"="Medium";
    "ActiveHours"="24/7";
    "dxcAutoShutdownSchedule"="NA";
    "Monitoring"="Standard";
    "BackupPolicy"="Standard";
    "PatchWindow"="Standard";
    "ApplicationOwner"="dmarin@phinia.com";
    "StartDateEndDate"="NA";
    "SupportTeam"="george.galatanu@esolutions.ro cezar.ene@esolutions.ro cristina.andries@esolutions.ro";
    "DataClassification"="Restricted";
    "Compliance"="Yes"
}

# Get the resource group
$resourceGroup = Get-AzResourceGroup -Name "rg-datalake-management-001"

if ($resourceGroup -ne $null) {
    # Update tags for the resource group
    Update-AzTag -ResourceId $resourceGroup.ResourceId -Tag $tags -Operation Replace

    # Get all resources in the resource group
    $resources = Get-AzResource -ResourceGroupName "rg-datalake-management-001"

    # Clear existing tags and update new tags for each resource
    foreach ($resource in $resources) {Update-AzTag -ResourceId $resource.ResourceId -Tag $tags -Operation Replace}
} else {Write-Host "Resource group 'rg-datalake-management-001' not found."}