function New-WebrootConsoleGSMEndpointGroupCommand  {
    #https://unityapi.webrootcloudav.com/Docs/APIDoc/Api/POST-api-console-gsm-gsmKey-sites-siteId-groups-groupId-endpoints-commands
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$True)]
        [string]$GSMKey,
        [Parameter(Mandatory=$True)]
        [string]$SiteID,
        [string]$groupId,
        [Parameter(Mandatory=$True)]
        [ValidateSet("scan","cleanup","uninstall","changekeycode","restart")]
        [string]$Command,
        [string]$Parameters
    )

    $url = "https://unityapi.webrootcloudav.com/service/api/console/gsm/$($GSMKey)/sites/$($SiteID)/groups/$($groupId)/endpoints/commands"
    
    $Body = @{EndpointsList=$EndpointsList;
                Command=$Command;
                Parameters=$Parameters;}
    $Body = $Body | ConvertTo-Json


    Write-Verbose "Connecting"
    Connect-WebrootUnity
            
    try{
        Invoke-RestMethod -Method Post -Uri $url -ContentType "application/json" -Body $Body -Headers @{"Authorization" = "Bearer $($WebrootAuthToken.access_token)"}
    }
    catch{
        Write-Error "Error: $($Error[0])"
    }
    
}