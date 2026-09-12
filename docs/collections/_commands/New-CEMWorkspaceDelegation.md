---
external help file: IdentityCommand.CEM-help.xml
Module Name: IdentityCommand.CEM
online version:
schema: 2.0.0
---

# New-CEMWorkspaceDelegation

## SYNOPSIS
Adds delegates to one or more cloud workspaces

## SYNTAX

```
New-CEMWorkspaceDelegation [-cloud_platform] <String> [-WorkspaceDefinition] <PSObject[]>
 [-DelegateDefinition] <PSObject[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a workspace delegation, naming the entities (users or roles) delegated as workspace admins and/or business owners for one or more workspaces of a specific cloud platform.

The response carries no body, so the created delegation's id is not returned here - look it up afterwards with `Find-CEMWorkspaceDelegation` or `Get-CEMWorkspaceDelegation` before calling `Set-CEMWorkspaceDelegation` or `Remove-CEMWorkspaceDelegation`.

## EXAMPLES

### Example 1
```
$Workspace = New-CEMWorkspaceDefinition -organization '123456789012' -workspace_type account -workspace_id '123456789012' -workspace_name 'Dev account'
$Delegate = New-CEMDelegateDefinition -entity_type User -entity_name 'John.D' -user_principal 'John.D@domain.cloud.8627' -tags workspace_admin, business_owner
New-CEMWorkspaceDelegation -cloud_platform AWS -WorkspaceDefinition $Workspace -DelegateDefinition $Delegate
```

Delegates a single AWS account workspace to one user as both workspace admin and business owner

## PARAMETERS

### -cloud_platform
The cloud platform associated with the workspace - `AWS`, `AZURE` or `GCP`.

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

### -WorkspaceDefinition
One or more workspaces to delegate, built with `New-CEMWorkspaceDefinition`. Maximum 5.

```yaml
Type: PSObject[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -DelegateDefinition
One or more entities to delegate as workspace admins or business owners, built with `New-CEMDelegateDefinition`. Maximum 10.

```yaml
Type: PSObject[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
