---
external help file: IdentityCommand.CEM-help.xml
Module Name: IdentityCommand.CEM
online version:
schema: 2.0.0
---

# Remove-CEMWorkspaceDelegation

## SYNOPSIS
Deletes a workspace delegation

## SYNTAX

```
Remove-CEMWorkspaceDelegation [-id] <Int32> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Permanently deletes a workspace delegation, removing all delegates (workspace admins and business owners) from every workspace the delegation covers. Afterwards, only the Cloud Security admin can create and manage access policies and handle access requests for those workspaces.

Find the delegation `-id` with `Find-CEMWorkspaceDelegation` or `Get-CEMWorkspaceDelegation`.

## EXAMPLES

### Example 1
```
Remove-CEMWorkspaceDelegation -id 1
```

Deletes workspace delegation 1

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
