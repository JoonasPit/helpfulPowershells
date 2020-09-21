Function searchfiles-for{

$whatfiles  = Read-Host -Prompt "Mitä tiedostoa etsitään"
$keyWord = Read-Host -Prompt "Mitä sanaa etsitään tiedostoista"
Write-Output "Katso kansiosta scanthrough.log"

Get-ChildItem . -Filter *$whatfiles* |
Select-String -Pattern $keyWord -AllMatches -SimpleMatch |
Foreach-Object {

$_.Line + "|" + $nametest

} |
Out-File .\scanthrough.log
}
