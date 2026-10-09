# Change Log

All notable changes to this project will be documented in this file.

## Unreleased

### Changed

- CI caches the PowerShell modules it installs, so dependency installs skip the PowerShell Gallery on a cache hit.

## [0.1.0] - 2026-10-07

### Added

- Initial release of `IdentityCommand.CEM`, wrapping the CyberArk Workspace Delegation API (part of
  Cloud Visibility, formerly Cloud Entitlements Manager).
- `Connect-CEMTenant`: authenticate to Cloud Visibility. Builds the tenant url directly from the
  subdomain (`https://<subdomain>-cem.cyberark.cloud`), since platform discovery reports a regional
  host for the `cem` service key that the live service is not reachable at; the CyberArk Identity
  url is still resolved via discovery. An existing `IdentityCommand` session is used as-is;
  supplying `-Credential` (optionally with `-PlatformToken`) or `-SAMLResponse` authenticates to
  CyberArk Identity first.
- `New-CEMWorkspaceDefinition` and `New-CEMDelegateDefinition`: chainable builders for the
  workspaces and delegate entities a workspace delegation names.
- `New-CEMWorkspaceDelegation`: delegate one or more cloud workspaces (up to 5) to up to 10
  entities as workspace admins and/or business owners.
- `Get-CEMWorkspaceDelegation`: get the delegation details of a specific workspace.
- `Find-CEMWorkspaceDelegation`: search workspace delegations by platform, workspace name/type and
  owner, or a free-text search string. Results page automatically over the search endpoint's
  body-based offset paging.
- `Set-CEMWorkspaceDelegation`: replace the delegates of an existing delegation.
- `Remove-CEMWorkspaceDelegation`: delete a workspace delegation.
- `Get-CEMModuleData`: get the module version and session configuration data.

