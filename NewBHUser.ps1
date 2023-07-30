<#

EnployeeID processed by Get-BraemarEmploeeID function.  EmployeeID returned if ID is a unique value

.DESCRIPTION
Once unique empid value is returned, further checks are carried out to check availability of username, displayname and replace any illegal characters

.Example
new-braemaruser c:\temp\newemployee
.NOTES
Author Jack Muriwai

#>

Function New-BraemarUser{

<#Parameters
Param(
[Parameter(Mandatory)]
#[ValidatePattern('^\d+$')]
$EmployeeID
)
#>

# Param
Param(
[Parameter(Mandatory)]
$GetEmpFile
)


# Get employee data from CSV File
#$GetEmpFile = "C:\temp\NewEmployee.csv"
$GetEmpDetails = Import-Csv $GetEmpFile 

$LoadEmpDetails = $GetEmpDetails

ForEach($LoadEmpDetails in $GetEmpDetails) { 

# Create Password
$AccountPassword = "ABCD!$((Get-Date).DayOfWeek)!$((get-date).Millisecond)"
$SecureAccountPassword = ConvertTo-SecureString -String $AccountPassword -AsPlainText -Force

# Get ticket reference from New Employee csv file
$TicketNumber = $($LoadEmpDetails.TicketID)

#Get Employee ID
$EmployeeID = $($LoadEmpDetails.EmployeeID)
Get-BraemarEmployeeID  $EmployeeID

# Get fname, lname and displayname
#$FirstName = $($LoadEmpDetails.FirstName)
$FirstName = $($LoadEmpDetails.FirstName)
$LastName = $($LoadEmpDetails.LastName)
$DisplayName = "$FirstName $LastName"

# Get Manager based on Createdby field in CSV file and extract email address and samaccountname
$GetManager = $($LoadEmpDetails.CreatedBy)
$SetManager = Get-ADUser -Filter {DisplayName -like $GetManager} -Properties * | Select-Object EmailAddress, SamaccountName, DisplayName
$ManagersEmail = $($SetManager.EmailAddress)
$ManagersSamaccountName = $($SetManager.SamaccountName)
$ManagersDisplayName = $($SetManager.DisplayName)


# Validation - Check for whitespace or digits
If($FirstName -ne $LoadEmpDetails.FirstName.Trim() -or
$FirstName -match "\d+" -or
$LastName -ne $LoadEmpDetails.LastName.Trim() -or
$LastName -match "\d+"){
Throw "Validation Failed: New-BraemarUser failed to create new user with employee id $EmployeeID!"
}

# Define Username and UPN
$NewBraemarUserName = New-BraemarUserName $FirstName $LastName
If(!($NewBraemarUserName)){ throw "New-BraemarUserName failed to create SamAccountName or UPN"} 

#Write-Host "Creating: " $NewBraemarUserName[0]  " | UPN: "  $NewBraemarUserName[1] " | Password: " $AccountPassword

$RetrieveSamaccountName = $NewBraemarUserName[0]
$UserPrincipleName = $NewBraemarUserName[1]

# Check if display name exists
if(!(Get-AdUser  -Filter {DisplayName -like $DisplayName} -Properties * | Select DisplayName, samaccountname)){

 Write-host "No display name currently exists for $DisplayName with SamaccountName $RetrieveSamaccountName." -ForegroundColor Green
 #Write-Host "Creating: " $NewBraemarUserName[0]  " | UPN: "  $NewBraemarUserName[1] " | Password: " $AccountPassword -ForegroundColor Green
  Write-Host "Creating: " $RetrieveSamaccountName  " | UPN: "  $UserPrincipleName " | Password: " $SecureAccountPassword -ForegroundColor Green
 }
 else{
 Write-Host "$DisplayName with $RetrieveSamaccountName already exists." -ForegroundColor Red
 Write-Host "Please check account details or modify display name to a unique value and try again" -ForegroundColor Red
 Write-Host "Script now exiting!" -ForegroundColor Red
 Break;
 }

# Variable to contain group to exclude from users AD Object membership
$GroupsToExclude = 'Domain User'

# Check if new user is corporate staff/Vendor.  
# If user is a vendor then [41] will need to be selected from the list of Corporate roles
Write-Host "Is the new staff Corporate or Clinical or Vendor!" -ForegroundColor Yellow
$CorpPrompt = Read-Host "Enter [1] for Corporate OR [2] for Clinical Or [3] for a Vendor: " 

######################################################################################
# Get corporate roles
if($CorpPrompt -eq "1") {
$DeptPrompt = Read-host "

[1] Administration - Medical Records Administrator
[2] Administration - Reception
[3] Administraton - Medicals Records Manager
[4] Administration - General Assistance
[5] Education - Nurse Advisor
[6] Education - Nurse Manager
[7] Facilities - Maintenance Manager
[8] Facilities - Maintenance Staff
[9] Finance -Accounts Administrator
[10] Finance - Accounts Payable Lead Temp
[11] Finance - Assistant Accountant
[12] Finance - Assistant
[13] Finance - Consultant
[14] Finance - Manager
[15] Finance - Team Member
[16] Finance - Invoice Administrator
[17] Finance - Invoice Lead
[18] Hospitality - Chef
[19] Hospitality - Executive Chef
[20] Hospitality - Hospital Service Manager
[21] Hospitality - Housekeeper Team Leader
[22] Hospitality - Kitchen/Housekeep Staff
[23] Hospitality - Laundry Supervisor
[24] HR Advisor - HR Advisor
[25] IT - IT Staff
[26] Office Manager - Office Manager
[27] Patients Service Manager - Patients Service Manager
[28] Payroll - Manager
[29] Payroll - Analyst
[30] Quality and Risk - Infection Prevention Control
[31] Quality and Risk - QR Manager
[32] Safety and Wellness - Advisor
[33] Stores - Purchase and Supply Officer
[34] Stores - Manager
[35] Chief Executive Officer
[36] Chief Financial Officer
[37] General Manager - Clinical Services
[38] General Manager - Commercial Services
[39] General Manager - People and Safety
[40] General Manager - Executive Assistant
Select department number [1-40]"

# Passes control to Set-OUCorpLocation to set membership and AD Object Membership
$GetADCorpLocation = Set-OUCorpLocation $DeptPrompt
$SetOUlocation = $GetADCorpLocation[0]
$SetTemplate = $GetADCorpLocation[1]
$SetDepartment = $GetADCorpLocation[2]
$SetJobTitle = $GetADCorpLocation[3]
}

#########################################################################################################
# Get Clinical ROles
elseif($CorpPrompt -eq "2") {
$DeptPrompt = Read-host "

[1] Anaesthetic - Technician
[2] Anaesthetic - Technician Trainee
[3] Anaesthetic - Anaesthetic Technician Supervisor
[4] CSSD - Endoscopy Coordinator
[5] CSSD - Supervisor
[6] CSSD - Technician
[7] CSSD - Assistant
[8] CSSD - Sterilisation Technician
[9] CSSD - Loans Coordinator
[10] Day Stay - Registered Nurse
[11] Day Stay - Charge Nurse
[12] PACU - Registered Nurse
[13] PACU - Charge Nurse
[14] Pre-Admission - Administrator
[15] Pre-Admission - Service Lead
[16] Pre-Admission - Registered Nurse
[17] SCU - Registered Nurse
[18] SCU - Lead Clinician
[19] SCU - Cardiac Resource Nurse
[20] SCU - Charge Nurse
[21] Theatre - Exact Dental Resource Nurse
[22] Theatre - Charge Nurse
[23] Theatre - Dental Resource Nurse
[24] Theatre - ENT Resource Nurse
[25] Theatre - Healthcare Assistant
[26] Theatre - Registered Nurse
[27] Theatre - Coordinator
[28] Theatre - Orthopaedics Charge Nurse
[29] Theatre - Urology and Vascular Resource Nurse
[30] Theatre - Administrator
[31] Ward - Inpatient Charge Nurse
[32] Ward - Associate Charge Nurse
[33] Ward - HCA Nurse
[34] Ward - Healthcare Assistant
[35] Ward - Enrolled Nurse
[36] Ward - Registered Nurse
[37] Ward - Coordinator
[38] Ward - Patient Service Administrator
Select department number [1-38]"

# Passes control to Set-OUClinincalocation to set membership and AD Object Membership
$GetADClinicalLocation = Set-OUClinicalLocation $DeptPrompt
$SetOUlocation = $GetADClinicalLocation[0]
$SetTemplate = $GetADClinicalLocation[1]
$SetDepartment = $GetADClinicalLocation[2]
$SetJobTitle = $GetADClinicalLocation[3]

}

######################################################################################################
# Get Vendor roles
elseif($CorpPrompt -eq "3"){

$DeptPrompt = Read-host "

[1] Vendor - Anthrex
[2] Vendor - Dedalus
[3] Vendor - Olympus
[4] Vendor - Contractor (Default)

Select department number [1-4]"

# Passes control to Set-OUClinincalocation to set membership and AD Object Membership
$GetADVendorLocation = Set-OUVendorLocation $DeptPrompt
$SetOUlocation = $GetADVendorLocation[0]
$SetTemplate = $GetADVendorLocation[1]
$SetDepartment = $GetADVendorLocation[2]
$SetJobTitle = $GetADVendorLocation[3]

}else{

Throw "ERROR: You must enter [1] for Corporate OR [2] for Clinical Or [3] for a Vendor:  - Script will exit! " 

}



#############################################################################################################
# Create new aduser object
New-ADUser  -SamAccountName $NewBraemarUserName[0]`
            -Name $DisplayName `
            -UserPrincipalName $UserPrincipleName `
            -Path $SetOUlocation `
            -AccountPassword $SecureAccountPassword `
            -ChangePasswordAtLogon $true `
            -Enabled $true `
            -DisplayName $DisplayName `
            -EmployeeID $EmployeeID `
            -Title $SetJobTitle `
            -Description "Braemar User Accoount" `
            -Company "Braemar Hospital" `
            -Department $SetDepartment `
            -GivenName $FirstName `
            -Surname $LastName `
            -Manager $ManagersSamaccountName `
            -Instance $SetTemplate 


$CDate = Get-Date
$DName = $DisplayName
$SName = $RetrieveSamaccountName

# Output user account details to csv file
$csvfile = "c:\Temp\New User Info.txt"

# Get date new account created
$GetADUser = Get-ADUser $RetrieveSamaccountName -Properties UserPrincipalName | Select-Object UserPrincipalName

# Output user account details to csv file
# Create PSCustomObject hash table
$hash = @{
             "Created" = $CDate
             "DisplayName" = $DisplayName
             "Username" = $RetrieveSamaccountName
             "Password" = $AccountPassword
              }

#########################################################################################################################
# Create new user file to store account infoif it does not exist otherwise update existing file 
if(!(Test-Path $csvfile)){

Write-Host "$csvfile file does not exist and will be created." -ForegroundColor Magenta

# Create file if does not exist
$headers =  "Created","DisplayName", "Username", "Password"
$psobject = New-Object psobject

foreach($header in $headers)
 {
  Add-Member -InputObject $psobject -MemberType noteproperty -Name $header -Value ""
 }
$psobject | Export-Csv $csvfile -NoTypeInformation

Write-Host "$csvfile file  created and will be updated. " -ForegroundColor Green

$newRow = New-Object PsObject -Property $hash
Export-Csv $csvfile -inputobject $newrow -append -Force
}

##############################################################################################################################
# Update file with user account details if the file already exists
else{ 
Write-Host "Success: File $csvfile exists - Updating $csvfile with new data" -ForegroundColor green

$newRow = New-Object PsObject -Property $hash
Export-Csv $csvfile -inputobject $newrow -append -Force
    
    
Write-host "New user account data will be appended to $Outfile file" -ForegroundColor green
}

######################################################################################################################################
# Find specific user Template and apply group membership to new account
$GetTemplateGroups = (Get-ADPrincipalGroupMembership -Identity $SetTemplate).samaccountname | Where-Object { $_ -NotMatch $GroupsToExclude } | foreach { 
Add-ADPrincipalGroupMembership -Identity $RetrieveSamaccountName -MemberOf $_ }

DO{

if($ConfirmUserExist = Get-ADUser $NewBraemarUserName[0]){
write-host "checking if ADUser $RetrieveSamaccountName exists in ACtive Directory" -ForegroundColor Magenta
}
else{

Write-Host "Woohoo! ADuser for $DisplayName has been created :)" -ForegroundColor Green }
}while(!($ConfirmUserExist)) 
Write-Host "Woohoo! ADuser for $DisplayName has been created :)" -ForegroundColor Green

##############################################################################################################################
# Begin configuring Vendor account
if($CorpPrompt -eq '3') {
Write-host "Script will configure user account as a Vendor account" -ForegroundColor Magenta

# Set script path for vendor account
Get-ADUser $NewBraemarUserName[0] -Properties * | Set-ADUser -ScriptPath "SBS_LOGIN_SCRIPT.bat"

# Set only the Home Folder for vendor
Set-ADUser -Identity $NewBraemarUserName[0] -HomeDrive "h:" 
Set-ADUser -Identity $NewBraemarUserName[0]  -HomeDirectory "\\braemarnz.local\dfs\users\$RetrieveSamaccountName"

Set-ADUser -Identity $NewBraemarUserName[0] -ChangePasswordAtLogon:$False

$SetOrg = Read-Host " Enter vendor Organisation: "
$Org = "$SetOrg Vendor Account"
Set-ADUser -Identity $NewBraemarUserName[0] -Description $Org
Set-ADUser -Identity $NewBraemarUserName[0] -Company $SetOrg


$SetEmailAddress = Read-host "Enter vendors email address: "
Set-ADUser -Identity $NewBraemarUserName[0] -EmailAddress $SetEmailAddress
$VendorsEmail = Get-ADUser $NewBraemarUserName[0] -Properties EmailAddress | Select-Object EmailAddress

$SetPhoneNumber = Read-Host "Enter vendors mobile phone number: "
Set-ADUser -Identity $NewBraemarUserName[0] -Replace @{TelephoneNumber= $SetPhoneNumber}
#Set-ADUser -Identity $NewBraemarUserName[0] -MobilePhone  $SetPhoneNumber

$SetVJobTitle = Read-Host "Enter vendors job title: "
Set-ADUser -Identity $NewBraemarUserName[0] -Replace @{Title=$SetVJobTitle}

# Get email address
$Mail = Get-ADUser $RetrieveSamaccountName -Properties Mail | Select-Object Mail
$SendEmailTO = $($Mail.EmailAddress)

# Get DUO Link
Write-Host "Please log into DUO management console and get DUO Link"
$DUOLink = Read-Host "Enter DUO Link: "

# Get 1tyme password
Write-Host "Use a password generator to generate a complex password. " -ForegroundColor Magenta
$OneTimePWLink = Read-Host "Enter 1tyme password link :"

Write-Host "Vendor account configuration completed." -ForegroundColor Green

Write-Host "Creating email to be sent to Vendor and $GetManager" -ForegroundColor Magenta
New-BHVendorUserEmail $RetrieveSamaccountName $FirstName $LastName $($VendorsEmail.emailaddress) $ManagersSamaccountName $TicketNumber $SetVJobTitle $SetDepartment $DUOLink
Write-Host "email created and sent to Vendor and $GetManager " -ForegroundColor Green

Write-Host "Creating email to send password" -ForegroundColor Magenta
Send-BHVendorPW $FirstName $($VendorsEmail.emailaddress) $TicketNumber $OneTimePWLink
Write-Host "email with password sent to vendor ! " -ForegroundColor Green
}

# Continue setting up standard user acccount if it does not belong to a vendor
else{
$ProfilePath = "\\braemarnz.local\dfs\XPProfiles\" + $NewBraemarUserName[0]
Get-ADUser $NewBraemarUserName[0] -Properties ProfilePath | Set-ADUser -ProfilePath $ProfilePath

# Set Script Path
Get-ADUser $NewBraemarUserName[0] -Properties * | Set-ADUser -ScriptPath "SignatureScriptTest.vbs"

# Connect to Homefolder
Set-ADUser -Identity $NewBraemarUserName[0] -HomeDrive "h:" 
Set-ADUser -Identity $NewBraemarUserName[0]  -HomeDirectory "\\braemarnz.local\dfs\users\$RetrieveSamaccountName"

#Create pssession to exchange server
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://BRAHYEXCH01.braemarnz.local/powershell/ -Authentication Kerberos 

# Import session
Import-PSSession $Session -DisableNameChecking

# Enable remote mailbox on EoL
Enable-RemoteMailbox $RetrieveSamaccountName -RemoteRoutingAddress "$RetrieveSamaccountName@braemarhospital.mail.onmicrosoft.com" | Out-Null

#Set mailbox policy 
Set-RemoteMailbox -Identity $RetrieveSamaccountName -EmailAddressPolicy $true | Out-Null

#Remove PSession
Get-PSSession | Remove-PSSession 

# Send email to Manager
Write-Host "Creating email to be sent to Manager of New Staff member" -ForegroundColor Magenta
New-BHUserEmail $RetrieveSamaccountName $FirstName $LastName $ManagersEmail $TicketNumber $SetJobTitle $SetDepartment  $UserPrincipleName $GetManager
Write-Host "email created and sent to $ManagersDisplayName " -ForegroundColor Green

}
}
}