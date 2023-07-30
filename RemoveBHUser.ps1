<#
.SYNOPSIS
   Remove user

.DESCRIPTION
   Removes user from systems.  As we do not delete, this archives and disables

.EXAMPLE
   Remove-BHUser <EmployeeID>
   Remove-BHUser 12345

   Remove-BHUser <sAMAccountName>
   Remove-BHUser JackM

.NOTES
   Author:JackM@braemarhospital.co.nz
#>

# Function Remove-WDHBUser
function Remove-BHUser {
   # Parameters
   Param(
      # Param
      [Parameter(Mandatory)]
      $Param
   )

   # Check if EmployeeID
   If ($Param -match "^\d+$") { 
      $sAMAccountName = (Get-BraemarEmployeeID $Param).SamAccountName 
      If (!($sAMAccountName)) { throw "$Param Does not exist" }
   }
   # Must of inputted sAMAccountName
   Else { $sAMAccountName = $Param }

   # Check if account exists.
   If ( !(Get-ADUser -Filter { sAMaccountname -eq $sAMAccountName }) ) {
      throw "$sAMAccountName Does not exist"
   }
   Else {
      # Disable user
      Disable-ADAccount $sAMAccountName

      # Hide user in GAL
      Set-ADUser $sAMAccountName -Replace @{msExchHideFromAddressLists=$True}

      # Remove folders
      Remove-BHUserFolders $sAMAccountName

      # Export AD Groups to $ArchivePath
      $TimeStamp = Get-Date -Format yyyyMMddThhmmss
      (Get-ADUser -Filter { sAMaccountname -eq $sAMAccountName } -Properties MemberOf).MemberOf | Sort-Object | Out-File -FilePath "$ArchivePath\$sAMAccountName\MemberOf_$TimeStamp.txt"

      # Remove AD Groups
      $ADgroups = Get-ADPrincipalGroupMembership -Identity $sAMAccountName -ResourceContextServer "braemarnz.local" | Where-Object { $_.Name -ne "Domain Users" }
      if ($ADgroups) {
         Remove-ADPrincipalGroupMembership -Identity $sAMAccountName -MemberOf $ADgroups -Confirm:$false
      }

      # Set displayname to Deleted
      $DisplayName = (Get-ADUser $sAMAccountName -Properties DisplayName).DisplayName
      Set-ADUser $sAMAccountName -DisplayName "$DisplayName (Deleted $(Get-Date -Format dd/MM/yyyy))"

   }
}