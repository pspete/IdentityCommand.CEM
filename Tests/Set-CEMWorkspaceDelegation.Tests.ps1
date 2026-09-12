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

Describe 'Set-CEMWorkspaceDelegation' {

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

        $Script:Delegate = New-CEMDelegateDefinition -entity_type User -entity_name 'John.D' -user_principal 'John.D@domain.cloud.8627' -tags business_owner

        $Script:response = Set-CEMWorkspaceDelegation -id 1 -DelegateDefinition $Script:Delegate

    }

    Context 'Request' {

        It 'sends request' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:CEMModuleName -Times 1 -Exactly -Scope It
        }

        It 'sends request to expected endpoint' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:CEMModuleName -ParameterFilter {
                $URI -eq 'https://somedomain-cem.cyberark.cloud/api/delegations/workspace/update/1'
            } -Times 1 -Exactly -Scope It
        }

        It 'uses expected method' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:CEMModuleName -ParameterFilter {
                $Method -eq 'PUT'
            } -Times 1 -Exactly -Scope It
        }

        It 'sends only the entities in the body' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:CEMModuleName -ParameterFilter {
                $Parsed = $Body | ConvertFrom-Json
                ($Parsed.PSObject.Properties.Name -join ',') -eq 'entities' -and $Parsed.entities[0].tags -eq 'business_owner'
            } -Times 1 -Exactly -Scope It
        }

        It 'does not send a request when WhatIf is specified' {
            Set-CEMWorkspaceDelegation -id 2 -DelegateDefinition $Script:Delegate -WhatIf
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:CEMModuleName -ParameterFilter {
                $URI -match '/update/2$'
            } -Times 0 -Exactly -Scope It
        }

    }

}
