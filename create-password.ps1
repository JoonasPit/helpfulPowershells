Function create-password{
    $password = ""

    For($i = 33; $i -le 126; $i++){
    
    $ascii +=,[char][byte]$i
    }

    1..30 | ForEach{$password += $ascii | get-random}
    return $password
    }
