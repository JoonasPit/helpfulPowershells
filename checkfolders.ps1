Function testifdir{
 $getInVar = Get-ChildItem
 $pathtoSelf = C:\Users\B713449\Documents\ps_scripts\errorlogtest.ps1

 # Run through the list of items in the folder

 ForEach($getIn in $getInVar){
    $testifdir = [System.IO.DirectoryInfo]
        if($getIn -is $testifdir){
            Get-ChildItem $getIn

        }
 }
}
