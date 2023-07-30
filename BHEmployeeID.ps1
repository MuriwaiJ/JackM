<#.SYNOPSIS
   Get Employee ID

.DESCRIPTION
   Query if user acccount exists based on Employee ID

.EXAMPLE
   Get-BraemarEmployeeID 01234
   
.NOTES
   Author: jackm@braemarhospital.co.nz
#>

Function Get-BraemarEmployeeID{

    # Parameters
    Param(
    [Parameter(Mandatory)]
    [ValidatePattern('^\d+$')]
    $EmployeeID
)

    # Query
    if($EmployeeData = Get-ADUser -Filter "EmployeeID -eq $employeeid"){
    $EmployeData  |  Select-Object EmployeeID, SamAccountName, UserPrincipalName 
    Write-Host "EmployeeID: $EmployeeID | SamAccountName: $($EmployeeData.SamAccountName) | UPN: $($EmployeeData.UserPrincipalName) already exists" -ForegroundColor Red
    Write-Host "Please check Active Directory for an existing account already using EmployeeID $EmployeeID" -ForegroundColor Red
    break;
    
    }
    Else{
    Write-host "EmployeeID: $EmployeeID does not exist.  Script will now check for available username "

    # call new=braemarUser function and pass employee id
    Return $EmployeeID
    }

}

