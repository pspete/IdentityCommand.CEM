#The completer helper functions live in IdentityCommand's Private folder, which the psm1 loads
#into this module's scope.

#region Registration

#Delegation ids are only known once a search has been run - offer them from the most recent
#Find-CEMWorkspaceDelegation results, labelled by workspace name.
Register-ArgumentCompleter -ParameterName 'id' -ScriptBlock (
    Get-ArgumentCompleter -RetrievalCommand 'Find-CEMWorkspaceDelegation' -ValueProperty 'id' -LabelProperty 'workspace_name'
) -CommandName 'Set-CEMWorkspaceDelegation', 'Remove-CEMWorkspaceDelegation'

#endregion Registration
