# .ExternalHelp IdentityCommand.CEM-help.xml
function New-CEMWorkspaceDelegation {
    [CmdletBinding(SupportsShouldProcess)]
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
        [ValidateCount(1, 5)]
        [psobject[]]$WorkspaceDefinition,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateCount(1, 10)]
        [psobject[]]$DelegateDefinition
    )

    begin { }#begin

    process {

        $URI = "$($ISPSSSession.tenant_url)/api/delegations/workspace/$cloud_platform"

        $body = [ordered]@{
            workspaces = @($WorkspaceDefinition)
            entities   = @($DelegateDefinition)
        }

        if ($PSCmdlet.ShouldProcess($cloud_platform, 'Add workspace delegation')) {

            #The response carries no body - the created delegation's id is not returned here, only
            #from a later Find-CEMWorkspaceDelegation or Get-CEMWorkspaceDelegation lookup.
            Invoke-IDRestMethod -Uri $URI -Method POST -Body ($body | ConvertTo-Json -Depth 8)

        }

    }#process

    end { }#end

}
