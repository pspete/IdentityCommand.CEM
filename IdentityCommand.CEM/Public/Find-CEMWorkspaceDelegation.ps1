# .ExternalHelp IdentityCommand.CEM-help.xml
function Find-CEMWorkspaceDelegation {
    [CmdletBinding()]
    param(
        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateSet('AWS', 'AZURE', 'GCP')]
        [String[]]$cloud_platforms,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [String[]]$workspace_names,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateSet('account', 'root', 'ou', 'directory', 'management_group', 'subscription', 'gcp_organization', 'folder', 'project')]
        [String[]]$workspace_types,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [String[]]$owners,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateLength(3, [int]::MaxValue)]
        [String]$searchString,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateRange(0, [int]::MaxValue)]
        [int]$offset,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateRange(1, [int]::MaxValue)]
        [int]$limit
    )

    begin { }#begin

    process {

        $URI = "$($ISPSSSession.tenant_url)/api/delegations/workspace/search"

        $Filters = $PSBoundParameters | Get-Parameter -ParametersToKeep cloud_platforms, workspace_names, workspace_types, owners

        $body = $PSBoundParameters | Get-Parameter -ParametersToRemove cloud_platforms, workspace_names, workspace_types, owners

        if ($Filters.Keys.Count -gt 0) {
            $body['filters'] = $Filters
        }

        if (-not $PSBoundParameters.ContainsKey('offset')) { $body['offset'] = 0 }
        if (-not $PSBoundParameters.ContainsKey('limit')) { $body['limit'] = 50 }

        $result = Invoke-IDRestMethod -Uri $URI -Method POST -Body ($body | ConvertTo-Json -Depth 4)

        if ($null -ne $result) {

            Get-PagedResult -InitialResult $result -URI $URI -Style Offset -ResultProperty items `
                -TotalResponseKey count -OffsetRequestKey offset -Method POST -BodyTemplate $body

        }

    }#process

    end { }#end

}
