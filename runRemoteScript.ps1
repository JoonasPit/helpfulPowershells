 param(
 [string]
 $pathToFile = "ScriptOnOtherComputerToRun"
 )

$pwd = ConvertTo-SecureString "UserPassword" -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential("USER/DOMAIN",$pwd)

$cmptrName = "NameOfRemote"
$session = New-PSSession -computerName $cmptrName -Credential $cred

Invoke-Command -session $session -ComputerName $cmptrName -ScriptBlock {cmd /c $Using:pathToFile -wait} 
