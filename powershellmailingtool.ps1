#Zipping failed
$sendmailto = "User <user@mail.com>"
$sendmailfrom = "User2 <user2@mail.com>"
$smtp = "smtp.yourdomain@mail.com"  
[string]$subject = "Subject of e-mail"
[string]$failmailmessage = "Message to send"

function zipFailmail(){
    Send-MailMessage -From $sendmailfrom -To $sendmailto -SmtpServer $smtp -Subject $subject -Body $failmailmessage
}

function main(){
    zipFailmail;
}

main;
