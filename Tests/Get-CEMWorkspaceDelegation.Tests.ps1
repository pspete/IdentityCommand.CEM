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

Describe 'Get-CEMWorkspaceDelegation' {

    BeforeEach {

        Mock -CommandName Invoke-IDRestMethod -ModuleName $Script:CEMModuleName -MockWith {
            [pscustomobject]@{
                id             = 1
                cloud_platform = 'AWS'
                workspace_type = 'account'
                workspace_id   = '123456789012'
                workspace_name = 'Dev account'
                entities       = @()
            }
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

        $Script:response = Get-CEMWorkspaceDelegation -cloud_platform AWS -workspace_id '123456789012' -workspace_type account

    }

    Context 'Request' {

        It 'sends request' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:CEMModuleName -Times 1 -Exactly -Scope It
        }

        It 'sends request to expected endpoint' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:CEMModuleName -ParameterFilter {
                $URI -eq 'https://somedomain-cem.cyberark.cloud/api/delegations/workspace/details'
            } -Times 1 -Exactly -Scope It
        }

        It 'uses expected method' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:CEMModuleName -ParameterFilter {
                $Method -eq 'POST'
            } -Times 1 -Exactly -Scope It
        }

        It 'sends the lookup key in the body' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:CEMModuleName -ParameterFilter {
                $Parsed = $Body | ConvertFrom-Json
                $Parsed.cloud_platform -eq 'AWS' -and $Parsed.workspace_id -eq '123456789012' -and $Parsed.workspace_type -eq 'account'
            } -Times 1 -Exactly -Scope It
        }

    }

    Context 'Response' {

        It 'returns the delegation details' {
            $Script:response.workspace_name | Should -Be 'Dev account'
        }

    }

}
