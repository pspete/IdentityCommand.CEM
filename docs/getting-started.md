---
title: Getting Started
subtitle: Install IdentityCommand.CEM and connect to Cloud Visibility
---

## Prerequisites

- Requires Powershell Core (recommended), or Windows PowerShell (version 5.1)
- An Idira Identity tenant with the Cloud Visibility service enabled
- An Account to Access Idira Identity
- The `IdentityCommand` module.

## Install Options

Install from the PowerShell Gallery:

```powershell
Install-Module -Name IdentityCommand.CEM -Scope CurrentUser
```

Or download the [latest release](https://github.com/pspete/IdentityCommand.CEM/releases), unblock and extract the archive, and copy the `IdentityCommand.CEM` folder into a path listed in `$env:PSModulePath`.

## Authentication

The module requires authentication to the Idira Identity platform using the `IdentityCommand` module.

The `IdentityCommand` module must be installed and available in order to use `IdentityCommand.CEM`.

The `Connect-CEMTenant` command initialises the bearer token used for module operations against the Workspace Delegation API.

Cloud Visibility is served from a tenant-scoped gateway (`https://<subdomain>-cem.cyberark.cloud`), not the regional host platform discovery reports for the `cem` service key - `Connect-CEMTenant` builds this url directly from the subdomain rather than trusting the discovered value.

If an Identity session already exists (established with the `IdentityCommand` module's `New-IDSession` or `New-IDPlatformToken`), it is used as-is:

```powershell
Connect-CEMTenant -tenant_subdomain sometenant

# Or provide the Cloud Visibility tenant url directly
Connect-CEMTenant -tenant_url https://sometenant-cem.cyberark.cloud
```

Otherwise, provide a credential and `Connect-CEMTenant` authenticates to Idira Identity for you - the Identity tenant url is discovered from the same subdomain:

```powershell
# Interactive user authentication (any MFA challenges are handled by IdentityCommand)
Connect-CEMTenant -tenant_subdomain sometenant -Credential $Credential

# Non-interactive service user authentication via an OAuth platform token
Connect-CEMTenant -tenant_subdomain sometenant -Credential $ServiceUserCredential -PlatformToken
```
