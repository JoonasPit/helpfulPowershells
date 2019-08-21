Function testifdir{
 $getInVar = Get-ChildItem
 $pathtoSelf = path\to\self

 # Run through the list of items in the folder

 ForEach($getIn in $getInVar){
    $testifdir = [System.IO.DirectoryInfo]
        if($getIn -is $testifdir){
            Get-ChildItem $getIn

        }
 }
}
