# IdentityCommand.CEM

**IdentityCommand.CEM** is a PowerShell module that provides a set of easy-to-use commands, allowing you to interact with the **CyberArk Workspace Delegation API** (part of Cloud Visibility, formerly Cloud Entitlements Manager) from within the PowerShell environment.

| Main Branch              | Latest Build             | CodeFactor                 | Coverage                     | PowerShell Gallery        | License                      |
| ------------------------ | ------------------------ | -------------------------- | ---------------------------- | ------------------------- | ---------------------------- |
| [![appveyor][]][av-site] | [![tests][]][tests-site] | [![codefactor][]][cf-site] | [![codecov][]][codecov-link] | [![psgallery][]][ps-site] | [![license][]][license-link] |

[appveyor]: https://ci.appveyor.com/api/projects/status/q2av77njofnsul92/branch/main?svg=true
[av-site]: https://ci.appveyor.com/project/pspete/IdentityCommand-CEM/branch/main
[psgallery]: https://img.shields.io/powershellgallery/v/IdentityCommand.CEM.svg
[ps-site]: https://www.powershellgallery.com/packages/IdentityCommand.CEM
[tests]: https://img.shields.io/appveyor/tests/pspete/IdentityCommand-CEM.svg
[tests-site]: https://ci.appveyor.com/project/pspete/IdentityCommand-CEM
[downloads]: https://img.shields.io/powershellgallery/dt/IdentityCommand.CEM.svg?color=blue
[cf-site]: https://www.codefactor.io/repository/github/pspete/IdentityCommand.CEM
[codefactor]: https://www.codefactor.io/repository/github/pspete/IdentityCommand.CEM/badge
[codecov]: https://codecov.io/gh/pspete/IdentityCommand.CEM/branch/main/graph/badge.svg
[codecov-link]: https://codecov.io/gh/pspete/IdentityCommand.CEM
[license]: https://img.shields.io/github/license/pspete/IdentityCommand.CEM.svg
[license-link]: https://github.com/pspete/IdentityCommand.CEM/blob/main/LICENSE

## Using the Module

The module requires authentication to the CyberArk Identity platform using the `IdentityCommand` module.

The `IdentityCommand` module must be installed and available in order to use `IdentityCommand.CEM`.

An overview of some of the features of the module are found in the below sections.

### Cloud Visibility Authentication

The `Connect-CEMTenant` command initialises the bearer token used for module operations against the Workspace Delegation API.

Cloud Visibility is served from a tenant-scoped gateway (`https://<subdomain>-cem.cyberark.cloud`), not the regional host platform discovery reports for the `cem` service key - `Connect-CEMTenant` builds this url directly from the subdomain rather than trusting the discovered value.

