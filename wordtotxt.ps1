function wordConversion{

#Get all doc-files
$location = Get-Location
$files = Get-ChildItem -Filter *.doc*
# FIGURE OUT
$wdTypes = Add-Type -AssemblyName 'Microsoft.Office.Interop.Word' -Passthru
$wdSaveFormat = $wdTypes | Where {$_.Name -eq "wdSaveFormat"}
$saveformat = [Enum]::Parse([Microsoft.Office.Interop.Word.WdSaveFormat], "wdFormatText")
$fileEnding = ".txt"

# Create word-object

$word = New-Object -ComObject 'Word.Application'
# Word visible during conversion
$word.visible = $false

# Run through files open close and copy
foreach($file in $files){

    Write-Output "Processing $($file.FullName)"
    $doc = $word.Documents.Open($file.FullName)
    $fileName = $file.BaseName + $fileEnding
    $doc.SaveAs("$location\$filename", [ref]$saveformat)
    Write-Output $fileName
    $doc.Close()
}

$word.Quit()
}
