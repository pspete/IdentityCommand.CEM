---
external help file: IdentityCommand.CEM-help.xml
Module Name: IdentityCommand.CEM
online version:
schema: 2.0.0
---

# Find-CEMWorkspaceDelegation

## SYNOPSIS
Searches workspace delegations

## SYNTAX

```
Find-CEMWorkspaceDelegation [[-cloud_platforms] <String[]>] [[-workspace_names] <String[]>]
 [[-workspace_types] <String[]>] [[-owners] <String[]>] [[-searchString] <String>] [[-offset] <Int32>]
 [[-limit] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Searches and lists workspace delegations, filtering by cloud platform, workspace name/type and owner, and/or a free-text search string. Results page automatically - the command follows the offset the search endpoint takes in its request body until the reported total count is reached, and returns every matching delegation.

## EXAMPLES

### Example 1
```
Find-CEMWorkspaceDelegation
```

Lists every workspace delegation

### Example 2
```
Find-CEMWorkspaceDelegation -cloud_platforms AWS -workspace_types account, root -owners 'John.D'
```

Lists AWS account/root delegations owned by John.D

### Example 3
```
Find-CEMWorkspaceDelegation -searchString 'prod'
```

Lists delegations whose workspace name or delegate matches 'prod'

## PARAMETERS

### -cloud_platforms
Filter by one or more cloud platform - `AWS`, `AZURE`, `GCP`.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -workspace_names
Filter by workspace name.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -workspace_types
Filter by workspace type.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -owners
Filter by name of delegated entity.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -searchString
Free-text search of workspace names and delegates. Minimum 3 characters.

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

### -offset
Pagination offset for the first page of results (zero-based). Defaults to 0; subsequent pages are requested automatically.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -limit
Maximum number of results requested per page. Defaults to 50.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: 50
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
