---
external help file: IdentityCommand.CEM-help.xml
Module Name: IdentityCommand.CEM
online version:
schema: 2.0.0
---

# Connect-CEMTenant

## SYNOPSIS
Connects to a Cloud Visibility tenant

## SYNTAX

### Subdomain (Default)
```
Connect-CEMTenant [-tenant_subdomain] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### SubdomainCredential
```
Connect-CEMTenant [-tenant_subdomain] <String> -Credential <PSCredential> [-PlatformToken] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### SubdomainSAML
```
Connect-CEMTenant [-tenant_subdomain] <String> -SAMLResponse <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### URL
```
Connect-CEMTenant [-tenant_url] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### URLCredential
```
Connect-CEMTenant [-tenant_url] <String> -Credential <PSCredential> [-PlatformToken] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### URLSAML
```
Connect-CEMTenant [-tenant_url] <String> -SAMLResponse <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Connects to a Cloud Visibility tenant to be able to run IdentityCommand.CEM module commands against it.

Provide either the ISPSS shared services subdomain or the Cloud Visibility tenant url directly. Either way, the tenant url used for module operations is always `https://<subdomain>-cem.cyberark.cloud` - platform discovery reports a different, regional host for the `cem` service key, but the live service is only reachable at the tenant-scoped host, so this module builds it directly from the subdomain rather than trusting the discovered value. Discovery is still used to resolve the CyberArk Identity url authentication runs against.

If an active `IdentityCommand` session is already present (established with `New-IDSession` or `New-IDPlatformToken`), it is used as-is.

Supply `-Credential` (or `-SAMLResponse`) and `Connect-CEMTenant` will authenticate to CyberArk Identity first, replacing any existing session: the Identity tenant url is discovered from the same subdomain via platform discovery, then `New-IDSession` (interactive user, including any MFA challenges) or - with `-PlatformToken` - `New-IDPlatformToken` (OAuth `client_credentials`, for a service user) is invoked.

## EXAMPLES

### Example 1
```
Connect-CEMTenant -tenant_subdomain sometenant
```

Connects to `https://sometenant-cem.cyberark.cloud`, using the active `IdentityCommand` session, for subsequent module operations

### Example 2
```
Connect-CEMTenant -tenant_url https://sometenant-cem.cyberark.cloud
```

Connects to the `https://sometenant-cem.cyberark.cloud` Cloud Visibility tenant, using the active `IdentityCommand` session, for subsequent module operations

### Example 3
```
Connect-CEMTenant -tenant_subdomain sometenant -Credential $Credential
```

When no active `IdentityCommand` session is present, discovers the CyberArk Identity url for the `sometenant` subdomain, authenticates the user in `$Credential` (completing any MFA challenges), and connects to `https://sometenant-cem.cyberark.cloud`

### Example 4
```
Connect-CEMTenant -tenant_subdomain sometenant -Credential $ServiceUserCredential -PlatformToken
```

When no active `IdentityCommand` session is present, authenticates non-interactively as a service user via an OAuth platform token, then connects to the `sometenant` Cloud Visibility tenant

## PARAMETERS

### -tenant_subdomain
The ISPSS shared services subdomain of the Cloud Visibility tenant.
The tenant url is built as `https://<subdomain>-cem.cyberark.cloud` and used for subsequent operations.

```yaml
Type: String
Parameter Sets: Subdomain, SubdomainCredential, SubdomainSAML
Aliases: subdomain

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -tenant_url
The url of the Cloud Visibility tenant, in the form `https://<subdomain>-cem.cyberark.cloud`.
When authentication parameters are also supplied, the subdomain used to resolve the CyberArk Identity url is derived from this url's host by stripping a trailing `-cem`.

```yaml
Type: String
Parameter Sets: URL, URLCredential, URLSAML
Aliases: cem_url

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Credential
Credential used to authenticate to CyberArk Identity. Authentication is performed even if an active `IdentityCommand` session is found, replacing it.
A user credential is used with `New-IDSession`; a service user credential is used with `New-IDPlatformToken` when `-PlatformToken` is also specified.

```yaml
Type: PSCredential
Parameter Sets: SubdomainCredential, URLCredential
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PlatformToken
Authenticate as a service user via `New-IDPlatformToken` (OAuth `client_credentials`) rather than the interactive `New-IDSession`.

```yaml
Type: SwitchParameter
Parameter Sets: SubdomainCredential, URLCredential
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SAMLResponse
SAML assertion used to authenticate to CyberArk Identity via `New-IDSession`. Authentication is performed even if an active `IdentityCommand` session is found, replacing it.

```yaml
Type: String
Parameter Sets: SubdomainSAML, URLSAML
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
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
