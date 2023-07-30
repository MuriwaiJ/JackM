Set-Location "C:\users\JackM\Braemar Hospital\IT - Documents\General\Scripts\NewUserAccounts"

Function Get-ScriptDirectory {
if($psise){
Split-Path $psise.CurrentFile.FullPath
}
else {
$Global:PSScriptRoot
}
}

# Uses Get-ScriptDirectory function to get all the folders and adds a dot 
$(Get-ChildItem $(Get-ScriptDirectory) -Recurse -Filter "*BH*").FullName | ForEach-Object { . $_}  #% { . $_}






