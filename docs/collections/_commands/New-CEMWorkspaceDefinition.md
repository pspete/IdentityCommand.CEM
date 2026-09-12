---
external help file: IdentityCommand.CEM-help.xml
Module Name: IdentityCommand.CEM
online version:
schema: 2.0.0
---

# New-CEMWorkspaceDefinition

## SYNOPSIS
Defines a cloud workspace for a workspace delegation

## SYNTAX

```
New-CEMWorkspaceDefinition [-organization] <String> [-workspace_type] <String> [-workspace_id] <String>
 [[-workspace_name] <String>] [[-WorkspaceDefinition] <PSObject[]>] [<CommonParameters>]
```

## DESCRIPTION
Builds one workspace object of the shape `New-CEMWorkspaceDelegation` expects in its `-WorkspaceDefinition` array. Pass a previous definition via `-WorkspaceDefinition` to add another workspace to it - a single delegation call can name up to 5 workspaces.

## EXAMPLES

### Example 1
```
New-CEMWorkspaceDefinition -organization '123456789012' -workspace_type account -workspace_id '123456789012' -workspace_name 'Dev account'
```

Defines an AWS account workspace

### Example 2
```
$Workspaces = New-CEMWorkspaceDefinition -organization 'org-001' -workspace_type management_group -workspace_id 'mg-001'
$Workspaces = New-CEMWorkspaceDefinition -organization 'org-001' -workspace_type subscription -workspace_id 'sub-001' -WorkspaceDefinition $Workspaces
```

Defines two Azure workspaces to delegate in a single call

## PARAMETERS

### -organization
The organization that contains the workspace.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -workspace_type
Type of workspace within the cloud provider - `account`, `root`, `ou` (AWS), `directory`, `management_group`, `subscription` (Azure), or `gcp_organization`, `folder`, `project` (GCP).

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -workspace_id
The ID of the workspace.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -workspace_name
The name of the workspace.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -WorkspaceDefinition
A previously built workspace definition (or array of definitions) to add this workspace to.

```yaml
Type: PSObject[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String
## OUTPUTS

### IdCmd.CEM.Definition.Workspace
## NOTES

## RELATED LINKS
