# .ExternalHelp IdentityCommand.CEM-help.xml
function New-CEMWorkspaceDefinition {
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '', Justification = 'Function builds a definition object and does not change state')]
    [CmdletBinding()]
    [OutputType('IdCmd.CEM.Definition.Workspace')]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [String]$organization,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateSet('account', 'root', 'ou', 'directory', 'management_group', 'subscription', 'gcp_organization', 'folder', 'project')]
        [String]$workspace_type,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [String]$workspace_id,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [String]$workspace_name,

        [parameter(Mandatory = $false)]
        [psobject[]]$WorkspaceDefinition
    )

    begin { }#begin

    process {

        $Workspace = $PSBoundParameters | Get-Parameter -ParametersToRemove WorkspaceDefinition

        $Output = @($WorkspaceDefinition) + @([pscustomobject]$Workspace) | Where-Object { $null -ne $_ }

        $Output | Add-CustomType -Type 'IdCmd.CEM.Definition.Workspace'

    }#process

    end { }#end

}
