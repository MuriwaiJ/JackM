 <#
.SYNOPSIS
   New User Name

.DESCRIPTION
   Define new username (SamAccountName & UPN) basied on GivenName & SurName

.EXAMPLE
   New-WDHBUserName <GivenName> <SurName>
   New-WDHBUserName Jack Muriwai

.NOTES
   Author: jackm@braemarhospital.co.nz
#>

# Function
function New-BraemarUserName{
   # Parameters
   Param(
      # FirstName Name
      [Parameter(Mandatory)]
      $FirstName,

      # SurName Name
      [Parameter(Mandatory)]
      $LastName
   )
   # Convert special characters
   $replaceTable = @{"ÃŸ"="ss";"Ã "="a";"Ã¡"="a";"Ã¢"="a";"Ã£"="a";"Ã¤"="a";"Ã¥"="a";"Ã¦"="ae";"Ã§"="c";"Ã¨"="e";"Ã©"="e";"Ãª"="e";"Ã«"="e";"Ã¬"="i";"Ã­"="i";"Ã®"="i";"Ã¯"="i";"Ã°"="d";"Ã±"="n";"Ã²"="o";"Ã³"="o";"Ã´"="o";"Ãµ"="o";"Ã¶"="o";"Ã¸"="o";"Ã¹"="u";"Ãº"="u";"Ã»"="u";"Ã¼"="u";"Ã½"="y";"Ã¾"="p";"Ã¿"="y"}
   ForEach ($key in $replaceTable.Keys) {
      $FirstName = $FirstName -Replace ($key,$replaceTable.$key)
      $LastName = $LastName -Replace ($key,$replaceTable.$key)
   }
   
   # Remove non letters from names to prevent Sam & UPN containing special characters
   $FName = $FirstName -Replace '[^a-zA-Z-]', ''
   $LName = $LastName -replace '[^a-zA-Z-]', ''
   
   # Define sAMAccountName
   $NameStrLength = $FirstName + $LastName
   $SamAccountNameLength = $NameStrLength.length
   $SamAccountNameSub = 0

   Do {
      $SamAccountNameSub++
      $FNameLength = ($FName | Measure-Object -Character).Characters
      $LNameLength = ($LName | Measure-Object -Character).Characters
      #If ($SamAccountNameSub -gt $FNameLength) {throw "Error: No combinations found"}
      If ($SamAccountNameSub -gt $samaccountNameLength) {throw "Error: No combinations found"}

      If ($FNameLength -le $($SamAccountNameLength-$SamAccountNameSub)) {$SamAccountName = $FName + $LName.Substring(0,$SamAccountNameSub)}
      Else {$SamAccountName = $FName + $LName.Substring(0,$sAMAccountNameSub)}
      
      # Check SAMAccountName
      If ($(Get-ADUser -Filter {SamAccountName -eq $sAMAccountName})) {
         Write-Host "Error: $SamAccountName Exists" -Foregroundcolor red
      } else {
         Write-Host "Success: $SamAccountName SamAccountName is available" -Foregroundcolor green
      }
   } 
   While ($(Get-ADUser -Filter {SamAccountName -eq $SamAccountName}))
   
   # Define UPN
   $UPN = $SamAccountName
   $UPNNumber = 0
   Do {
      If ($UPNNumber -eq 0) {$UPN = $SamAccountName}
      Else {$UPN = $FName + $SName.substring(0,$UPNNumber)}
      $UPNNumber++

      # Check UPN
      If ($(Get-ADUser -Filter "
         UserPrincipalName -eq '$($UPN + "@BraemarHospital.co.nz")' ")) {
         Write-Host "Error: $UPN Exists" -Foregroundcolor red
      } else {
         Write-Host "Success: $UPN UPN is available" -Foregroundcolor green
      }
   }
   While ($(Get-ADUser -Filter "
      UserPrincipalName -eq '$($UPN + "@BraemarHospital.co.nz")' "))

   # Return data
    Return $SamAccountName, $($UPN + "@BraemarHospital.co.nz")
   
} 