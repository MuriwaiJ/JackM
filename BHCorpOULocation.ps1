<#
.SYNOPSIS
   Get OU location in AD
   Uses switch statement to get OU location


.EXAMPLE
  Set-OUOLocation "Clinical Staff - Anaesthetic
   
.NOTES
   Author: jackm@braemarhospital.co.nz
#>

Function Set-OUCorpLocation {

    # Parameters
    Param(
    $GrpStaffLoc
)

    #Define location
    switch ($GrpStaffLoc) {
        "1" {
        $OULocation = "OU=Medical Records,OU=Administration,OU=Corporate Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_MedicalRecords_Temp"
        $SetDept = "Medical Records"
        $JobTitle = "Medical Records Administrator"
        }

        "2" {
        $OULocation = "OU=Admistration Reception,OU=Administration,OU=Corporate Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_AdmnRecep_Temp"
        $SetDept = "Administration"
        $JobTitle = "administrator Receptionist"
        }
                
        "3" {
        $OULocation = "OU=Medical Records Manager,OU=Administration,OU=Corporate Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_MedRecMngr_Temp"
        $SetDept = "Administration"
        $JobTitle = "Medical Records Manager"
        }   

        "4" {
        $OULocation = "OU=General Assistant,OU=Administration,OU=Corporate Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_Gen_Asst_Temp"
        $SetDept = "Administration"
        $JobTitle = "General Assistant"
        }

        "5" {
        $OULocation = "OU=Education Nurse Advisor,OU=Education,OU=Corporate Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_Edu_Nurse_Adv_Temp"
        $SetDept = "Education"
        $JobTitle = "Education Nurse Advisor"        
        }

        "6" {
        $OULocation = "OU=Education Nurse Manager,OU=Education,OU=Corporate Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_Edu_Nurse_Mgr_Temp"
        $SetDept = "Education"
         $JobTitle = "Education Nurse Manager"
        }
        
        "7" {
        $OULocation = "OU=Facilities,OU=Corporate Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_Mnt_Mgr_Temp"
        $SetDept = "Facilities"
        $JobTitle = "Facilities Maintenance Manager"
        }

        "8" {
        $OULocation = "OU=Facilities,OU=Corporate Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_Mnt_Staff_Temp"
        $SetDept = "Facilities"
        $JobTitle = "Facilities Maintenance Staff"
        }

        "9" {
        $OULocation = "OU=Finance,OU=Corporate Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_Acct_Admin_Temp"
        $SetDept = "Finance"
        $JobTitle = "Finance Accounts Administrator – ACC Elective Surgery"

        }

        "10" {
        $OULocation = "OU=Finance,OU=Corporate Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_Acct_Pay_lead_Temp"
        $SetDept = "Finance"
        $JobTitle = "Finance Accounts Payable Lead Temp"
        }

        "11" {
        $OULocation = "OU=Finance,OU=Corporate Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_Asst_Acct_Temp"
        $SetDept = "Finance"
        $JobTitle = "Finance Assistant Accountant"
        }

        "12" {
        $OULocation = "OU=Finance,OU=Corporate Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_Finan_Asst_Temp"
        $SetDept = "Finance"
        $JobTitle = "Assistant Acccountant"
        }

        "13" {
        $OULocation = "OU=Finance,OU=Corporate Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_Finan_Cons_Temp"
        $SetDept = "Finance"
        $JobTitle = "Finance Consultant"
        }

        "14" {
        $OULocation = "OU=Finance,OU=Corporate Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_Finance_Mgr_Temp"
        $SetDept = "Finance"
        $JobTitle = "Finance Manager"
        }

        "15" {
        $OULocation = "OU=Finance,OU=Corporate Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_Fin_T_Mem_TMP"
        $SetDept = "Finance"
        $JobTitle = "Finance Team Leader"
        }

        "16" {
        $OULocation = "OU=Finance,OU=Corporate Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_Inv_admin_Temp"
        $SetDept = "Finance"
        $JobTitle = "Finance Invoice Administrator"
        }

        "17" {
        $OULocation = "OU=Finance,OU=Corporate Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_Invoice_Lead_Temp"
        $SetDept = "Finance"
        $JobTitle = "Finance Invoicing Lead"
        }

        "18" {
        $OULocation = "OU=Chef,OU=Hospitality,OU=Corporate Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_Chef_Temp"
        $SetDept = "Hospitality"
        $JobTitle = "Chef"
        }

        "19" {
        $OULocation = "OU=Executive Chef,OU=Hospitality,OU=Corporate Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_Exec_Chef_Temp"
        $SetDept = "Hospitality"
         $JobTitle = "Hospitality Executive Chef"
        }

        "20" {
        $OULocation = "OU=Hospital Services Manager,OU=Hospitality,OU=Corporate Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_Hosp_Srvcs_Mgr_Temp"
        $SetDept = "Hospitality"
        $JobTitle = "Hospitality Service Manager"
        } 

        "21" {
        $OULocation = "OU=HouseKeeper Teamleader,OU=Hospitality,OU=Corporate Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_Housekeeper_TL_Temp"
        $SetDept = "Hospitality"
        $JobTitle = "Hospitality Housekeeper Teamleader"
        }

        "22" {
        $OULocation = "OU=Kitchen and Housekeep Staff,OU=Hospitality,OU=Corporate Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_kitchen_HKeep_Temp"
        $SetDept = "Hospitality"
        $JobTitle = "Hospitality Kitchen and Housekeeping Assistant"
        }
         
        "23" {
        $OULocation = "OU=Laundry Supervisor,OU=Hospitality,OU=Corporate Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_Laundry_Super_Temp"
        $SetDept = "Hospitality"
        $JobTitle = "Hospitality Laundry Supervisor"
        } 

        "24" {
        $OULocation = "OU=HR Advisor,OU=Corporate Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_HR_Adv_Temp"
        $SetDept = "HR Advisor"
        $JobTitle = "HR aAdvisor"
        }

        "25" {
        $OULocation = "OU=IT,OU=Corporate Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_IT_Staff_Temp"
        $SetDept = "IT"
        $JobTitle = "IT Staff"
        }

        "26" {
        $OULocation = "OU=Office Manager,OU=Corporate Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_Office_Mgr_Temp"
        $SetDept = "Office Manager"
        $JobTitle = "Office Manager"
        }

        "27" {
        $OULocation = "OU=Patient Services Manager,OU=Corporate Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_Patnt_Svc_Mgr_Temp"
        $SetDept = "Patient Services Manager"
        $JobTitle = "Patient Services Manger"
        }

        "28" {
        $OULocation = "OU=Payroll,OU=Corporate Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_Payroll_Mgr_Temp"
        $SetDept = "Payroll"
        $JobTitle = "Payroll Manager"
        }

        "29" {
        $OULocation = "OU=Payroll,OU=Corporate Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_PayrollAnalyst_Temp"
        $SetDept = "Payroll"
        $JobTitle = "Payroll Analyst"
        }

        "30" {
        $OULocation = "OU=Quality and Risk,OU=Corporate Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_InfPrevCntrl_Temp"
        $SetDept = "Quality and Risk"
        $JobTitle = "Infection and Prevention Control"
        }

        "31" {
        $OULocation = "OU=Quality and Risk,OU=Corporate Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_QR_Mgr_Temp"
        $SetDept = "Quality and Risk"
        $JobTitle = "QR Manager"
        }
        

        "32" { 
        $OULocation = "OU=Safety & Wellness,OU=Corporate Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_SafetyWellAdv_Temp"
        $SetDept = "Safety and Wellness"
        $JobTitle = "Safety and Wellnes Advisor"
        }
                
        "33" {
        $OULocation = "OU=Stores,OU=Corporate Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_Pur_Sup_off_Temp"
        $SetDept = "Stores"
        $JobTitle = "Stores Purchase and Supplies Officer"
        }

        "34" {
        $OULocation = "OU=Stores,OU=Corporate Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_Stores_Mgr_Temp"
        $SetDept = "Stores"
        $JobTitle = "Stores Manager"
        }

        "35" {
        $OULocation = "OU=Senior Management,OU=Corporate Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_CEO_Temp"
        $SetDept = "Senior Management"
        $JobTitle = "Chief Executive Officer"
        }

        "36" {
        $OULocation = "OU=Senior Management,OU=Corporate Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_CFO_Temp"
        $SetDept = "Senior Management"
        $JobTitle = "Chief Financial Officer"
        }

        "37" {
        $OULocation = "OU=Senior Management,OU=Corporate Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_GM_Clin_Srvc_Temp"
        $SetDept = "Senior Management"
        $JobTitle = "General Manager Clinical Services"
        }

        "38" {
        $OULocation = "OU=Senior Management,OU=Corporate Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_GM_Comm_Srv_Temp"
        $SetDept = "Senior Management"
        $JobTitle = "General Manager Commercial Services"
        }

        "39" {
        $OULocation = "OU=Senior Management,OU=Corporate Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_GM_PS_Temp"
        $SetDept = "Senior Management"
        $JobTitle = "General Manager People and Services"
        }

        "40" {
        $OULocation = "OU=Senior Management,OU=Corporate Staff,OU=Braemar Staff,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_Exec_Asst_Temp"
        $SetDept = "Senior Management"
        $JobTitle = "Executive Assistant"
        }

       <# "41" {
        $OULocation = "OU=Contractors,OU=Users,OU=Braemar,DC=BRAEMARNZ,DC=local"
        $GetUserTemplate = "_Vendor_Temp"
        $SetDept = "Vendor"
        $JobTitle = " "
        }
        #>

        Default {throw "ERROR You did not provide a valid number - Scipt is Exiting and will need to be rerun!" 
        break; 
        }
    }
    
    Return $OULocation, $GetUserTemplate, $SetDept, $JobTitle, $SetDept

}