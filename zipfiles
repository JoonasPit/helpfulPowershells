$zipdate = Get-Date -Format('ddMMyyyyHHmm')
$sourcefiles = "PAth\To\Files*"
$newdir = "create\tempdir\to\zip"

$destinationfolder = "\zip\folder\location\and_folder_name_with_zipdate${zipdate}.zip"
$compressionLevel = [System.IO.Compression.CompressionLevel]::Optimal

if((Test-Path $newdir) -eq "True"){
    Remove-Item -Recurse -Path $newdir
}else{
    New-Item -Path $newdir -ItemType "directory" #-Name "tempdir"
}

Move-Item -Path $sourcefiles -Destination $newdir

function ZipFiles( $zipfilename, $sourcedir )
{
    [Reflection.Assembly]::LoadWithPartialName( "System.IO.Compression.FileSystem" )
    $compressionLevel = [System.IO.Compression.CompressionLevel]::Optimal
    [System.IO.Compression.ZipFile]::CreateFromDirectory($newdir, $destinationfolder, $compressionLevel, $false)
    
}

ZipFiles
Remove-Item -Recurse -Path $newdir