If an Identity session already exists (established with the `IdentityCommand` module's `New-IDSession` or `New-IDPlatformToken`), it is used as-is:

```powershell
Connect-CEMTenant -tenant_subdomain sometenant

# Or provide the Cloud Visibility tenant url directly
Connect-CEMTenant -tenant_url https://sometenant-cem.cyberark.cloud
```

Otherwise, provide a credential and `Connect-CEMTenant` authenticates to CyberArk Identity for you - the Identity tenant url is discovered from the same subdomain:

```powershell
# Interactive user authentication (any MFA challenges are handled by IdentityCommand)
Connect-CEMTenant -tenant_subdomain sometenant -Credential $Credential

# Non-interactive service user authentication via an OAuth platform token
Connect-CEMTenant -tenant_subdomain sometenant -Credential $ServiceUserCredential -PlatformToken
```

### Delegating a Workspace

A workspace delegation names the entities (users or roles) allowed to manage access policies and approve access requests for one or more cloud workspaces. Build the workspaces and delegates first, then create the delegation:

```powershell
$Workspace = New-CEMWorkspaceDefinition -organization '123456789012' -workspace_type account -workspace_id '123456789012' -workspace_name 'Dev account'
$Delegate = New-CEMDelegateDefinition -entity_type User -entity_name 'John.D' -user_principal 'John.D@domain.cloud.8627' -tags workspace_admin, business_owner

New-CEMWorkspaceDelegation -cloud_platform AWS -WorkspaceDefinition $Workspace -DelegateDefinition $Delegate
```

`New-CEMWorkspaceDelegation`'s response carries no body, so the created delegation's id isn't returned there - look it up with `Find-CEMWorkspaceDelegation` or `Get-CEMWorkspaceDelegation` before updating or removing it:

```powershell
Find-CEMWorkspaceDelegation -cloud_platforms AWS -owners 'John.D'

Get-CEMWorkspaceDelegation -cloud_platform AWS -workspace_id '123456789012' -workspace_type account
```

`Set-CEMWorkspaceDelegation` fully replaces the delegates on a delegation - supply the complete list you want, not just the change:

```powershell
$Delegates = New-CEMDelegateDefinition -entity_type User -entity_name 'John.D' -user_principal 'John.D@domain.cloud.8627' -tags business_owner
Set-CEMWorkspaceDelegation -id 1 -DelegateDefinition $Delegates
```

```powershell
Remove-CEMWorkspaceDelegation -id 1
```

## Module Commands

| Command                        | Description                                          |
| ------------------------------- | ----------------------------------------------------- |
| `Connect-CEMTenant`              | Authenticate to Cloud Visibility                      |
| `New-CEMWorkspaceDefinition`     | Define a cloud workspace for a workspace delegation   |
| `New-CEMDelegateDefinition`      | Define a delegate entity for a workspace delegation   |
| `New-CEMWorkspaceDelegation`     | Add delegates to one or more cloud workspaces         |
| `Get-CEMWorkspaceDelegation`     | Get the delegation details of a specific workspace    |
| `Find-CEMWorkspaceDelegation`    | Search workspace delegations                          |
| `Set-CEMWorkspaceDelegation`     | Update the delegates of a workspace delegation        |
| `Remove-CEMWorkspaceDelegation`  | Delete a workspace delegation                         |
| `Get-CEMModuleData`              | Get the module version & session configuration data   |

## Installation

### Prerequisites

- Requires Powershell Core (recommended), or Windows PowerShell (version 5.1)
- A CyberArk Identity tenant with the Cloud Visibility service enabled
- An Account to Access CyberArk Identity

### Install Options

Users can install IdentityCommand.CEM from GitHub or the PowerShell Gallery.

Choose any of the following ways to download the module and install it:

#### Option 1: Install from PowerShell Gallery

This is the easiest and most popular way to install the module:

1. Open a PowerShell prompt

2. Run the following command:

```powershell
Install-Module -Name IdentityCommand.CEM -Scope CurrentUser
```

#### Option 2: Manual Install

The module files can be manually copied to one of your PowerShell module directories.

Use the following command to get the paths to your local PowerShell module folders:

```powershell

$env:PSModulePath.split(';')

```

The module files must be placed in one of the listed directories, in a folder called `IdentityCommand.CEM`.

More: [about_PSModulePath](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_psmodulepath)

The module files are available to download using a variety of methods:

##### PowerShell Gallery

- Download from the module from the [PowerShell Gallery](https://www.powershellgallery.com/packages/IdentityCommand.CEM/):
  - Run the PowerShell command `Save-Module -Name IdentityCommand.CEM -Path C:\temp`
  - Copy the `C:\temp\IdentityCommand.CEM` folder to your "Powershell Modules" directory of choice.

##### IdentityCommand.CEM Release

- [Download the latest GitHub release](https://github.com/pspete/IdentityCommand.CEM/releases/latest)
  - Unblock & Extract the archive
  - Rename the extracted `IdentityCommand.CEM-v#.#.#` folder to `IdentityCommand.CEM`
  - Copy the `IdentityCommand.CEM` folder to your "Powershell Modules" directory of choice.

##### IdentityCommand.CEM Branch

- [Download the `main` branch](https://github.com/pspete/IdentityCommand.CEM/archive/refs/heads/main.zip)
  - Unblock & Extract the archive
  - Copy the `IdentityCommand.CEM` (`\<Archive Root>\IdentityCommand.CEM-main\IdentityCommand.CEM`) folder to your "Powershell Modules" directory of choice.

#### Verification

Validate Install:

```powershell

Get-Module -ListAvailable IdentityCommand.CEM

```

Import the module:

```powershell

Import-Module IdentityCommand.CEM

```

List Module Commands:

```powershell

Get-Command -Module IdentityCommand.CEM

```

Get detailed information on specific commands:

```powershell

Get-Help New-CEMWorkspaceDelegation -Full

```

## Sponsorship

Please support continued development; consider sponsoring <a href="https://github.com/sponsors/pspete"> @pspete on GitHub Sponsors</a>

## Changelog

All notable changes to this project will be documented in the [Changelog](CHANGELOG.md)

## Author

- **Pete Maan** - [pspete](https://github.com/pspete)

## License

This project is [licensed under the MIT License](LICENSE.md).

## Contributing

Any and all contributions to this project are appreciated.

See the [CONTRIBUTING.md](CONTRIBUTING.md) for a few more details.

## Support

_IdentityCommand.CEM_ is neither developed nor supported by CyberArk; any official support channels offered by the vendor are not appropriate for seeking help with the _IdentityCommand.CEM_ module.

Help and support should be sought by [opening an issue][new-issue].

[new-issue]: https://github.com/pspete/IdentityCommand.CEM/issues/new

Priority support could be considered for <a href="https://github.com/sponsors/pspete">sponsors of @pspete</a>, <a href="mailto:pspete@pspete.dev">contact us</a> to discuss options.
