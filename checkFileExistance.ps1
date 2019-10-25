$file1 = "\\path\to\file-txt"
$file2 = "\\path\to\file-txt"
$file3 = "\\path\to\file-txt"
$file4 = "\\path\to\file-txt"
$file5 = "\\fifth\file-txt"
[array]$missingFiles;

# Used by logging
$scriptName = Split-Path -Path $MyInvocation.MyCommand.Definition -Leaf
[int]$testNum = 0

[array]$fileArray = $file1, $file2, $file3, $file4, $file5, 
$allgood = [bool]$false
$truetest = [bool]$true
$errorcounter = 0;

function checkExist{
    echo Checking if all files exist
    for($i=0;$i -lt $fileArray.Count; $i++){
            $currentFile = $fileArray[$i]
            $result = Test-Path $fileArray[$i]
        
            if($result -eq $false){
            $missingFiles += $currentFile + "; ";
            waitSixMinutes;
            }
            else{
                echo $fileArray[$i] exists;
                $testNum++
                if ($testNum -eq $fileArray.Count){echo All files present}
                continue;
            }
        }
}

# Logging
function logErrors{
$Currentdate = Get-Date -Format('ddMMyyyyHHmm')
$LogFolderPath= "route\to\logfolder\"
$LogFile = $LogFolderPath + $scriptName + "_" + $Currentdate + ".log"
$errorMessage =  "Poll failed on " + $Currentdate + " Missing: "
echo $LogFile
New-Item -ItemType "file" -Path $LogFile -Value ($errorMessage + $missingFiles)
throw "File Missing";
}

function waitSixMinutes
{
        if($errorcounter -eq 2){
            logErrors;
            Exit;
        }
        echo File Missing
        Start-Sleep -Seconds 360
        $errorcounter = $errorcounter + 1;
        checkExist;
}

# Call main check
function main{
checkExist
Exit
}
main;
Exit
