---
external help file: IdentityCommand.CEM-help.xml
Module Name: IdentityCommand.CEM
online version:
schema: 2.0.0
---

# Get-CEMWorkspaceDelegation

## SYNOPSIS
Gets the delegation details of a specific cloud workspace

## SYNTAX

```
Get-CEMWorkspaceDelegation [-cloud_platform] <String> [-workspace_id] <String> [-workspace_type] <String>
 [<CommonParameters>]
```

## DESCRIPTION
Fetches the delegation id and delegated entities of a single, specific workspace. The API models this lookup as a POST because the key is a compound object (platform, id and type together), not because anything changes - no `-WhatIf`/`-Confirm` support is offered.

## EXAMPLES

### Example 1
```
Get-CEMWorkspaceDelegation -cloud_platform AWS -workspace_id '123456789012' -workspace_type account
```

Gets the delegation details of the named AWS account

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

### -workspace_id
The ID of the workspace.

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

### -workspace_type
Type of workspace within the cloud provider - `account`, `root`, `ou` (AWS), `directory`, `management_group`, `subscription` (Azure), or `gcp_organization`, `folder`, `project` (GCP).

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
