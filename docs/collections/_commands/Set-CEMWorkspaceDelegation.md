---
external help file: IdentityCommand.CEM-help.xml
Module Name: IdentityCommand.CEM
online version:
schema: 2.0.0
---

# Set-CEMWorkspaceDelegation

## SYNOPSIS
Updates the delegates of a workspace delegation

## SYNTAX

```
Set-CEMWorkspaceDelegation [-id] <Int32> [-DelegateDefinition] <PSObject[]> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Replaces the delegates (workspace admins and business owners) of an existing workspace delegation with the fully populated list supplied. This updates delegates for every workspace the delegation covers - the workspaces themselves are not part of this request and are left as they are.

Find the delegation `-id` with `Find-CEMWorkspaceDelegation` or `Get-CEMWorkspaceDelegation`.

## EXAMPLES

### Example 1
```
$Delegates = New-CEMDelegateDefinition -entity_type User -entity_name 'John.D' -user_principal 'John.D@domain.cloud.8627' -tags business_owner
Set-CEMWorkspaceDelegation -id 1 -DelegateDefinition $Delegates
```

Replaces delegation 1's delegates with a single business owner, John.D

## PARAMETERS

### -id
The ID of the workspace delegation.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -DelegateDefinition
The fully populated list of delegates to replace the existing ones with, built with `New-CEMDelegateDefinition`. Maximum 10.

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

### System.Int32
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
