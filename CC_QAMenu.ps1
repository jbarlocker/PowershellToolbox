﻿######################################################################
###   
###   Created By: Jake Barlocker
###   Created on:  3-JAN-2024
###   
###   
###   
###   
###   
###   
######################################################################






Function EndScript{ 
    break
}

Function QA-Menu{
Clear-Host

# https://fsymbols.com/generators/carty/
$Title = @"

QA and Testing Menu
   - For CheckCity Utah


by: Jake Barlocker
==================================================================================

"@
Function ListMenu{
    do
     {

         Remove-Variable MenuChoice -ErrorAction SilentlyContinue
         Clear-Host
         Write-Host $Title -ForegroundColor Cyan
         Write-Host ""
         Write-Host "Enter '1' - VPN Tester - Ping all subnets"
         <#Write-Host "Enter '2' - Sync all domain controllers, then sync to AzureAD"
         Write-Host "Enter '3' - Create new user in the checkcity.local domain"
         Write-Host "Enter '4' - Reset the Local Admin Password on all domain joined computers"
         Write-Host "Enter '5' - Scan domain servers for expiring certificates"
         Write-Host "Enter '6' - Reset your passwords on all domains"
         Write-Host "Enter '7' - Setup Automated Health Maintenance Tasks on local computer"
         Write-Host "Enter 'QA' - Enter the Quality Assurance and Testing Submenu"
#>
         Write-Host "Enter 'Q' to Quit"
         Write-Host ""
         $MenuChoice = Read-Host "Select an option"
     }
    until ($MenuChoice -match '[1-7,qQ,]')
    $Global:WindowsUpdates=$False
    $Global:DriverandFirmware=$False
    $Global:Confirm=$False

    if($MenuChoice -match 1){
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;Invoke-Expression('$module="Test_Subnets";$repo="PowershellScripts"'+(new-object net.webclient).DownloadString('https://raw.githubusercontent.com/jbarlocker/PowershellMenu/main/VPN_Route_Tester.ps1'));Test_Subnets
    }
    if($MenuChoice -match 2){
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;Invoke-Expression('$module="Sync_AD_and_AzureAD";$repo="PowershellScripts"'+(new-object net.webclient).DownloadString('https://raw.githubusercontent.com/jbarlocker/PowershellMenu/main/Sync_AD_and_AzureAD.ps1'));SyncAllActiveDirectory
    }
    if($MenuChoice -match 3){
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;Invoke-Expression('$module="Create_New_AD_User";$repo="PowershellScripts"'+(new-object net.webclient).DownloadString('https://raw.githubusercontent.com/jbarlocker/PowershellMenu/main/Create_New_AD_User.ps1'));Create_New_AD_User
    }
    if($MenuChoice -match 4){
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;Invoke-Expression('$module="Reset_Local_Admin_Passwords";$repo="PowershellScripts"'+(new-object net.webclient).DownloadString('https://raw.githubusercontent.com/jbarlocker/PowershellMenu/main/Reset_Local_Admin_Passwords.ps1'));ResetLocalAdminPassword
    }
    if($MenuChoice -match 5){
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;Invoke-Expression('$module="Scan_Domain_Servers_for_Expiring_Certificates";$repo="PowershellScripts"'+(new-object net.webclient).DownloadString('https://raw.githubusercontent.com/jbarlocker/PowershellMenu/main/Scan_Domain_Servers_for_Expiring_Certificates.ps1'));Scan_for_Certs
    }
    if($MenuChoice -match 6){
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;Invoke-Expression('$module="Reset_a_users_password_on_all_domains.ps1";$repo="PowershellScripts"'+(new-object net.webclient).DownloadString('https://raw.githubusercontent.com/jbarlocker/PowershellMenu/main/Reset_a_users_password_on_all_domains.ps1'));ResetAllDomainsPasswords
    }
    if($MenuChoice -match 7){
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;Invoke-Expression('$module="Create_Scheduled_Tasks_for_DISM_SFC_and_Weekly_Reboot.ps1";$repo="PowershellScripts"'+(new-object net.webclient).DownloadString('https://raw.githubusercontent.com/jbarlocker/PowershellMenu/main/Create_Scheduled_Tasks_for_DISM_SFC_and_Weekly_Reboot.ps1'));CreateScheduledTasks
    }
    if($MenuChoice -match 'qa'){
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;Invoke-Expression('$module="Create_Scheduled_Tasks_for_DISM_SFC_and_Weekly_Reboot.ps1";$repo="PowershellScripts"'+(new-object net.webclient).DownloadString('https://raw.githubusercontent.com/jbarlocker/PowershellMenu/main/Create_Scheduled_Tasks_for_DISM_SFC_and_Weekly_Reboot.ps1'));CreateScheduledTasks
    }

    if($MenuChoice -imatch 'q'){
        Write-Host "Ending..." -ForegroundColor Red
        EndScript
    }

}#End of ShowMenu
ListMenu
}
