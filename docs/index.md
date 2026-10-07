---
title: IdentityCommand.CEM
subtitle: PowerShell for Idira Cloud Visibility
hide_hero: true
---

<div class="has-text-centered mb-6">
  <img src="{{ '/CEM/media/images/IdentityCommand.CEM.png' | relative_url }}" alt="IdentityCommand.CEM" width="471">
</div>

**IdentityCommand.CEM** is a PowerShell module that provides a set of easy-to-use commands, allowing you to interact with the **Idira Workspace Delegation API** (part of Cloud Visibility, formerly Cloud Entitlements Manager) from within the PowerShell environment.

It builds on [IdentityCommand]({{ '/' | relative_url }}) for authentication - see [Getting Started]({{ '/CEM/getting-started/' | relative_url }}) to install and connect, and the [command reference]({{ '/CEM/commands/' | relative_url }}) for every command.

## Delegating a Workspace

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
