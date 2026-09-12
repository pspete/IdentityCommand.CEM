# .ExternalHelp IdentityCommand.CEM-help.xml
function New-CEMDelegateDefinition {
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '', Justification = 'Function builds a definition object and does not change state')]
    [CmdletBinding()]
    [OutputType('IdCmd.CEM.Definition.Delegate')]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateSet('User', 'Role')]
        [String]$entity_type,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [String]$entity_name,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [String]$user_principal,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateSet('workspace_admin', 'business_owner')]
        [String[]]$tags,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [String]$entity_id,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [String]$directory_id,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [String]$directory_name,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [String]$entity_email,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [String]$service_type,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [String]$entity_internal_id,

        [parameter(Mandatory = $false)]
        [psobject[]]$DelegateDefinition
    )

    begin { }#begin

    process {

        $Delegate = $PSBoundParameters | Get-Parameter -ParametersToRemove DelegateDefinition

        $Output = @($DelegateDefinition) + @([pscustomobject]$Delegate) | Where-Object { $null -ne $_ }

        $Output | Add-CustomType -Type 'IdCmd.CEM.Definition.Delegate'

    }#process

    end { }#end

}
