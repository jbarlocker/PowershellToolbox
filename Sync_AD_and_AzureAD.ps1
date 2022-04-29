﻿

function SyncAllActiveDirectory {

clear

Write-Host "Initiating Synchronizations on Domain Controllers..." -ForegroundColor Green

# replicate all domain controllers
(Get-ADDomainController -Filter *).Name | Foreach-Object {repadmin /syncall $_ (Get-ADDomain).DistinguishedName /e /A | Out-Null}; Start-Sleep 10; Get-ADReplicationPartnerMetadata -Target "$env:userdnsdomain" -Scope Domain | Select-Object Server, LastReplicationSuccess



Write-Host ""
Write-Host "Initiating Synchronizations to Azure Active Directory..." -ForegroundColor Green

#Import modeult to sunc to Azure AD
Import-Module ADSync

# replicate to Azure AD (sync changes)
Start-ADSyncSyncCycle -PolicyType Delta

# replicate to Azure AD (full sync)
#Start-ADSyncSyncCycle -PolicyType Initial




                                }