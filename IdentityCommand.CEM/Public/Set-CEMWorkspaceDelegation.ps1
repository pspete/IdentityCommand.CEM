# .ExternalHelp IdentityCommand.CEM-help.xml
function Set-CEMWorkspaceDelegation {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateRange(1, [int]::MaxValue)]
        [int]$id,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateCount(1, 10)]
        [psobject[]]$DelegateDefinition
    )

    begin { }#begin

    process {

        $URI = "$($ISPSSSession.tenant_url)/api/delegations/workspace/update/$id"

        #Fully replaces the delegates on every workspace the delegation covers - the workspaces
        #themselves are not part of this request and are left as they are.
        $body = [ordered]@{
            entities = @($DelegateDefinition)
        }

        if ($PSCmdlet.ShouldProcess($id, 'Update workspace delegation')) {

            Invoke-IDRestMethod -Uri $URI -Method PUT -Body ($body | ConvertTo-Json -Depth 8)

        }

    }#process

    end { }#end

}
