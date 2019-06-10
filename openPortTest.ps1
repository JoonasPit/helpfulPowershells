$host = Read-Host -Prompt "anna hosti"
$port = Read-Host -Prompt "anna portti"
(new-object Net.Sockets.TcpClient).Connect($host, $port)
