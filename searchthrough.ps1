Function searchthrough {
        # What to search for
        $whatfiles  = Read-Host -Prompt "Mitä tiedostoa etsitään"
        $keyWord = Read-Host -Prompt "Mitä sanaa etsitään tiedostoista"
        Write-Output "Katso kansiosta scanthrough.log"
        
Foreach ($kw in $keyWord)
       {
    Get-Childitem -Filter *$whatfiles* -Recurse | 
    Select-String -Pattern "$kw" | 

    Select @{n='KeyWord';e={ $kw }

    }, line, LineNumber ,Path | Out-File .\scanthrough.log
} 
}
