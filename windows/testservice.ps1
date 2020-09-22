if ( ($FiscalHost = Read-Host -Prompt "Host [localhost]") -eq "") {
    $FiscalHost = "localhost"
}

if ( ($FiscalPort = Read-Host -Prompt "Port [12345]") -eq "") {
    $FiscalPort = "12345"
}


Try {
    $tcpConnection = New-Object System.Net.Sockets.TcpClient($FiscalHost, $FiscalPort)
} Catch {
    Write-Host "Connection error: " $_.Exception.Message
    exit
}

$tcpConnection.ReceiveTimeout = 5000;

$tcpStream = $tcpConnection.GetStream()

$reader = New-Object System.IO.StreamReader($tcpStream)

$writer = New-Object System.IO.StreamWriter($tcpStream)
$writer.AutoFlush = $true


while ($tcpStream.DataAvailable) {
    $reader.ReadLine()
}
if ($tcpConnection.Connected) {
    if ( ($command = Read-Host -Prompt "Command [SEND|0x2a|T|[]]") -eq "") {
        $command = "SEND|0x2a|T|[]"
    }

    $writer.WriteLine($command)

    try {
        $response = $Reader.ReadLine()
    } catch {
        Write-Host "No response"
    }

    Write-Host "Respuesta: " $response
}

Read-Host -Prompt "Press enter to quit"
