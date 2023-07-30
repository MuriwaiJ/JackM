<#
.SYNOPSIS
   TODO

.DESCRIPTION
   TODO

.EXAMPLE
   New-WDHBUserEmail sAMAccountName Password
   New-WDHBUserEmail ButlerA Password$1234

.NOTES
   Author: JackM@braemarhospital.co.nz
#>

# Function New-WDHBUserEmail
function New-BHVendorUserEmail {
    # Parameters
    Param(
        # Vendors sAMAccountName
        [Parameter(Mandatory)]
        $SamAccountName,

       # Vendors First Name
        [Parameter(Mandatory)]
        $FirstName,

        # Vendors Last Name
        [Parameter(Mandatory)]
        $LastName,

       # Vendors email
        [Parameter(Mandatory)]
        $VendorsEmail,

        # Managers Samaccountname
        [Parameter(Mandatory)]
        $MngrsSamaccount,

        # Ticket Numbe
        [Parameter(Mandatory)]
        $TicketNumber,

        # Vendors Job title
        [Parameter(Mandatory)]
        $JobTitle,

        # Vendor Dept
        [Parameter(Mandatory)]
        $Dept,
        
        # DUO Link
        [Parameter(Mandatory)]
        $Dlink
        
          )


    # SMTP
    $SMTPServer = "brahyexch01.BRAEMARNZ.local"
    $SMTPPort = "25"
   
    # From
    $RemoveHyphenADM = (Get-ADUser $env:UserName  -Properties SamaccountName).samaccountname -replace "adm_", ""
    $From = (Get-ADUser $RemoveHyphenADM -Properties Mail).Mail
    #$From = (Get-ADUser $env:UserName -Properties Mail).Mail
    If (!$From) { throw "$env:UserName has no email to send from" }
    $FromName = (Get-ADUser $env:UserName -Properties DisplayName).DisplayName
    If (!$FromName) { $FromName = $env:UserName }

    # attachments
    $attachment = "C:\Users\JackM\Braemar Hospital\IT - Documents\General\Guide-How to\Vendor\Onboarding Vendor Remote Access.pdf"

 
    # Manager
    $Manager = Get-ADUser $MngrsSamaccount -Properties * | Select-Object Mail, DisplayName # .\base.ps1-ErrorAction SilentlyContinue
    If ($Manager) { 
        # Has Manager
        #$Manager2 = $Manager #| Get-ADUser -Properties DisplayName,Mail
        $ManagerMail = $Manager.Mail
        $ManagerName = $Manager.DisplayName
    } Else {
        # No Manager
        $ManagerMail = $From
        $ManagerName = "&#60;No Manager Defined&#62;"
    }

   # $ManagerMail = "JackM@braemarhospital.co.nz"  #>
    
    # Bcc
    $Bcc = $From #,"JackM@braemarhospital.co.nz"
    #$Bcc = $From #,"JackM@braemarhospital.co.nz"
    #$Mailto = "ITSupport@braemarhospital.co.nz", $ManagerMail
    #$Mailto = "Jackm@braemarhospital.co.nz" , $ManagersEmail 
    # User
    #$User = Get-ADUser $SamAccountName -Properties DisplayName
    #$UserMail = $Email
    #$UserName = $User.DisplayName
    $Mailto = $From, $VendorsEmail, $ManagerMail 

    # Subject
    $Subject = "re: New User login for Vendor: $FirstName $LastName - $TicketNumber"

    # Define Body
    $Body = "Hi $ManagerName ,<br><br>



A new network account has been created for $FirstName $LastName and details of this account are as follows:<br><br>

User ID:       $SamAccountName <br>
Job Title:     $JobTitle <br>
Department:    $Dept <br>
Password:      Password will be sent to you in a separate email <br><br>


Please advise if you need additional training on access remote connection. <br><br>

Refer to attached document on how to complete onboarding vendor remote access. <br><br>

Following link is to be used with attached document. <br><br>

DUO activation link = $Dlink <br><br>


Kind regards <br><br>

IT Support
    "

    # Send Email
    Send-MailMessage -From $From -To $Mailto -Bcc $Bcc -Subject $Subject -Body $Body -SmtpServer $SMTPServer -Attachments $attachment -port $SMTPPort -BodyAsHtml #-Credential $Credential 
}

