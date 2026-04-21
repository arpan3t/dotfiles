function Connect-MgGraphApi {
    param (
        [Parameter(Mandatory)]
        [ValidateSet("CreativeOne", "Wealth", "B2C")]
        [string] $Tenant
    )

    switch ($Tenant) {
        "CreativeOne" {
            $Params = @{
                ClientId = $C1Tenant.ClientId
                TenantId = $C1Tenant.TenantId
                CertificateThumbprint = $C1Tenant.CertificateThumbprint
                NoWelcome = $true
            }
        }
        "Wealth" {
            $Params = @{
                ClientId = $WealthTenant.ClientId
                TenantId = $WealthTenant.TenantId
                CertificateThumbprint = $WealthTenant.CertificateThumbprint
                NoWelcome = $true
            }
        }
        "B2C" {
            $Params = @{
                ClientId = $B2cTenant.ClientId
                TenantId = $B2cTenant.TenantId
                CertificateThumbprint = $B2cTenant.CertificateThumbprint
                NoWelcome = $true
            }
        }
    }

    Connect-MgGraph @Params
}
function Disconnect-MgGraphApi {
    Disconnect-MgGraph | Out-Null
}
function Connect-ExchOnline {
    param (
        [Parameter(Mandatory)]
        [ValidateSet("CreativeOne", "Wealth")]
        [string] $Tenant
    )

    switch ($Tenant) {
        "CreativeOne" {
            $Params = @{
                AppId = $C1Tenant.ClientId
                Organization = $C1Tenant.PrimaryDomain
                CertificateThumbprint = $C1Tenant.CertificateThumbprint
                ShowBanner = $false
            }
        }
        "Wealth" {
            $Params = @{
                AppId = $WealthTenant.ClientId
                Organization = $WealthTenant.PrimaryDomain
                CertificateThumbprint = $WealthTenant.CertificateThumbprint
                ShowBanner = $false
            }
        }
    }

    Connect-ExchangeOnline @Params
}
function Disconnect-ExchOnline {
    Disconnect-ExchangeOnline -Confirm:$false | Out-Null
}
function Connect-Azure {
    param (
        [Parameter()]
        [ValidateSet("CreativeOne","ZBC1")]
        [string] $Subscription = "CreativeOne"
    )
    if ($Subscription -eq "CreativeOne") {
        Connect-AzAccount -Subscription "c1781b28-2ca4-4605-a259-1e15c1caa118" | Out-Null
    }
    else {
        Connect-AzAccount -Subscription "fce38f07-aa86-432c-a377-e3f2ee6e97fa" | Out-Null
    }
}
function Disconnect-Azure {
    Disconnect-AzAccount | Out-Null
}
function Connect-Server {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [ValidateSet([AdServers])]
        [string] $ComputerName,

        [Parameter()]
        [pscredential] $Credential = $Zachbadm_Creds,

        [Parameter()]
        [string] $ConfigurationName
    )

    $Busy = [System.Management.Automation.Runspaces.RunspaceAvailability]::Busy

    $ExistingSessions = Get-PSSession | Where-Object {
        ($_.ComputerName -eq $ComputerName) -and ($_.Availability -ne $Busy)
    }

    if ($PSBoundParameters.ContainsKey("ConfigurationName")) {
        $ExistingSessions = $ExistingSessions | Where-Object { $_.ConfigurationName -eq $ConfigurationName }
    }

    if ($null -eq $ExistingSessions) {
        Enter-PSSession @PSBoundParameters
    }
    elseif ($ExistingSessions.Count -eq 1) {
        Enter-PSSession -Session $ExistingSessions
    }
    else {
        foreach ($Session in $ExistingSessions) {
            $Label = "[DarkCyan bold]Name[/]: {0} | [DarkCyan bold]Id[/]: {1} | [DarkCyan bold]ConfigName[/]: {2}"
            $Label = $Label -f $Session.Name, $Session.Id, $Session.ConfigurationName
            $Session | Add-Member -MemberType NoteProperty -Name Label -Value $Label
        }

        $SelectionParams = @{
            Choices = $ExistingSessions
            ChoiceLabelProperty = "Label"
            Message = "[DarkCyan bold]MODIFY DISTRIBUTION GROUP[/]"
            PageSize = 10
        }

        $Selected = Read-SpectreSelection @SelectionParams

        Enter-PSSession -Session $Selected
    }
}
function New-ServerConnection {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [ValidateSet([AdServers])]
        [string] $ComputerName,

        [Parameter()]
        [pscredential] $Credential = $Zachbadm_Creds,

        [Parameter()]
        [string] $ConfigurationName
    )

    $NewSession = New-PSSession @PSBoundParameters

    return $NewSession
}

Class AdServers : System.Management.Automation.IValidateSetValuesGenerator {
    [string[]] GetValidValues() {
        $AvailableServers = [string[]](
            Get-AdComputer -Filter 'OperatingSystem -like "Windows Server*"' |
                Select-Object -ExpandProperty Name | Sort-Object
        )
        return $AvailableServers
    }
}

