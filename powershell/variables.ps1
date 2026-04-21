# VARIABLES #

# Credentials
function Unlock-Credentials {
    Set-Variable -Name C1_365_Creds -Value (Get-Secret -Name C1_O365) -Scope Global
    Set-Variable -Name C1W_365_Creds -Value (Get-Secret -Name C1W_O365) -Scope Global
    Set-Variable -Name Zachbadm_Creds -Value (Get-Secret -Name ZachbAdmin) -Scope Global
    Set-Variable -Name Dave_WebServer_Creds -Value (Get-Secret -Name Dave_WebServer) -Scope Global
}

# Microsoft Graph / Exchange Online
Set-Variable -Name C1Tenant -Value @{
    ClientId = "d9ab98df-2c51-4795-a2c7-5c76a8feae43"
    TenantId = "1807ebe1-1f00-4db9-b3a8-5b43b6325a24"
    PrimaryDomain = "creativeone0.onmicrosoft.com"
    CertificateThumbprint = "A4DFDD90AA61EED4ABD7DE3D86384C4F54FABBDF"
}

Set-Variable -Name WealthTenant -Value @{
    ClientId = "d9ab98df-2c51-4795-a2c7-5c76a8feae43"
    TenantId = "c21848e1-cddb-4dc8-9d79-0d9af864869a"
    PrimaryDomain = "NETORG1968055.onmicrosoft.com"
    CertificateThumbprint = "A4DFDD90AA61EED4ABD7DE3D86384C4F54FABBDF"
}

# Azure Active Directory B2C
Set-Variable -Name B2cTenant -Value @{
    ClientId = "5bf5f957-c012-4191-9512-e32069199597"
    TenantId = "8ba02b95-467a-4233-bcdf-8df326a2c8ef"
    PrimaryDomain = "creativeoneidp.onmicrosoft.com"
    CertificateThumbprint = "CFE36C94232BE0F34FF4FE70BB2624B6005E3CE1"
}

# Azure
Set-Variable -Name AzureSubscriptions -Value @{
    ZBC1 = "fce38f07-aa86-432c-a377-e3f2ee6e97fa"
    C1 = "c1781b28-2ca4-4605-a259-1e15c1caa118"
}
