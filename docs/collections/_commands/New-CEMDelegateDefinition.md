---
external help file: IdentityCommand.CEM-help.xml
Module Name: IdentityCommand.CEM
online version:
schema: 2.0.0
---

# New-CEMDelegateDefinition

## SYNOPSIS
Defines a delegate entity for a workspace delegation

## SYNTAX

```
New-CEMDelegateDefinition [-entity_type] <String> [-entity_name] <String> [-user_principal] <String>
 [-tags] <String[]> [[-entity_id] <String>] [[-directory_id] <String>] [[-directory_name] <String>]
 [[-entity_email] <String>] [[-service_type] <String>] [[-entity_internal_id] <String>]
 [[-DelegateDefinition] <PSObject[]>] [<CommonParameters>]
```

## DESCRIPTION
Builds one entity object of the shape `New-CEMWorkspaceDelegation` and `Set-CEMWorkspaceDelegation` expect in their `-DelegateDefinition` array. Pass a previous definition via `-DelegateDefinition` to add another delegate to it - a single call can name up to 10 entities.

## EXAMPLES

### Example 1
```
New-CEMDelegateDefinition -entity_type User -entity_name 'John.D' -user_principal 'John.D@domain.cloud.8627' -tags workspace_admin, business_owner
```

Defines a user as both workspace admin and business owner

### Example 2
```
$Delegates = New-CEMDelegateDefinition -entity_type User -entity_name 'John.D' -user_principal 'John.D@domain.cloud.8627' -tags workspace_admin
$Delegates = New-CEMDelegateDefinition -entity_type Role -entity_name 'CloudSecTeam' -user_principal 'CloudSecTeam@domain.cloud.8627' -tags business_owner -DelegateDefinition $Delegates
```

Defines two delegates to add in a single call

## PARAMETERS

### -entity_type
Type of entity being delegated to a workspace - `User` or `Role`.

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

### -entity_name
Display name of the entity.

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

### -user_principal
Authentication principal used by the entity.

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

### -tags
Delegation role(s) assigned to the entity - `workspace_admin` (creates and manages access policies for the workspace, and approves access requests if no business owner is assigned) and/or `business_owner` (approves access requests).

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -entity_id
Identifier of the entity.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -directory_id
The ID of the user directory where the entity is managed.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -directory_name
The display name of the user directory where the entity is managed.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -entity_email
Email address of the entity.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -service_type
Identity provider of the entity (IAM, Entra ID, GCP IAM, CDS, etc.).

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -entity_internal_id
Internal identifier of the entity.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -DelegateDefinition
A previously built delegate definition (or array of definitions) to add this entity to.

```yaml
Type: PSObject[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String
## OUTPUTS

### IdCmd.CEM.Definition.Delegate
## NOTES

## RELATED LINKS
