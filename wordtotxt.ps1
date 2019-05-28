# Run through all doc-type files in a folder and convert them in to .txt-files

function wordConversion{

# Specify location
$location = Get-Location
# Get all doc-files
$files = Get-ChildItem -Filter *.doc*

# Create word-object

$word = New-Object -ComObject 'Word.Application'

# These lines | Original script couldn't figure out where to look for word interops
# By adding following lines to the script it found the wd Format-options that were needed
# The error may have been caused by me creating the word-object after parseing through the wd-library
$wdTypes = Add-Type -AssemblyName 'Microsoft.Office.Interop.Word' -Passthru
$wdSaveFormat = $wdTypes | Where {$_.Name -eq "wdSaveFormat"}

# Select wdFormat text from word object
$saveformat = [Enum]::Parse([Microsoft.Office.Interop.Word.WdSaveFormat], "wdFormatText")
$fileEnding = ".txt"



# Word visible during conversion
$word.visible = $false

# Run through files open close and copy from .doc to .txt
foreach($file in $files){

    Write-Output "Processing $($file.FullName)"
    $doc = $word.Documents.Open($file.FullName)
    $fileName = $file.BaseName + $fileEnding
    # Location is current folder. To change save location create save location variable and 
    # replace $location to that. Saveformat parses the doc-file to txt
    $doc.SaveAs("$location\$filename", [ref]$saveformat)

    Write-Output "Saved as" $fileName
    #close the opened document
    $doc.Close()
}
# Exit Word
$word.Quit()
}
