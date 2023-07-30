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
function New-BHUserEmail {
    # Parameters
    Param(
        # sAMAccountName
        [Parameter(Mandatory)]
        $SamAccountName,

       # First Name
        [Parameter(Mandatory)]
        $FirstName,

       # Last Name
        [Parameter(Mandatory)]
        $LastName,

         # Manager
        [Parameter(Mandatory)]
        $ManagerMail,

        # Display Name
        [Parameter(Mandatory)]
        $TicketNumber,

        # Job title
        [Parameter(Mandatory)]
        $JobTitle,

        # Display Name
        [Parameter(Mandatory)]
        $Dept,

        # Users Email Address
        [Parameter(Mandatory)]
        $UsersEmail,

        # Managers Display Name
        #[Parameter(Mandatory)]
        $MgrsDName


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
    

    #BCC  
    $Bcc = $From
    
    #Mail to
    #$Mailto = "ITSupport@braemarhospital.co.nz", $ManagerMail, "JACKM@braemarhospital.co.nz"
    $Mailto = $ManagerMail, "JACKM@braemarhospital.co.nz"
    # User
    #$User = Get-ADUser $SamAccountName -Properties DisplayName
    #$UserMail = $Email
    #$UserName = $User.DisplayName

    # Subject
    $Subject = "re: New User login for: $FirstName $LastName - $TicketNumber"

    # Define Body
    $Body = "Hi $MgrsDName,<br><br>



A new network account has been created for $FirstName and details of this account are as follows:<br><br>

User ID:       $SamAccountName <br>
Job Title:     $JobTitle <br>
Department:    $Dept <br>
Password:      To be given on day of orientation <br>
Email Address: $UsersEmail <br><br>

Please advise when I can schedule an appointment for $FirstName to attend an orientation at IT office. <br><br>

Kind regards <br><br>

IT Support
    "

    # Send Email
    Send-MailMessage -From $From -To $Mailto -Bcc $Bcc -Subject $Subject -Body $Body -SmtpServer $SMTPServer -port $SMTPPort -BodyAsHtml #-Credential $Credential 
}

