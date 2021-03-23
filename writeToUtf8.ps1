## Running this twice on a already utf-8 file causes it to scramble the text
## MAKE SURE THAT THE FILE YOU ARE USING THIS ON ISN'T UTF-8 ALREADY
## Current powershell version doesn't support checking file-encoding quickly without a Byte Order Mark

param
(
$logPath,
$pathToFiles
)
$logDate = Get-Date -Format "yyyy_MM_dd_hh_mm"
$finalLogPath = $logPath + $logDate + "_utf_write_log.txt"
$Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False

function somethingWentWrong ($errormessage){
    
    $_ | Out-File $finalLogPath -Append
    $sendmailto = ""
    $sendmailfrom = ""
    $smtp = ""
    $subject = "Rewrite failure"
    $mailMessage ="An error occurred during file rewrite. Check logs `n" + $finalLogPath + "`n" + $errormessage + "`n"
    Send-MailMessage -From $sendmailfrom -To $sendmailto -SmtpServer $smtp -Subject $subject -Body $mailMessage
    Exit 1
}


try{
    
    $filesToTransfer | ForEach-Object{
        [System.IO.File]::WriteAllLines((Resolve-Path $pathTofiles*$_*),(Get-Content $pathTofiles*$_*), $Utf8NoBomEncoding)
        Write-Output "File $_ rewritten as utf-8 successfully" >> $finalLogPath
    }

}catch{
    $errormessage = $_
    Write-Output $errormessage >> $finalLogPath
    somethingWentWrong($errormessage);
} 
