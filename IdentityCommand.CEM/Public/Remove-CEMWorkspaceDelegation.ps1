# .ExternalHelp IdentityCommand.CEM-help.xml
function Remove-CEMWorkspaceDelegation {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateRange(1, [int]::MaxValue)]
        [int]$id
    )

    begin { }#begin

    process {

        $URI = "$($ISPSSSession.tenant_url)/api/delegations/workspace/delegation/$id"

        #Deletes every delegate from every workspace the delegation covers - there is no partial
        #removal, only deleting the whole delegation.
        if ($PSCmdlet.ShouldProcess($id, 'Remove workspace delegation')) {

            Invoke-IDRestMethod -Uri $URI -Method DELETE

        }

    }#process

    end { }#end

}
