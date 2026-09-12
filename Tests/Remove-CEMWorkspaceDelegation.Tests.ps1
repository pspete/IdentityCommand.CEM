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

Describe 'Remove-CEMWorkspaceDelegation' {

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

        $Script:response = Remove-CEMWorkspaceDelegation -id 1

    }

    Context 'Request' {

        It 'sends request' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:CEMModuleName -Times 1 -Exactly -Scope It
        }

        It 'sends request to expected endpoint' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:CEMModuleName -ParameterFilter {
                $URI -eq 'https://somedomain-cem.cyberark.cloud/api/delegations/workspace/delegation/1'
            } -Times 1 -Exactly -Scope It
        }

        It 'uses expected method' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:CEMModuleName -ParameterFilter {
                $Method -eq 'DELETE'
            } -Times 1 -Exactly -Scope It
        }

        It 'sends request with no body' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:CEMModuleName -ParameterFilter {
                $null -eq $Body
            } -Times 1 -Exactly -Scope It
        }

        It 'does not send a request when WhatIf is specified' {
            Remove-CEMWorkspaceDelegation -id 9 -WhatIf
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:CEMModuleName -ParameterFilter {
                $URI -match '/delegation/9$'
            } -Times 0 -Exactly -Scope It
        }

    }

}
