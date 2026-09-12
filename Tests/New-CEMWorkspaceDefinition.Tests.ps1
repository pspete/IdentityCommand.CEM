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

Describe 'New-CEMWorkspaceDefinition' {

    Context 'Definition' {

        It 'defines a workspace' {
            $Workspace = New-CEMWorkspaceDefinition -organization 'org1' -workspace_type account -workspace_id '123456789012' -workspace_name 'Dev account'
            $Workspace.organization | Should -Be 'org1'
            $Workspace.workspace_type | Should -Be 'account'
            $Workspace.workspace_id | Should -Be '123456789012'
            $Workspace.workspace_name | Should -Be 'Dev account'
        }

        It 'applies the expected custom type' {
            (New-CEMWorkspaceDefinition -organization 'org1' -workspace_type account -workspace_id '123456789012').PSObject.TypeNames |
                Should -Contain 'IdCmd.CEM.Definition.Workspace'
        }

        It 'allows a workspace without a workspace_name' {
            { New-CEMWorkspaceDefinition -organization 'org1' -workspace_type project -workspace_id 'proj-1' } | Should -Not -Throw
        }

        It 'rejects a workspace_type outside the documented enum' {
            { New-CEMWorkspaceDefinition -organization 'org1' -workspace_type invalid -workspace_id '1' } | Should -Throw
        }

        It 'adds a workspace to an existing definition' {
            $Workspaces = New-CEMWorkspaceDefinition -organization 'org1' -workspace_type account -workspace_id '1'
            $Workspaces = New-CEMWorkspaceDefinition -organization 'org1' -workspace_type account -workspace_id '2' -WorkspaceDefinition $Workspaces
            ($Workspaces | Measure-Object).Count | Should -Be 2
        }

    }

}
