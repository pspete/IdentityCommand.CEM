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

Describe 'Find-CEMWorkspaceDelegation' {

    Context 'Request' {

        BeforeEach {

            Mock -CommandName Invoke-IDRestMethod -ModuleName $Script:CEMModuleName -MockWith {
                [pscustomobject]@{ count = 1; items = @([pscustomobject]@{ id = 1; workspace_name = 'Dev account' }) }
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

            $Script:response = Find-CEMWorkspaceDelegation -cloud_platforms AWS -owners 'John.D' -searchString 'John.D'

        }

        It 'sends request to expected endpoint' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:CEMModuleName -ParameterFilter {
                $URI -eq 'https://somedomain-cem.cyberark.cloud/api/delegations/workspace/search'
            } -Times 1 -Exactly -Scope It
        }

        It 'uses expected method' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:CEMModuleName -ParameterFilter {
                $Method -eq 'POST'
            } -Times 1 -Exactly -Scope It
        }

        It 'sends filters nested under a filters object, and searchString at the top level' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:CEMModuleName -ParameterFilter {
                $Parsed = $Body | ConvertFrom-Json
                $Parsed.filters.cloud_platforms -eq 'AWS' -and $Parsed.filters.owners -eq 'John.D' -and $Parsed.searchString -eq 'John.D'
            } -Times 1 -Exactly -Scope It
        }

        It 'defaults offset to 0 and limit to 50' {
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:CEMModuleName -ParameterFilter {
                $Parsed = $Body | ConvertFrom-Json
                $Parsed.offset -eq 0 -and $Parsed.limit -eq 50
            } -Times 1 -Exactly -Scope It
        }

        It 'returns the matching delegations' {
            $Script:response.workspace_name | Should -Be 'Dev account'
        }

    }

    Context 'Pagination' {

        It 'follows the offset until the reported count is reached' {

            $Script:CallCount = 0

            Mock -CommandName Invoke-IDRestMethod -ModuleName $Script:CEMModuleName -MockWith {
                $Script:CallCount++
                if ($Script:CallCount -eq 1) {
                    [pscustomobject]@{ count = 2; items = @([pscustomobject]@{ id = 1 }) }
                } else {
                    [pscustomobject]@{ count = 2; items = @([pscustomobject]@{ id = 2 }) }
                }
            }

            InModuleScope -ModuleName $Script:CEMModuleName {
                $ISPSSSession = [ordered]@{
                    tenant_url = 'https://somedomain-cem.cyberark.cloud'
                    WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession
                }
                New-Variable -Name ISPSSSession -Value $ISPSSSession -Scope Script -Force
            }

            $Response = Find-CEMWorkspaceDelegation -limit 1

            ($Response | Measure-Object).Count | Should -Be 2
            Should -Invoke -CommandName Invoke-IDRestMethod -ModuleName $Script:CEMModuleName -Times 2 -Exactly -Scope It

        }

    }

}
