![logo](/Images/logo.png)
# 💙🤍Lab5 Windows Server Core🤍💙

## 📘Table of Contents

1. [📘Table of Contents](#📘table-of-contents)
2. [🖖Introduction](#🖖introduction)
3. [📝Assignment](#📝assignment)
4. [✨Steps](#✨steps)
    1. [👉 Step 0: Install and configure new VM](#👉step-0-install-and-configure-new-vm)
    2. [👉 Step 1: Basic configuration with sconfig](#👉step-1-basic-configuration-with-sconfig)
    3. [👉 Step 2: Apache installation](#👉step-2-apache-installation)
    4. [👉 Step 3: HTTPS](#👉step-3-https)
    5. [👉 Step 4: PowerShell remoting](#👉step-4-powershell-remoting)
5. [📦Extra](#📦extra)
6. [🔗Links](#🔗links)

---

## 🖖Introduction

In this lab, we will be installing a Windows Server Core and configure it to host an Apache server. We will also be configuring HTTPS and PowerShell remoting.

### 📝Assignment 
> NOTE This is in Dutch

 
- DOEL: Windows server Core
- REF: 
    - https://docs.microsoft.com/en-us/windows-server/get-started/getting-started-with-server-core
    - https://www.sslshopper.com/apache-server-ssl-installation-instructions.html 
    - https://www.sslshopper.com/article-how-to-create-and-install-an-apache-self-signed-certificate.html 


0. INSTALLATIE
    - Download `Windows Server 2022 64-bit van Microsoft DreamSpark`.
    - We installeren nu de Core versie (zonder desktop experience!).
    - Geef je virtuele machine in VMware 2 netwerkkaarten: 1 `NAT` + 1 `host-only`.

1. BASISCONFIGURATIE met sconfig
    - Start de Windows Core server en log in.
    - Start sconfig (bij installatie in een andere taal dan Engels, moet je mogelijks het ganse pad ingeven->google).
    - Geef de server een leesbare computernaam: `WINCORE`.
    - Zet Windows updates op handmatig.
    - Geef de `host-only` adapter een vast IP adreskies het adres rekening houdend met de `DHCP` range van het `host-only` netwerk in VMware.
    - Reboot de server.

2. APACHE INSTALLATIE
    - Maak in VMware een `Gedeelde Map` aan zodat je files kan uitwisselen tussen host en guest.
    - Zet je Apache Zip file (zie `Apache oefening`) op je Windows Server Core.
    - Doe een unzip naar `C:\Apache24` door gebruik te maken van PowerShell.
    - Download en installeer de Visual `C++` Redistributable Package (zie readme van Apache).
    - Open firewall poort: `netsh firewall set portopening TCP 80 Apache Web Server`.
    - Zorg er voor dat de configuratie van de `Apache oefening` op jou Server Core komt.
    - Test of alles werkt.

3. HTTPS
    - Maak self-signed certificaten aan (zie REF 3) en plaats deze in de `conf` directory van Apache.
    - Pas je configuratie file aan zodat je ook via https naar je `kdg` website kan surfen.

4. POWERSHELL remoting
    - Run `Enable-PSRemoting` op je host en guest machine (ev. met optie `-SkipNetworkProfileCheck`).
    - Op Host: `Set-Item -Path wsman:\localhost\client\Trustedhosts -Value 'HierIPvanGuest'`.
    - Start sessie: `Enter-PSSession -ComputerName HierIPvanGuest -Credential WINCORE\administrator`.
    - Stop sessie: `Exit-PSSession`.
    - Je kan dit ook vanuit `Powershell ISE` -> `File` -> `New Remote Powershell Tab`.
    - En commando remote uitvoeren:
        - `Invoke-Command -ComputerName HierIPvanGuest -Credential WINCORE\administrator -ScriptBlock {Get-Disk}`.

## ✨Steps

### 👉Step 0: Install and configure new VM

- Download `Windows Server 2022 Datacenter (updated July 2023)`.
    - From [Microsoft Portal Azure](https://portal.azure.com/).
- Install the VM with the following settings:
    - 2 Network Adapters: 1 `NAT` + 1 `host-only`.
    - 8GB of RAM.
    - 2 Cores.
    - 60GB of storage.
> **Note:** When prompted to select the core version. This is without any desktop environment.

> This should be the result.

![x](/Images/Lab5-WindowsServerCore-1.png)

### 👉Step 1: Basic configuration with sconfig

- Start the Windows Core server and log in.
- Give the server a readable computer name: `WINCORE`.
    - Press `2` and then `Enter`.
    - Enter the new computer name and press `Enter`.
    - Press `Y` and then `Enter` to restart the server.
- Set Windows updates to manual.
    - Press `5` and then `Enter`.
    - Press `3` and then `Enter`.
    - Press `Enter` to confirm.
- Give the `host-only` adapter a fixed IP address. (`This part may be a little different`)
    - Press `8` and then `Enter`.
    - Press `2` and then `Enter`. (This is the `host-only` adapter)
    - Press `1` and then `Enter`.
    - Press `S` and then `Enter`.
    - Enter the IP address and press `Enter`. (I used `192.168.19.9`)
    - Press `Enter` to confirm te default subnet mask `255.255.255.0`.
    - Enter the default gateway and press `Enter`. (I used `192.168.19.10` but this is optional)
    - Press `Enter` to confirm.
- Reboot the server.
    - Press `13` and then `Enter`.
    - Press `Y` and then `Enter`.

> This should be the result.

![x](/Images/Lab5-WindowsServerCore-2.png)

### 👉Step 2: Apache installation

- Make a `Shared Folder` in VMware so you can exchange files between host and guest.
    - Go to `VM` -> `Settings` -> `Options` -> `Shared Folders`.
    - Click on `Always enabled`.
    - Click on `Add` and select the folder you want to share.
    - Click on `Next` and then `Finish`.
    - Click on `Map as a network drive in Windows guests`.
    - Click on `OK`.
- Mount the network drive to your system.
    - Open PowerShell pressing `15` and then `Enter`.
    - Run the following command to mount the network drive.
    ```powershell
    New-PSDrive -Name VMwareHost -PSProvider FileSystem -Root "\\vmware-host\Shared Folders"
    ```
- Copy the Apache Zip file to your Windows Server Core.
    - Open PowerShell pressing `15` and then `Enter`.
    - Run the following command to copy the file.
    ```powershell
    Copy-Item -Path "VMwareHost:\temp\apache24.zip" -Destination "C:\"
    ```
- Unzip the file to `C:\apache24` using PowerShell.
    - Open PowerShell pressing `15` and then `Enter`.
    - Run the following command to unzip the file and clean up.
    ```powershell
    Expand-Archive -Path "C:\apache24.zip" -DestinationPath "C:\"
    Remove-Item -Path "C:\apache24.zip"
    ```
- Download and install the Visual `C++` Redistributable Package.
    - Open PowerShell pressing `15` and then `Enter`.
    - Run the following command to download the file.
    ```powershell
    Invoke-WebRequest -Uri "https://aka.ms/vs/16/release/vc_redist.x64.exe" -OutFile "C:\vc_redist.x64.exe"
    ```
    - Run the following command to install the file.
    ```powershell
    Start-Process -FilePath "C:\vc_redist.x64.exe" -ArgumentList "/install", "/quiet", "/norestart" -Wait
    ```
- Open firewall port: `netsh firewall set portopening TCP 80, 8080 AND 443 Apache Web Server`.
    - Open PowerShell pressing `15` and then `Enter`.
    - Run the following command to open the port.
    ```powershell
    netsh advfirewall firewall add rule name="Apache Web Server" dir=in action=allow protocol=TCP localport=80
    netsh advfirewall firewall add rule name="Apache Web Server" dir=in action=allow protocol=TCP localport=8080
    netsh advfirewall firewall add rule name="Apache Web Server" dir=in action=allow protocol=TCP localport=443
    ```
- Make sure the configuration of the [Lab1-Apache](/Documentation/Lab1-Apache.md) is on your Server Core.
> **Note:** The zip file above was a custom zip file with all the necessary configurations of Lab1.
- You need to change the configuration file with the correct server name.
    - Open PowerShell pressing `15` and then `Enter`.
    - Run the following command to open the file.
    ```powershell
    notepad C:\apache24\conf\httpd.conf
    ```
    - Change the `ServerName` to the correct server name. (There is more than one `ServerName` in the file)
    ```conf
    ServerName WINCORE
    ```
- Run the following command to start the Apache server.
    ```powershell
    C:\apache24\bin\httpd.exe
    ```
- Test if everything works.
    - Open a web browser and go to `http://192.168.x.x:80` and `http://192.168.x.x:8080`.
    - You should see the Apache test page.

> This should be the result.

![x](/Images/Lab5-WindowsServerCore-3.png)
    
### 👉Step 3: HTTPS

- Make self-signed certificates (see REF 3) and place them in the `conf` directory of Apache.
    - Open PowerShell pressing `15` and then `Enter`.
    - Run the following command to create the certificates.
    ```powershell
    cd C:\apache24\bin
    .\openssl.exe req -x509 -nodes -days 365 -newkey rsa:2048 -keyout C:\apache24\conf\server.key -out C:\apache24\conf\server.crt
    ```
    - Country Name (2 letter code) [AU]: `BE`
    - State or Province Name (full name) [Some-State]: `Antwerp`
    - Locality Name (eg, city) []: `Antwerp`
    - Organization Name (eg, company) [Internet Widgits Pty Ltd]: `KdG`
    - Organizational Unit Name (eg, section) []: `ICT`
    - Common Name (e.g. server FQDN or YOUR name) []: `WINCORE`
    - Email Address []: `elias.dehondt@outlook.com`
- Change the configuration file to use the certificates.
    - Open PowerShell pressing `15` and then `Enter`.
    - Run the following command to open the file.
    ```powershell
    notepad C:\apache24\conf\httpd.conf
    ```
    - Add to the file.
    ```conf
    LoadModule ssl_module modules/mod_ssl.so
    Listen 443
    <VirtualHost *:443>
            ServerName WINCORE
            ServerRoot c:/apache24
            DocumentRoot c:/apache24/web/kdg
            DirectoryIndex index.html

        SSLEngine on
            SSLCertificateFile "c:/apache24/conf/server.crt"
            SSLCertificateKeyFile "c:/apache24/conf/server.key"
    </VirtualHost>
    ```

### 👉Step 4: PowerShell remoting

- Run `Enable-PSRemoting` on your host and guest machine (ev. with optie `-SkipNetworkProfileCheck`). **SERVER CORE**
    - Open PowerShell pressing `15` and then `Enter`.
    - Run the following command to enable remoting.
    ```powershell
    Enable-PSRemoting -SkipNetworkProfileCheck
    ```
- On Host: `Set-Item -Path wsman:\localhost\client\Trustedhosts -Value 'HierIPvanGuest'`. **HOST**
    - Open PowerShell as an administrator.
    - Run the following command to set the trusted hosts.
    ```powershell
    Start-Service WinRM
    Set-Item -Path wsman:\localhost\client\Trustedhosts -Value '192.168.19.9'
    ```
    - Press `Y` and then `Enter` to confirm.
    - Press `Enter` to confirm.
- Start session: `Enter-PSSession -ComputerName HierIPvanGuest -Credential WINCORE\administrator`. **HOST**
    - Open PowerShell as an administrator.
    - Run the following command to start the session.
    ```powershell
    Enter-PSSession -ComputerName '192.168.19.9' -Credential 'WINCORE\Elias De Hondt'
    ```
    - Enter the password and press `Enter`.
- Stop session: `Exit-PSSession`. **HOST**
    - Run the following command to stop the session.
    ```powershell
    Exit-PSSession
    ```
- You can also do this from `Powershell ISE` -> `File` -> `New Remote Powershell Tab`.
    - Computer: `192.168.19.9`
    - User: `WINCORE\Elias De Hondt`
    - Password: `********`
- And run a command remotely:
    - Open PowerShell as an administrator.
    - Run the following command to run a command remotely.
    ```powershell
    Invoke-Command -ComputerName '192.168.19.9' -Credential 'WINCORE\Elias De Hondt' -ScriptBlock {Get-Disk}
    ```

## 📦Extra

- `httpd.conf` without comment:
```html
LoadModule authz_core_module modules/mod_authz_core.so
LoadModule dir_module modules/mod_dir.so
LoadModule autoindex_module modules/mod_autoindex.so
LoadModule info_module modules/mod_info.so
LoadModule authn_core_module modules/mod_authn_core.so
LoadModule authn_file_module modules/mod_authn_file.so
LoadModule authz_user_module modules/mod_authz_user.so
LoadModule authz_groupfile_module modules/mod_authz_groupfile.so
LoadModule auth_basic_module modules/mod_auth_basic.so
LoadModule userdir_module modules/mod_userdir.so
# LoadModule authz_user_module modules/mod_authz_user.so
LoadModule alias_module modules/mod_alias.so
LoadModule authz_host_module modules/mod_authz_host.so
LoadModule ssl_module modules/mod_ssl.so

Listen 80
Listen 8080
Listen 443

<VirtualHost *:80>
        ServerName WINCORE
        ServerRoot c:/apache24
        DocumentRoot c:/apache24/web/kdg
        DirectoryIndex index.html

        Redirect /google http://www.google.com

        <Directory "c:/apache24/web/kdg/test">
                Options Indexes FollowSymLinks
                Require all granted
        </Directory>

        <Directory "c:/apache24/web/kdg/test2">
                Options Indexes FollowSymLinks
                AllowOverride AuthConfig
                Require all granted
        </Directory>

        UserDir "c:/Users/*/www"
        <Directory "c:/Users/*/www">
                Options Indexes FollowSymLinks
                AllowOverride None
                Require all granted
        </Directory>

        <Location "/server-info">
                SetHandler server-info
                Require ip 127.0.0.1
                Require ip ::1
	</Location>
</VirtualHost>

<VirtualHost *:8080>
        ServerName WINCORE
        DocumentRoot c:/apache24/htdocs
        <Directory "c:/apache24/htdocs">
                Options Indexes FollowSymLinks
                Require all granted
        </Directory>

        <Location "/">
                AuthType Basic
                AuthName "Restricted Access"
                AuthUserFile "c:/apache24/web/users"
                AuthGroupFile "c:/apache24/web/group"
                Require group docenten
        </Location>
</VirtualHost>

<VirtualHost *:443>
        ServerName WINCORE
        ServerRoot c:/apache24
        DocumentRoot c:/apache24/web/kdg
        DirectoryIndex index.html

	SSLEngine on
    	SSLCertificateFile "c:/apache24/conf/server.crt"
    	SSLCertificateKeyFile "c:/apache24/conf/server.key"
</VirtualHost>
```
- `server.crt` without comment:
```text
-----BEGIN CERTIFICATE-----
MIID9TCCAt2gAwIBAgIUBPIEJLKuzrTHiAgQyzMzPa+tdzYwDQYJKoZIhvcNAQEL
BQAwgYkxCzAJBgNVBAYTAkJFMRAwDgYDVQQIDAdBbnR3ZXJwMRAwDgYDVQQHDAdB
bnR3ZXJwMQwwCgYDVQQKDANLZEcxDDAKBgNVBAsMA0lDVDEQMA4GA1UEAwwHV0lO
Q09SRTEoMCYGCSqGSIb3DQEJARYZZWxpYXMuZGVob25kdEBvdXRsb29rLmNvbTAe
Fw0yNDAzMDUxMTE1MjZaFw0yNTAzMDUxMTE1MjZaMIGJMQswCQYDVQQGEwJCRTEQ
MA4GA1UECAwHQW50d2VycDEQMA4GA1UEBwwHQW50d2VycDEMMAoGA1UECgwDS2RH
MQwwCgYDVQQLDANJQ1QxEDAOBgNVBAMMB1dJTkNPUkUxKDAmBgkqhkiG9w0BCQEW
GWVsaWFzLmRlaG9uZHRAb3V0bG9vay5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IB
DwAwggEKAoIBAQDxVirPPpXbJrLuFXuqs5LV7dL0+vbvT2ggRK1oV7mS5SjCgXJm
0B9R15f0q8eSkzlDi2pM2Xc2ZY3ABJZPIyImQpUZn0SnU3MP3K2HK8VBPY2AuXmE
qpR3lOX/vYJdv+IzV96X2b8juCy34jpYGcOcCIN9EPRfYyZC9f+5cRbiQXtKJaRl
sKns2CgRBKkl7GLqz9KqB3mU0E++EZCX0ln3d4tJbitcbi0d041IxmmjBPnwc7FE
9tcBav30E83t3y/vZ39MMjSd0tatGagajiQGiLtkYSUikKHb+mN0sFFHiV0RVuMi
2Y6/8urGlvBnbB55gKqGrlxzuq7/b7l4/R3PAgMBAAGjUzBRMB0GA1UdDgQWBBRk
/K0PwUkOcTw3+Lj1Z3vE+HHnbjAfBgNVHSMEGDAWgBRk/K0PwUkOcTw3+Lj1Z3vE
+HHnbjAPBgNVHRMBAf8EBTADAQH/MA0GCSqGSIb3DQEBCwUAA4IBAQC7x8ra9/bB
gmOW0IybnZcGRX0ZC+zju72NOrQjs1MrADsT48DrRcFrO63rQmwWHnGPnh1XlDVx
RGl859cZPXfigTRna9TFvBFYl+R2Syou9BuCZld+DWoP+WQS/pbQ17XtiR/STVgb
m5Sbsufo34CzHIkTDRprb1TOT4U8gq84KKgujCNaxdBxsNSaM2kdwJw3ThsWZQir
hEsf4DeUAwjrrgW13azx+f2QYpSamDaeorDNCcGuLuCbKqeSK/J2jDSLMsOz4hZ+
5qsSxA5GolYhdZgnaXzl7PYFz/QXcRJzOgWBZ1O4apRJaIrcr1YnRiHSwI7QrvWm
9Oii1uwgXfjJ
-----END CERTIFICATE-----
```
- `server.key` without comment:
```text
-----BEGIN PRIVATE KEY-----
MIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDxVirPPpXbJrLu
FXuqs5LV7dL0+vbvT2ggRK1oV7mS5SjCgXJm0B9R15f0q8eSkzlDi2pM2Xc2ZY3A
BJZPIyImQpUZn0SnU3MP3K2HK8VBPY2AuXmEqpR3lOX/vYJdv+IzV96X2b8juCy3
4jpYGcOcCIN9EPRfYyZC9f+5cRbiQXtKJaRlsKns2CgRBKkl7GLqz9KqB3mU0E++
EZCX0ln3d4tJbitcbi0d041IxmmjBPnwc7FE9tcBav30E83t3y/vZ39MMjSd0tat
GagajiQGiLtkYSUikKHb+mN0sFFHiV0RVuMi2Y6/8urGlvBnbB55gKqGrlxzuq7/
b7l4/R3PAgMBAAECggEAF9mItrbPPztOa+IdnyhkUDxSuh974pLgJ6HOpt6JTVYH
0CkHJQsksGunVBuoLl90RXn0OFucjcVwqIalIA78MF6PtsEbNMbPbfeqz0GCtEht
ja7gSApF5jqfYpJxqetTlfiO2+AKvqOHb88Tx8iybXh96t2PeOAm7aK7JRiWLVrs
8JltLk/Y2HdFm7l/rAnxhSSyLsFte1YbCg6cKhSPCplp4IeYH3NBOZ0uYvBcphS1
iC1RpQuR2RGJgY0FwIVPZwTq3TaBoxG9WICPCvI7F9JbuUbQJCi9UjipBYW84FT9
uV8GiA51ZlRQAnQsqcEcjuug2ZOcNpdDRJBIQCxNOQKBgQD9tv9oiKR1Wo/rUadi
SrU2AN4CP1F/x495wAPkbamR/m0EMkqYjv1qalUXAYee9zl7X0/A9Q+LiG/5D1RQ
3+21FTD9a30cPHk4w2y5Wir1c5DglLEztCxoihAvgT57PyPIITn3kOa8WQ8VGae8
iLqJnK/9fDv2Wk/NIrQvWq6VVQKBgQDzgqDg9Dmjp0QtzG+FxRJqwxrUho2eCZp7
4WL0drfTAKLSZji55pil7D8ZsZEaXxc0KHiawOsT64GkEKAt2kl8U1mqzHyR3P29
agHi03fWTvTGFwMbZOLTT3sRPzw0vIzGQthECz2/M0FnupJhgq8WO530yC577Q6x
/n2TmkfmkwKBgQDZi4nglhl9zpNM0QzXCPvsPD4gay50hCaP3Ib53NXjKudLC9xO
h3zfPCGNwnAJbC5LjOQTrY0QtYJdajl/xyJJfMwu33W9OlUuyNJ288uV/uugxZ5T
mQ/i608JjKaIgxEpTuQnVIWjxjFahE8BJ7PavxFgJqA7kiCO4kzhtb2wqQKBgQDv
w9JGTRKn2d1evumcLEQLDRpQ4j90uX37thuqG266eujXA8GdAbmRvgEPenAmKDT/
rU27CnMsxPl8Isak/0bV/HfQndGWCaNpqoQ64/8d69ZFaYksovRYHe1OORY90t1F
pbGtpefhaEVhLipNitB8sqy/xY9HhE2w4qSg/gsHswKBgQCffaPX4FmWxWwYMS78
2JrLNQbZCQ9gWfi6LdzOk0kxzOMiBdg2N1zJ0ZQULJFq0EIwRtUOsU4R0EIlxjry
+DJg7//T45kcnocRjCEfnqybv6L6KjbjjW8sOaNM6ZP29tzLSXd4TXRwZ0u+dSvK
vIywY7h9xwhp2KYmGMfvwmwV5g==
-----END PRIVATE KEY-----
```


## 🔗Links
- 👯 Web hosting company [EliasDH.com](https://eliasdh.com).
- 📫 How to reach us eliasdehondt@outlook.com.