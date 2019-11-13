$dateTime = get-date;
$checkAgainst = "Monday"
# Seconds
$sleepAmount = 3600

function checkdate(){
    if($dateTime.DayOfWeek -eq $checkAgainst)
    {
        echo Today is $dateTime.DayOfWeek
        echo Waiting one hour
        Start-Sleep -Seconds $sleepAmount
        Exit
    }

    else
    {
        echo Today is $dateTime.DayOfWeek
        echo Exiting to workflow
        Exit
    }
}
function main(){
checkdate;
Exit;
}
#call main
main;
