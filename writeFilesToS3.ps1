param
(
$logPath,
$pathToFiles,
$awsKeyPath,
$environment
)
Import-Module AWSPowerShell;
Write-Output $pathToFiles
$bucketName="your-file-bucket-here" ## change to external, if needed
$timeTest = Get-Date -Format("HH:mm")
$keyDate = Get-Date -Format 'yyyy\/MM\/dd'
if($timetest -lt "18:00"){
    $keyDate = (Get-Date).AddDays(-1)
    $keyDate = $keyDate.ToString('yyyy\/MM\/dd')
}    
$logDate = Get-Date -Format "yyyy_MM_dd_hh_mm"
$finalLogPath = $logPath + $logDate + "_log.txt"
$ServerSideEncryption="aws:kms"

function somethingWentWrong($errormessage){
    $errormessage | Out-File $finalLogPath -Append
    $sendmailto = ""
    $sendmailfrom = ""
    $smtp = ""
    $subject = $awsKeyPath + " transfer failure"
    $mailMessage ="An error occurred during file transfer. Check logs `n" + $finalLogPath + "`n" + $errormessage + "`n"
    Send-MailMessage -From $sendmailfrom -To $sendmailto -SmtpServer $smtp -Subject $subject -Body $mailMessage
    Exit 1
}

try{
    Set-DefaultAWSRegion -Region your_region
    Set-AWSCredentials -ProfileName YourProfileName -ProfileLocation Your/ProfileLocation
}catch{
    $errormessage = $_
    somethingWentWrong($errormessage);
}
if ($environment -eq "test")
{
    $Creds = (Use-STSRole -RoleArn "YourArn" -RoleSessionName "SessionName").Credentials
    $ServerSideEncryptionKeyManagementServiceKeyId="A-Management_Key"
}

else{
    $Creds = (Use-STSRole -RoleArn "Role" -RoleSessionName "Session").Credentials
    $ServerSideEncryptionKeyManagementServiceKeyId="A-Management_Key"
}


try{
    Write-Output $awsKeyPath/$keyDate/$_ >> $finalLogPath
    (Get-Childitem -Path $pathTofiles) | % {Write-S3Object -EndpointUrl https://s3:endpoint_url -BucketName $bucketName -File $_.FullName -Key $awsKeyPath/$keyDate/$_ -Verbose -Credential $Creds -ServerSideEncryption $ServerSideEncryption -ServerSideEncryptionKeyManagementServiceKeyId $ServerSideEncryptionKeyManagementServiceKeyId -CannedACLName bucket-owner-full-control -ContentType "text/plain; charset=utf-8"}
    Write-Output "Write Finished Successfully" >> $finalLogPath
}
catch{
    $errormessage = $_
    somethingWentWrong($errormessage);
}

