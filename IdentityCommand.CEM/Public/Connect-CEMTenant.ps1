# .ExternalHelp IdentityCommand.CEM-help.xml
function Connect-CEMTenant {

    [CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = 'Subdomain')]
    param(

        #subdomain
        [parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'Subdomain')]
        [parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'SubdomainCredential')]
        [parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'SubdomainSAML')]
        [ValidateNotNullOrEmpty()]
        [Alias('subdomain')]
        [String]$tenant_subdomain,

        #tenant_url
        [parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'URL')]
        [parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'URLCredential')]
        [parameter(Mandatory = $true, ValueFromPipelineByPropertyName = $true, ParameterSetName = 'URLSAML')]
        [ValidateNotNullOrEmpty()]
        [Alias('cem_url')]
        [String]$tenant_url,

        #Credential used to authenticate to CyberArk Identity. Authentication is performed even if an active IdentityCommand session is found, replacing it
        [parameter(Mandatory = $true, ParameterSetName = 'SubdomainCredential')]
        [parameter(Mandatory = $true, ParameterSetName = 'URLCredential')]
        [ValidateNotNullOrEmpty()]
        [PSCredential]$Credential,

        #Authenticate as a service user via New-IDPlatformToken (OAuth client_credentials) instead of the interactive New-IDSession
        [parameter(ParameterSetName = 'SubdomainCredential')]
        [parameter(ParameterSetName = 'URLCredential')]
        [Switch]$PlatformToken,

        #SAML assertion used to authenticate to CyberArk Identity. Authentication is performed even if an active IdentityCommand session is found, replacing it
        [parameter(Mandatory = $true, ParameterSetName = 'SubdomainSAML')]
        [parameter(Mandatory = $true, ParameterSetName = 'URLSAML')]
        [ValidateNotNullOrEmpty()]
        [String]$SAMLResponse

    )

    begin {

        $IDSession = Get-IDSession
        $HaveSession = $null -ne $IDSession.tenant_url
        $AuthRequested = $PSBoundParameters.ContainsKey('Credential') -or $PSBoundParameters.ContainsKey('SAMLResponse')

        if ($HaveSession -and $AuthRequested) {
            Write-Verbose 'Authentication parameters were supplied; authenticating and replacing the existing IdentityCommand session'
        }

    }#begin

    process {

        $UsingSubdomain = $PSCmdlet.ParameterSetName -like 'Subdomain*'

        #Cloud Visibility is served from a tenant-scoped gateway (<subdomain>-cem.cyberark.cloud), not
        #the regional host platform discovery reports for the cem service key. Discovery is still used
        #to resolve the CyberArk Identity URL authentication runs against.
        $ServiceUrl = $null

        if ($UsingSubdomain) {

            $ServiceUrl = Resolve-ServiceUrl -Service cem -Subdomain $tenant_subdomain
            $tenant_url = "https://$tenant_subdomain-cem.cyberark.cloud"

        } else {

            #Ensure URL is in expected format - remove trailing slash if provided in Url
            $tenant_url = $tenant_url -replace '/$', ''

            if ($AuthRequested) {
                $Subdomain = ([System.Uri]$tenant_url).Host.Split('.')[0] -replace '-cem$', ''
                $ServiceUrl = Resolve-ServiceUrl -Service cem -Subdomain $Subdomain
            }

        }

        if ($AuthRequested -or (-not $HaveSession)) {

            if (-not $AuthRequested) {
                throw 'Authenticate with New-IDSession or New-IDPlatformToken, or supply -Credential, and try again'
            }

            $IdentityUrl = $ServiceUrl.IdentityUrl

            if ($PSCmdlet.ShouldProcess($IdentityUrl, 'Authenticate to CyberArk Identity')) {

                if ($PSCmdlet.ParameterSetName -like '*SAML') {
                    $null = New-IDSession -tenant_url $IdentityUrl -SAMLResponse $SAMLResponse
                } elseif ($PlatformToken) {
                    $null = New-IDPlatformToken -tenant_url $IdentityUrl -Credential $Credential
                } else {
                    $null = New-IDSession -tenant_url $IdentityUrl -Credential $Credential
                }

                $IDSession = Get-IDSession

            }

        }

        #Make the CyberArk Identity Session available in the IdentityCommand.CEM scope
        foreach ($key in $IDSession.keys) {
            if ($null -ne $IDSession[$key]) {
                $ISPSSSession[$key] = $IDSession[$key]
            }
        }

        #Set the Cloud Visibility URL in the session data
        $ISPSSSession.tenant_url = $tenant_url

    }#process

    end { }#end

}
