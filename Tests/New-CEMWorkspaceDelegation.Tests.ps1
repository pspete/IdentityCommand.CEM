BeforeAll {
    $Script:CEMModuleName = 'IdentityCommand.CEM'

    #Get Current Directory
    $Here = Split-Path -Parent $PSCommandPath

    #Resolve Path to Module Directory
    $ModulePath = Resolve-Path "$Here\..\$Script:CEMModuleName"

    #Define Path to Module Manifest
    $ManifestPath = Join-Path "$ModulePath" "$Script:CEMModuleName.psd1"

    if ( -not (Get-Module -Name $Script:CEMModuleName -All)) {

        Import-Module -Name "$ManifestPath" -ArgumentList $true -Force -ErrorAction Stop

    }
}

Describe 'New-CEMWorkspaceDelegation' {

    BeforeEach {

        Mock -CommandName Invoke-IDRestMethod -ModuleName $Script:CEMModuleName -MockWith {
            $null
        }

        InModuleScope -ModuleName $Script:CEMModuleName {
            $ISPSSSession = [ordered]@{
                tenant_url = 'https://somedomain-cem.cyberark.cloud'
                User       = $null
                TenantId   = 'SomeTenant'
                SessionId  = 'SomeSession'
                WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession
            }
            New-Variable -Name ISPSSSession -Value $ISPSSSession -Scope Script -Force
        }

        $Script:Workspace = New-CEMWorkspaceDefinition -organization 'org1' -workspace_type account -workspace_id '123456789012' -workspace_name 'Dev account'
        $Script:Delegate = New-CEMDelegateDefinition -entity_type User -entity_name 'John.D' -user_principal 'John.D@domain.cloud.8627' -tags workspace_admin, business_owner

        $Script:response = New-CEMWorkspaceDelegation -cloud_platform AWS -WorkspaceDefinition $Script:Workspace -DelegateDefinition $Script:Delegate

    }

    Context 'Request' {

        It 'sends request' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:CEMModuleName -Times 1 -Exactly -Scope It
        }

        It 'sends request to expected endpoint' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:CEMModuleName -ParameterFilter {
                $URI -eq 'https://somedomain-cem.cyberark.cloud/api/delegations/workspace/AWS'
            } -Times 1 -Exactly -Scope It
        }

        It 'uses expected method' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:CEMModuleName -ParameterFilter {
                $Method -eq 'POST'
            } -Times 1 -Exactly -Scope It
        }

        It 'sends the workspaces and entities in the body' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:CEMModuleName -ParameterFilter {
                $Parsed = $Body | ConvertFrom-Json
                $Parsed.workspaces[0].workspace_id -eq '123456789012' -and
                $Parsed.entities[0].entity_name -eq 'John.D'
            } -Times 1 -Exactly -Scope It
        }

        It 'does not send a request when WhatIf is specified' {
            New-CEMWorkspaceDelegation -cloud_platform AZURE -WorkspaceDefinition $Script:Workspace -DelegateDefinition $Script:Delegate -WhatIf
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:CEMModuleName -ParameterFilter {
                $URI -match 'AZURE'
            } -Times 0 -Exactly -Scope It
        }

    }

}
