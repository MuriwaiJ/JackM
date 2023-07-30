<#
.SYNOPSIS
   Get OU location in AD
   Uses switch statement to get OU location


.EXAMPLE
  Set-OUOLocation "Clinical Staff - Anaesthetic
   
.NOTES
   Author: jackm@braemarhospital.co.nz
#>

Function Set-OUClinicalLocation {

    # Parameters
    Param(
    $GrpStaffLoc
)

    #Define location
    switch ($GrpStaffLoc) {
        "1" {
        $OULocation = "OU=Technician,OU=Anaesthetic,OU=Clinical Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_AnaesTech_Temp"
        $SetDept = "Anaesthetic"
        $JobTitle = "Anaesthetic Technician"
        }

        "2" {
        $OULocation = "OU=Trainee,OU=Anaesthetic,OU=Clinical Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_AnaesTrain_Temp"
        $SetDept = "Anaesthetic"
        $JobTitle = "Anaesthetic Technician Trainee"
        }
        
        "3" {
        $OULocation = "OU=Technician,OU=Anaesthetic,OU=Clinical Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_AnaesTechSup_Temp"
        $SetDept = "Anaesthetic"
        $JobTitle = "Anaesthetic Technician Supervisor"
        }   
                
        "4" {
        $OULocation = "OU=CSSD Endoscopy Coordinator,OU=CSSD,OU=Clinical Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_ENDOCoord_Temp"
        $SetDept = "CSSD"
        $JobTitle = "CSSD Endoscopy Coordinator"
        }   

        "5" {
        $OULocation = "OU=Cssd Supervisor,OU=CSSD,OU=Clinical Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_EndoSuperv_Temp"
        $SetDept = "CSSD"
        $JobTitle = "CSSD Supervisor"
        }

        "6" {
        $OULocation = "OU=CSSD Technician,OU=CSSD,OU=Clinical Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_CSSDTech_Temp"
        $SetDept = "CSSD"
        $JobTitle = "CSSD Technician"     
        }

        "7" {
        $OULocation = "OU=CSSD Assistant,OU=CSSD,OU=Clinical Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_CSSDAsst_Temp"
        $SetDept = "CSSD"
        $JobTitle = "CSSD Assistant" 
        }
        
        "8" {
        $OULocation = "OU=CSSD Sterilisation Technician,OU=CSSD,OU=Clinical Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_CSSDSterTech_Temp"
        $SetDept = "CSSD"
        $JobTitle = "Sterilization Technician" 
        }

        "9" {
        $OULocation = "OU=CSSD Loans Coordinator,OU=CSSD,OU=Clinical Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_CSSDLoansCo_Temp"
        $SetDept = "CSSD"
        $JobTitle = "CSSD Loans Co-ordinator" 
        }
        

        "10" { 
        $OULocation ="OU=Day Stay,OU=Clinical Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_DayStay_RN_Temp"
        $SetDept = "Day Stay"
        $JobTitle = "Registered Nurse"
        }

        "11" {
        $OULocation = "OU=Day Stay,OU=Clinical Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_DStayChgNurse_Temp"
        $SetDept = "Day Stay"
        $JobTitle = "Day Stay Charge Nurse"
        }

        "12" {
        $OULocation = "OU=PACU,OU=Clinical Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_PacuRN_Temp"
        $SetDept = "PACU"
        $JobTitle = "Registered Nurse"
        }

        "13" {
        $OULocation = "OU=PACU,OU=Clinical Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_PacuChgNurse_Temp"
        $SetDept = "PACU"
        $JobTitle = "PACU Charge Nurse"
        }

        "14" {
        $OULocation = "OU=Pre-Admission,OU=Clinical Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_PreAdmAdmin_Temp"
        $SetDept = "Pre-Admission"
        $JobTitle = "Pre-Admission Administrator"
        }

        "15" {
        $OULocation = "OU=Pre-Admission,OU=Clinical Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_PreAdmSrvLead_Temp"
        $SetDept = "Pre-Admission"
        $JobTitle = "Pre-Admission Service Lead"
        }

        "16" {
        $OULocation = "OU=Pre-Admission,OU=Clinical Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_PreAdmRN_Temp"
        $SetDept = "Pre-Admission"
        $JobTitle = "Pre-admission Registered Nurse"
        }

        "17" {
        $OULocation = "OU=SCU Registered Nurse,OU=SCU,OU=Clinical Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_SCU_RN_Temp"
        $SetDept = "SCU"
        $JobTitle = "SCU Registered Nurse"
        }

        "18" {
        $OULocation = "OU=SCU Lead Clinician,OU=SCU,OU=Clinical Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_SCULeadClin_Temp"
        $SetDept = "SCU"
        $JobTitle = "SCU Lead Clinician "
        }

        "19" {
        $OULocation = "OU=SCU Cardiac Nurse Resource,OU=SCU,OU=Clinical Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_Card_ResNurse_Temp"
        $SetDept = "SCU"
        $JobTitle = "SCU Cardiac Resource Nurse"
        }

        "20" {
        $OULocation = "OU=SCU Charge Nurse,OU=SCU,OU=Clinical Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_ChgNurse_Temp"
        $SetDept = "SCU"
        $JobTitle = "SCU Charge Nurse"
        }

        "21" {
        $OULocation = "OU=Exact Dental Resource Nurse,OU=Theatre,OU=Clinical Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_ExactDentRes_Temp"
        $SetDept = "SCU"
        $JobTitle = "SCU Charge Nurse"
        }

        "22" {
        $OULocation = "OU=Theatre Charge Nurse,OU=Theatre,OU=Clinical Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_THChrgNurse_Temp"
        $SetDept = "Theatre"
        $JobTitle = "Theatre Charge Nurse"
        } 

        "23" {
        $OULocation = "OU=Theatre Nurse,OU=Theatre,OU=Clinical Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_ExactDentRes_Temp"
        $SetDept = "Theatre"
        $JobTitle = "Theatre Exact Dental Resource Nurse"
        }

        "24" {
        $OULocation = "OU=Theatre Nurse,OU=Theatre,OU=Clinical Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_ENTResNurse_Temp"
        $SetDept = "Theatre"
        $JobTitle = "Theatre ENT Resource Nurse"
        }
         
        "25" {
        $OULocation = "OU=Theatre Healthcare Assistant,OU=Theatre,OU=Clinical Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_ThHealthCare_Temp"
        $SetDept = "Theatre"
        $JobTitle = "Theatre Healthcare Assistant"
        } 

        "26" {
        $OULocation = "OU=Theatre Nurse,OU=Theatre,OU=Clinical Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_ThRegNurse_Temp"
        $SetDept = "Theatre"
        $JobTitle = "Theatre Registered Nurse"
        }

        "27" {
        $OULocation = "OU=Theatre Coordinator,OU=Theatre,OU=Clinical Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_ThCoord_Temp"
        $SetDept = "Theatre"
        $JobTitle = "Theatre Co-ordinator"
        }


        "28" {
        $OULocation = "OU=Theatre Charge Nurse,OU=Theatre,OU=Clinical Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_OrthoChgNurse_Temp"
        $SetDept = "Theatre"
        $JobTitle = "Orthopaedics Associate Charge Nurse"
        }

        "29" {
        $OULocation = "OU=Theatre Nurse,OU=Theatre,OU=Clinical Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_UroResNurse_Temp"
        $SetDept = "Theatre"
        $JobTitle = "Urology and Vascular Resource Nurse"
       }

        "30" {
        $OULocation = "OU=Theatre Administrator,OU=Theatre,OU=Clinical Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_TheatreAd_Temp"
        $SetDept = "Theatre"
        $JobTitle = "Theatre Administrator"
        }

         "31" {
        $OULocation = "OU=Ward Charge Nurse,OU=Ward,OU=Clinical Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_ChgNurseInpat_Temp"
        $SetDept = "Ward"
        $JobTitle = "Ward Charge Nurse Inpatient"
        }

        "32"  {
        $OULocation = "OU=Ward Charge Nurse,OU=Ward,OU=Clinical Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_WardAsChgNurse_Temp"
        $SetDept = "Ward"
        $JobTitle = "Ward Associate Charge Nurse"
        }

        "33" { 
        $OULocation = "OU=Ward Charge Nurse,OU=Ward,OU=Clinical Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_HCAInpat_Temp"
        $SetDept = "Ward"
        $JobTitle = "Ward HCA-Inpatient Nurse"
 
        }
                
        "34" {
        $OULocation = "OU=Ward Healthcare Assistant,OU=Ward,OU=Clinical Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_WardHeatlhCare_Temp"
        $SetDept = "Ward "
        $JobTitle = "Ward Health Care Assistant"
     }
     
        "35" {
        $OULocation = "OU=Ward Nurse,OU=Ward,OU=Clinical Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_WardEnrolNurse_Temp"
        $SetDept = "Ward"
        $JobTitle = "_Ward Enrolled Nurse"
        }

        "36" {
        $OULocation = "OU=Ward Nurse,OU=Ward,OU=Clinical Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_WardRegNurse_Temp"
        $SetDept = "Ward"
        $JobTitle = "Ward Registered Nurse"
        }
        
        "37" {
        $OULocation = "OU=Ward Nurse Coordinator,OU=Ward,OU=Clinical Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_NurseCoord_Temp"
        $SetDept = "Ward Co-Ordinator"
        $JobTitle = ""
        }

        "38" {
        $OULocation = "OU=Ward Patient Services Administrator,OU=Ward,OU=Clinical Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_PatServcAdmin_Temp"
        $SetDept = "Ward Patient Services Administrator"
        $JobTitle = ""
        }

        Default {throw "ERROR You did not provide a valid OU Location - Scipt is Exiting!"}       
    }
    
    Return $OULocation, $GetUserTemplate, $SetDept, $JobTitle, $SetDept

}