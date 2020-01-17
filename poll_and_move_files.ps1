param( $sourceFileList = "",
       $newDestination = ""
)
$lineAmount = (Get-Content $sourceFileList).Count - 1
$arrayFromFile = Get-Content $sourceFileList | Select -Skip 1
[array]$missingFiles;
$scriptName = ([System.IO.Path]::GetFileNameWithoutExtension($sourceFileList))

$Currentdate = Get-Date -Format('ddMMyyyyHHmm')
$LogFolderPath = (Get-Content $sourceFileList | Select-Object -First 1)
$LogFile = $LogFolderPath + $scriptName + "_" + $Currentdate + ".log"
echo $lineAmount
function pollFiles{
    [int]$testnum = 0;

    for($i = 0; $i -lt $lineAmount; $i++){
           
           $result = Test-Path $arrayFromFile[$i]
           
           if($result -eq $True)
           {
                Write-Output $i
                Write-Output $arrayFromFile[$i] " exists"
                $testnum++
           } 
           else {
                [array]$missingFiles += $arrayFromFile[$i]
                Write-Output "Missing " $arrayFromFile[$i]
           }
    }
    if ($testnum -eq $lineAmount){
        moveFiles;
    }
    else{logErrors;}
}

function moveFiles{
    for($j = 0; $j -lt $lineAmount; $j++){
        Move-Item -Path $arrayFromFile[$j] -Destination $newDestination
    }
}

function logErrors{
    echo $LogFile
    Write-Output "Missing: "  $missingFiles "´n" $Error > $LogFile
    throw "File Missing";
}

function main{
pollFiles;
}
main;
