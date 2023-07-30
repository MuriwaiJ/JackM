<#
.SYNOPSIS
    Remove user folder

.DESCRIPTION
    Remove user folder
    Related: New-BHUserFolder

.EXAMPLE
   Remove-BHUserFolderss <Folder>
   Remove-BHUserFolders JackM

.NOTES
   Author: JackM@braemarhospital.co.nz
#>

# Function Remove-WDHBUserFolders
function Remove-BHUserFolders {   
    # Parameters
    Param(
        # Folder
        [Parameter(Mandatory)]
        $Folder
    )

    # Variables
    $RootSourcePaths = @(
       
        [pscustomobject]@{Folder = "Home"; Path = "FileSystem::\\braemarnz.local\dfs\users" }
        [pscustomobject]@{Folder = "Profile"; Path = "FileSystem::\\braemarnz.local\dfs\XPProfiles" }

        )
    $TimeStamp = Get-Date -Format yyyyMMddThhmmss

    # Check $ArchivePath
    If ((Test-Path $ArchivePath) -eq $false) { throw "$ArchivePath : Does not exist OR is inaccessible" }
    
    # Create destination
    If ((Test-Path $ArchivePath\$Folder) -eq $false) {
        New-Item -Path $ArchivePath\$Folder -ItemType directory | Out-Null
    }

    # Check $RootSourcePaths
    ForEach ($RootSourcePath in $RootSourcePaths) {
        $SourcePath = "$($RootSourcePath.Path)\$Folder"
        #Write-Host "Checking: $SourcePath" -ForegroundColor Green
        If ((Test-Path $SourcePath) -eq $True) { 
            Write-Host "Located: $SourcePath" -ForegroundColor Cyan
            
            # Fix ACLs
            TakeOwn /R /D Y /F $SourcePath.Substring(12) | Out-Null
            icacls $SourcePath.Substring(12) /reset /T /Q 

            # Check $SourcePath contains files
            If (Test-Path $SourcePath\*) {
                # Create destination subfolder
                $DestPath = "$ArchivePath\$Folder\$($RootSourcePath.Folder)"
                If ((Test-Path $DestPath) -ne $false) {
                    $DestPath = "$ArchivePath\$Folder\$($RootSourcePath.Folder)_$TimeStamp"
                }
                New-Item -Path $DestPath -ItemType directory | Out-Null

                # Move
                #Move-Item -Path $Source\* -Destination $Destination -Force                         # Windows Server 2012 R2 does not support paths longer than 260 characters
                robocopy $SourcePath.Substring(12) $DestPath.Substring(12) /E /MOVE /NJH /NFL /NDL   # Workaround for long paths limitation above
            
            }
            Else {
                Write-Host "$SourcePath - Empty" -ForegroundColor Cyan
                # Delete source
                Remove-Item $SourcePath  -Recurse -Force
            }
        } 
    } 
}
