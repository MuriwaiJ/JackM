<#
.SYNOPSIS
   Get OU location in AD
   Uses switch statement to get OU location


.EXAMPLE
  Set-OUOLocation "Clinical Staff - Anaesthetic
   
.NOTES
   Author: jackm@braemarhospital.co.nz
#>

Function Set-OUVendorLocation {

    # Parameters
    Param(
    $GrpStaffLoc
)

    #Define location
    switch ($GrpStaffLoc) {
        "1" {
        $OULocation = "OU=Arthrex,OU=Contractors,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_Anthrex_Temp"
        $SetDept = "Vendor"
        }

        "2" {
        $OULocation = "OU=Dedalus,OU=Contractors,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_Dedalus_Template"
        $SetDept = "Vendor"
        }

        "3" {
        $OULocation = "OU=Olympus,OU=Contractors,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_Olympus_Temp"
        $SetDept = "Vendor"
        }

        Default {
        $OULocation = "OU=Contractors,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_Vendor_DEF_Temp"
        $SetDept = "Vendor"
        $JobTitle = " "
        }  
        
    }
    
    Return $OULocation, $GetUserTemplate, $SetDept

}