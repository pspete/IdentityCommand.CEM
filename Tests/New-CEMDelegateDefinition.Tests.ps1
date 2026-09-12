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

Describe 'New-CEMDelegateDefinition' {

    Context 'Definition' {

        It 'defines a delegate' {
            $Delegate = New-CEMDelegateDefinition -entity_type User -entity_name 'John.D' -user_principal 'John.D@domain.cloud.8627' -tags workspace_admin
            $Delegate.entity_type | Should -Be 'User'
            $Delegate.entity_name | Should -Be 'John.D'
            $Delegate.user_principal | Should -Be 'John.D@domain.cloud.8627'
            $Delegate.tags | Should -Be 'workspace_admin'
        }

        It 'applies the expected custom type' {
            (New-CEMDelegateDefinition -entity_type User -entity_name 'n' -user_principal 'p' -tags business_owner).PSObject.TypeNames |
                Should -Contain 'IdCmd.CEM.Definition.Delegate'
        }

        It 'accepts more than one tag' {
            $Delegate = New-CEMDelegateDefinition -entity_type User -entity_name 'n' -user_principal 'p' -tags workspace_admin, business_owner
            ($Delegate.tags | Measure-Object).Count | Should -Be 2
        }

        It 'rejects a tag outside the documented enum' {
            { New-CEMDelegateDefinition -entity_type User -entity_name 'n' -user_principal 'p' -tags invalid } | Should -Throw
        }

        It 'rejects an entity_type outside the documented enum' {
            { New-CEMDelegateDefinition -entity_type Group -entity_name 'n' -user_principal 'p' -tags workspace_admin } | Should -Throw
        }

        It 'adds a delegate to an existing definition' {
            $Delegates = New-CEMDelegateDefinition -entity_type User -entity_name 'n1' -user_principal 'p1' -tags workspace_admin
            $Delegates = New-CEMDelegateDefinition -entity_type User -entity_name 'n2' -user_principal 'p2' -tags business_owner -DelegateDefinition $Delegates
            ($Delegates | Measure-Object).Count | Should -Be 2
        }

    }

}
