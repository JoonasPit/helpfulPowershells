# Before excecution navigate to folder where you are searching through

Function searchthrough 

{

        # defines the output file name. This version creates the file in same folder. Change name and path if necessary
        $outputFile = "userbasedscanthrough.log"

        # Checks if file already exists in folder and removes it
        
        if(Test-Path $outputFile){
            # User confirms deletion
            $confirmbool = Read-Host -Prompt "Poistetaanko $outputFile (Y/N): "
            while (Test-Path $outputFile){
                # Check if user wants to delete old file or rename file and make the output file have a new name
                if($confirmbool -eq  "Y" -Or $confirmbool -eq "y"){
                    Remove-Item $outputFile
                }
                # Asks for new filename
                elseif ($confirmbool -eq "N" -Or $confirmbool -eq "n") {
                    $othername = Read-Host -Prompt "Anna tiedostolle toinen nimi"
                    $outputFile = $othername
                }
                # Keeps the user in the loop so the program doesn't throw unnecessarry errors. 
                # The error message here tells the user to select either y or n
                else{
                    Write-Error "Ei kelpaa valitse joko Y tai N"
                     $confirmbool = Read-Host -Prompt "Poistetaanko $outputFile (Y/N): "
                }
        }
        }
        # What to search for, First one asks for the file name or type eg. log, .txt etc...
        $whatfiles  = Read-Host -Prompt "Mitä tiedostoa etsitään"
        # Searches for a specific word from the file
        # do-while function makes it so the user can't search for an empty "word"
        do {
        
        $keyWord = Read-Host -Prompt "Mitä sanaa etsitään tiedostoista"
            if($keyWord -eq ""){
                Write-Output "Ei voi olla tyhjä"
                }
            }while($keyword -eq "")
        
        # What name the file has. 
        Write-Output "Katso $outputFile" 
        # Write to the new file
        Foreach ($kw in $keyWord)
            {
                # Select new match 
                Get-Childitem -Filter *$whatfiles* -Recurse -Exclude *.doc* | 
                Select-String -Pattern "$kw" | 
                # What was searched, the line that was found, on which line this can be found, and path to file
                Select Path, @{n='KeyWord';e={ $kw }}, LineNumber, line | 

        # Output file alter name @ the $outputfile variable to get different files
        Out-File .\$outputfile
       } 
}
