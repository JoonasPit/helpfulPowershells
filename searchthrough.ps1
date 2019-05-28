# Before excecution navigate to folder where you are searching through

Function searchthrough {

        # defines the output file name. This version creates the file in same folder. Change name and path if necessary
        $outputFile = "userbasedscanthrough.log"

        # Checks if file already exists in folder and removes it
        
        if(Test-Path $outputFile){
            # User confirms deletion
            $confirmbool = Read-Host -Prompt "Poistetaanko $outputFile (Y/N): "
            while (Test-Path $outputFile){
                if($confirmbool -eq  "Y" -Or $confirmbool -eq "y"){
                    Remove-Item $outputFile
                }
                elseif ($confirmbool -eq "N" -Or $confirmbool -eq "n") {
                    $othername = Read-Host -Prompt "Anna tiedostolle toinen nimi"
                    $outputFile = $othername
                }
                else{
                    Write-Error "Ei kelpaa"
                     $confirmbool = Read-Host -Prompt "Poistetaanko $outputFile (Y/N): "
                }
        }
        }
        # What to search for, First one asks for the file name or type eg. log, .txt etc...
        $whatfiles  = Read-Host -Prompt "Mitä tiedostoa etsitään"
        # Searches for a specific word from the file
        do {
        
        $keyWord = Read-Host -Prompt "Mitä sanaa etsitään tiedostoista"
            if($keyWord -eq ""){
                Write-Output "Ei voi olla tyhjä"
                }
            }while($keyword -eq "")
        
        
       Write-Output "Katso $outputFile" 
        
        Foreach ($kw in $keyWord)
            {
                # Select new match 
                Get-Childitem -Filter *$whatfiles* -Recurse | 
                Select-String -Pattern "$kw" | 
                # What was searched, the line that was found, on which line this can be found, and path to file
                Select @{n='KeyWord';e={ $kw }}, line, LineNumber , Path | 

    # Output file alter name @ the $outputfile variable to get different files
    Out-File .\$outputfile
} 
}
