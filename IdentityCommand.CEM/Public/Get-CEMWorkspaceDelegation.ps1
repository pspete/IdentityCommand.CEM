# .ExternalHelp IdentityCommand.CEM-help.xml
function Get-CEMWorkspaceDelegation {
    [CmdletBinding()]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateSet('AWS', 'AZURE', 'GCP')]
        [String]$cloud_platform,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [String]$workspace_id,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateSet('account', 'root', 'ou', 'directory', 'management_group', 'subscription', 'gcp_organization', 'folder', 'project')]
        [String]$workspace_type
    )

    begin { }#begin

    process {

        $URI = "$($ISPSSSession.tenant_url)/api/delegations/workspace/details"

        $body = $PSBoundParameters | Get-Parameter

        #Fetching delegation details is a read - the API models it as a POST because the lookup key
        #is a compound object, not because anything changes.
        $result = Invoke-IDRestMethod -Uri $URI -Method POST -Body ($body | ConvertTo-Json -Depth 4)

        if ($null -ne $result) {

            $result

        }

    }#process

    end { }#end

}
