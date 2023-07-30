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
function Send-BHVendorPW {
    # Parameters
    Param(

         # First Name
        [Parameter(Mandatory)]
        $FirstName,

       # Display Name
        [Parameter(Mandatory)]
        $VendorsEmail,

        # Display Name
        [Parameter(Mandatory)]
        $TicketNumber,

         # Password Link
        [Parameter(Mandatory)]
        $PLink
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
           
    # Bcc
    $Bcc = $From

    # Mail to
    $Mailto = $From, $ManagersEmail, $VendorsEmail, "ITSupport@braemarhospital.co.nz"

    # Subject
    $Subject = "re: Additional account info for: $FirstName - $TicketNumber"

    # Define Body
    $Body = "Hi $FirstName,<br><br>


Please follow link to obtain your password:<br><br>

Password link:      $PLink <br><br>


Kind regards <br><br>

IT Support
    "

    # Send Email
    Send-MailMessage -From $From -To $Mailto -Bcc $Bcc -Subject $Subject -Body $Body -SmtpServer $SMTPServer -port $SMTPPort -BodyAsHtml #-Credential $Credential 
}

