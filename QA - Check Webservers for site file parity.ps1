﻿#################################################################################
###   
###   Created On:  9-JAN-2024
###   Created By:  Jake Barlocker
###   
###   This script will compare the data for all sites on both servers.
###   
###   
###   
###   
#################################################################################




Function Webserver_File_Parity_Check {



Clear

# get the credentials of the user running the script.
$Credential = Get-Credential -UserName "checkcity\" -Message "Enter your credentials."




Write-Host "Running..." -ForegroundColor Yellow

# Populate variable for the time at the begininng of the script
$StartTime = (Get-Date)



# Create an array with both servers in it
$IISservers = @(
                "CCDBWebApp02.checkcity.local";
                "CCDBWebApp03.checkcity.local";
                )


# Delete the variable in case this script is being tested and already has data in it
Remove-Variable ResultsArray -ErrorAction SilentlyContinue

# Create the array for results
$ResultsArray = @()

                                  # create sessions to IIS Servers
                                  $Session01 = New-PSSession -ComputerName $IISservers[0]
                                  $Session02 = New-PSSession -ComputerName $IISservers[1]

                                  # Get a list of sites from IIS on the first server
                                  $Sites01 = Invoke-Command -Session $Session01 { Import-Module WebAdministration; Get-Childitem -Path IIS:\Sites }
                                  $Sites02 = Invoke-Command -Session $Session02 { Import-Module WebAdministration; Get-Childitem -Path IIS:\Sites }
                                  
                                  # Check to see if the same sites are build on both servers
#                                  If ($Sites01.Name -eq $Sites02.Name) { Write-Host "The Sites are the same on both servers" -ForegroundColor Green } else {Write-Host "The Sites are NOT the same on both servers" -ForegroundColor Red}

                                  Foreach ($Site in $Sites01){
                                                              # Get the file data from each server
                                                              $SiteFilesFromServer01 = Invoke-Command -Session $Session01 { Get-ChildItem -Path $Using:Site.physicalPath -ErrorAction SilentlyContinue }
                                                              $SiteFilesFromServer02 = Invoke-Command -Session $Session02 { Get-ChildItem -Path $Using:Site.physicalPath -ErrorAction SilentlyContinue }
                                                              
                                                              # Calculate the file data for each server
                                                              $FileInformationFromServer01 = $SiteFilesFromServer01 | Measure-Object -Property Length -sum
                                                              $FileInformationFromServer02 = $SiteFilesFromServer02 | Measure-Object -Property Length -sum

                                                              # Check to see if both servers data size and count are the same
                                                              $FileSizeSame = If ($FileInformationFromServer01.Sum -eq $FileInformationFromServer02.Sum) {"Yes"} else {"Not Same"}
                                                              $FileCountSame = If ($FileInformationFromServer01.Count -eq $FileInformationFromServer02.Count) {"Yes"} else {"Not Same"}

                                                              # Add all the calculated data to the results array
                                                              $ResultsArray += [pscustomobject]@{
                                                                                                 SiteName = $Site.name
                                                                                                 Path = $Site.physicalPath
                                                                                                 CCDBWebApp02FileSize = $FileInformationFromServer01.Sum
                                                                                                 CCDBWebApp03FileSize = $FileInformationFromServer02.Sum
                                                                                                 FileSizeSame = $FileSizeSame
                                                                                                 CCDBWebApp02NumberOfFiles = $FileInformationFromServer01.Count
                                                                                                 CCDBWebApp03NumberOfFiles = $FileInformationFromServer02.Count
                                                                                                 FileCountSame = $FileCountSame
                                                                                                 }

                                                              }
                                  
# Close all open sessions                                  
Get-PSSession | Remove-PSSession


# Populate variable for the time at the end of the script
$EndTime = (Get-Date)


# Calculate elapsed time
Write-Host "This script took this long to run: " $($EndTime - $StartTime) -ForegroundColor Yellow


# output the result in gridview
$ResultsArray | Out-GridView



}
