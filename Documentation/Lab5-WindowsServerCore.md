![logo](/Images/logo.png)
# 💙🤍Lab5 Windows Server Core🤍💙

## 📘Table of Contents

1. [📘Table of Contents](#📘table-of-contents)
2. [🖖Introduction](#🖖introduction)
3. [📝Assignment](#📝assignment)

---

## 🖖Introduction



### 📝Assignment 
> NOTE This is in Dutch

 
- DOEL: Windows server Core
- REF: 
    - https://docs.microsoft.com/en-us/windows-server/get-started/getting-started-with-server-core
    - https://www.sslshopper.com/apache-server-ssl-installation-instructions.html 
    - https://www.sslshopper.com/article-how-to-create-and-install-an-apache-self-signed-certificate.html 


0. INSTALLATIE
    - Download Windows Server 2022 64-bit van Microsoft DreamSpark.
    - We installeren nu de Core versie (zonder desktop experience!).
    - Geef je virtuele machine in VirtualBox 2 netwerkkaarten: 1 NAT + 1 host-only (waarom?)

1. BASISCONFIGURATIE met sconfig
    - Start de Windows Core server en log in.
    - Start sconfig (bij installatie in een andere taal dan Engels, moet je mogelijks het ganse pad ingeven->google).
    - Geef de server een leesbare computernaam: `WINCORE`.
    - Zet Windows updates op handmatig.
    - Geef de `host-only` adapter (waarom deze en niet de `NAT` adapter?) een vast IP adres (waarom?) kies het adres rekening houdend met de `DHCP` range van het `host-only` netwerk in VirtualBox (waarom?).
    - Reboot de server.

2. APACHE INSTALLATIE
    - Maak in VirtualBox een `Gedeelde Map` aan zodat je files kan uitwisselen tussen host en guest.
    - Zet je Apache Zip file (zie `Apache oefening`) op je Windows Server Core.
    - Doe een unzip naar `C:\Apache24` door gebruik te maken van PowerShell.
    - Download en installeer de Visual `C++` Redistributable Package (zie readme van Apache).
    - Open firewall poort: netsh firewall set portopening `TCP 80` `Apache Web Server`.
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
    - E n commando remote uitvoeren:
        - `Invoke-Command -ComputerName HierIPvanGuest -Credential WINCORE\administrator -ScriptBlock {Get-Disk}`.

## ✨Steps

### 👉 Step 0: 

## 📦Extra


## 🔗Links
- 👯 Web hosting company [EliasDH.com](https://eliasdh.com).
- 📫 How to reach us eliasdehondt@outlook.com.