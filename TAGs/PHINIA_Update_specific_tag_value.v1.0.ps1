# Define your parameters
$subscriptionName = "NETAPP_CVO_NA"  # Replace with your subscription name
$tagKey = "CostCenter"                   # Replace with the tag key you want to search for
$oldTagValue = "RU291"               # Replace with the current tag value you want to replace
$newTagValue = "900 4970"                  # Replace with the new tag value

# Set the context to the specified subscription
Set-AzContext -SubscriptionId $subscriptionName

# Get all resources in the subscription (no tag filtering here)
$resources = Get-AzResource

# Loop through each resource and update the tag
foreach ($resource in $resources) {
    # Get the current tags of the resource
    $tags = $resource.Tags

    # Check if the tag exists and its value matches the old value
    if ($tags -and $tags.ContainsKey($tagKey) -and $tags[$tagKey] -eq $oldTagValue) {
        # Replace the tag value
        $tags[$tagKey] = $newTagValue

        # Update the resource with the new tag value
        Set-AzResource -ResourceId $resource.ResourceId -Tag $tags -Force

        Write-Host "Updated tag '$tagKey' from '$oldTagValue' to '$newTagValue' for resource '$($resource.Name)'"
    }
    else {
        Write-Host "No matching tag value for resource '$($resource.Name)'"
    }
}
