![logo](https://eliasdh.com/assets/media/images/logo-github.png)
# 💙🤍Lab6 Windows Server IIS🤍💙

## 📘Table of Contents

1. [📘Table of Contents](#📘table-of-contents)
2. [🖖Introduction](#🖖introduction)
3. [📝Assignment](#📝assignment)
4. [✨Steps](#✨steps)
    1. [👉 Step 0: Installation IIS](#👉step-0-installation-iis)
    2. [👉 Step 1: IIS Manager](#👉step-1-iis-manager)
    3. [👉 Step 2: Additional Website.](#👉step-2-additional-website)
    4. [👉 Step 3: DNS](#👉step-3-dns)
    5. [👉 Step 4: Active Directory](#👉step-4-active-directory)
    6. [👉 Step 5: HTTP Redirection](#👉step-5-http-redirection)
    7. [👉 Step 6: IIS Basic Authentication](#👉step-6-iis-basic-authentication)
    8. [👉 Step 7: IIS Windows Authentication](#👉step-7-iis-windows-authentication)
    9. [👉 Step 8: IP and Domain Restrictions](#👉step-8-ip-and-domain-restrictions)
5. [📦Extra](#📦extra)
6. [🔗Links](#🔗links)

---

## 🖖Introduction

This lab is about configuring IIS on a Windows Server. The goal is to get familiar with the IIS manager and to configure a few websites. We will also configure DNS and Active Directory to make the websites accessible from other machines. We will also configure HTTP Redirection, Basic Authentication and Windows Authentication.

### 📝Assignment 
> NOTE This is in Dutch

- DOEL: Configuratie IIS
- NODIG: Windows Server met AD en IIS
	
0. Installatie IIS
- Check of IIS geinstalleerd via `Server Manager` -> `Manage` -> `Add Role and Features`.
- Voeg ook `ftp server`, `Basic Authentication`, `Windows Authentication` ,`HTTP Redirection` en `IP and Domain Restrictions` toe.
	
1. Start IIS manager. 
- Pas de Default Website website aan zodat deze naar directory in `C:\shares\defaultweb` verwijst (maak deze aan).
- Maak een `start.htm` aan en zorg dat dit je default document wordt.
- Maak een subdirectory test aan en laat directory browsing toe (enkel in test, NIET in defaultweb!). 
- Maak hiervoor gebruik van `Applications`.
- Test dit uit vanop je host machine.

2. Creëer een extra website.
- Maak een extra ip adres aan (bv. `192.168.56.51` als je eerste IP adres `192.168.56.50` is).
- Maak een website `C:\shares\web2` op `http://192.168.56.51` met poort `8080`. 
- Werkt dit ook vanuit je host machine? Indien niet, los dit op (de firewall mag niet uitgezet worden!).

3. DNS
- Maak een 3de website aan. Zorg met je dns server dat requests naar `www.<vul_hier_uw_voornaam_in>.org` terecht komen bij de website in `C:\shares\web3`. 
- Test dit uit vanop de Windows server.

4. Active Directory
- Maak `C:\shares\web4` aan voor je bestaande AD domein (bv `vandevelde.local`). Zorg dat jou server als www aanspreekbaar is: bv `www.vandevelde.local`.
- Test dit uit vanop een virtuele `Windows 10` die in hetzelfde domain zit.

5. HTTP Redirection
Implementeer een redirect zodat `http://www.<vul_hier_uw_domein_in>.local/google` naar `www.google.be` wordt doorgeschakeld. 

6. IIS Basic authentication
- Tot nu toe werd steeds gebruikt gemaakt van anonymous authentication.
- Maak in Active Directory de gebruiker webuser. 
- Maak in `IIS Manager` een site `Basic` aan op poort 8001 met pad `C:\shares\Basic` en Basic authentication.
- Test uit vanop je host omgeving. 
- Installeer de `HTTP header Live` in Firefox en onderschep het geencodeerde paswoord voor webuser.
- Welke encodering wordt gebruikt? Kan je deze decoderen?

7. IIS Windows Authentication
- Maak een site `Windows` aan op poort 8002 met pad `C:\shares\Windows` en Windows authentication.
- Test uit vanop je host omgeving. 
Kan je nu het paswoord ook decoderen?

8. IP and Domain Restrictions
- Filter je IP adres, zodat je vanuit een andere machine (bv je host of een andere virtuele machine) niet op de default website geraakt (maar wel bv vanop je windows server zelf).
- De andere websites moeten wel toegankelijk blijven voor deze andere machine.

## ✨Steps

### 👉Step 0: Installation IIS

- Open `Server Manager` and click on `Manage` and then `Add Role and Features`. (`WIN + R` and type `ServerManager`).
- Click on `Next` until you reach the `Server Roles` tab.
- Check `Web Server (IIS)` and click on `Next`.
- Click on `Next` until you reach the `Role Services` tab.
- Check `FTP Server`, `Basic Authentication`, `Windows Authentication`, `HTTP Redirection` and `IP and Domain Restrictions`.
- Click on `Next` and then `Install`.

### 👉Step 1: IIS Manager

- Create a directory `C:\shares\defaultweb`.
    ```powershell
    mkdir C:\shares\defaultweb
    ```
- Open `IIS Manager`. (`WIN + R` and type `inetmgr`).
- Click on `WINSERVER` and then `Sites`.
- Right click on `Default Web Site` and click on `Manage Website` and then `Advanced Settings`.
- Change the `Physical Path` to `C:\shares\defaultweb`.
- Create a file `start.htm` in the `C:\shares\defaultweb` directory.
    ```powershell
    echo '<!DOCTYPE html><html lang="en"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0"><title>Windows Server IIS Default Web Site</title><style>body {font-family: Arial, sans-serif;background-color: #f0f0f0;text-align: center;margin-top: 50px;}.container {width: 50%;margin: 0 auto;background-color: #4F94F0;padding: 20px;border-radius: 10px;box-shadow: 0 0 10px rgba(0,0,0,0.1);}h1 {olor: #333;}.eliasdh {color: #ffffff;text-decoration: none;font-weight: bold;}.eliasdh:hover {color: #357ac0; text-decoration: none;}</style></head><body><div class="container"><h1>Windows Server IIS Default Web Site</h1><a class="eliasdh" target="_blank" href="/test">Test Folder</a><p>Welcome to my cool web page!</p><p>Design by Elias De Hondt<br>Copyright &copy; <a class="eliasdh" target="_blank" href="https://eliasdh.com">EliasDH</a><br>All rights Reserved</p></div></body></html>' > C:\shares\defaultweb\start.htm
    ```
- Click on `Default Web Site` and then `Directory Browsing`.
    - Click on `Add...` and then type `start.htm` and click on `OK`.
- Create a subdirectory `test` in the `C:\shares\defaultweb` directory.
    ```powershell
    mkdir C:\shares\defaultweb\test
    ```
- Click on `Default Web Site` and then `Add Application`.
    - Type `test` in the `Alias` field and select the `C:\shares\defaultweb\test` directory.
- Test this out from your host machine. In my case `http://192.168.19.10:80` and `http://192.168.19.10:80/test`.

> This should be the result.

![x](/Images/Lab6-WindowsServerIIS-1.png)
![x](/Images/Lab6-WindowsServerIIS-2.png)

### 👉Step 2: Additional Website.

- Create a directory `C:\shares\web2`.
    ```powershell
    mkdir C:\shares\web2
    ```
- Add an additional IP address. (Current IP adres: `192.168.19.10`).
    - Go to `Network and Sharing Center` and then `Change adapter settings`.
    - Right click on `Host-Only-Team` and click on `Properties`.
    - Select `Internet Protocol Version 4 (TCP/IPv4)` and click on `Properties`.
    - Click on `Advanced...` and then `Add...`.
    - Type `192.168.19.11` and `255.255.255.0` and click on `Add`.
    - Click on `OK` and then `Close`.
- Open `IIS Manager`. (`WIN + R` and type `inetmgr`).
- Click on `WINSERVER` and then `Sites`.
- Right click on `Sites` and click on `Add Website`.
    - Site name: `Web2`.
    - Physical path: `C:\shares\web2`.
    - IP address: `192.168.19.11`.
    - Port: `8080`.
- Create a file `start.htm` in the `C:\shares\defaultweb` directory.
    ```powershell
    echo '<!DOCTYPE html><html lang="en"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0"><title>Windows Server IIS Web 2</title><style>body {font-family: Arial, sans-serif;background-color: #f0f0f0;text-align: center;margin-top: 50px;}.container {width: 50%;margin: 0 auto;background-color: #4F94F0;padding: 20px;border-radius: 10px;box-shadow: 0 0 10px rgba(0,0,0,0.1);}h1 {olor: #333;}.eliasdh {color: #ffffff;text-decoration: none;font-weight: bold;}.eliasdh:hover {color: #357ac0; text-decoration: none;}</style></head><body><div class="container"><h1>Windows Server IIS Web 2</h1><p>Welcome to my cool web page!</p><p>Design by Elias De Hondt<br>Copyright &copy; <a class="eliasdh" target="_blank" href="https://eliasdh.com">EliasDH</a><br>All rights Reserved</p></div></body></html>' > C:\shares\web2\index.html
    ```
- Set the firewall rule to allow port `8080`.
    ```powershell
    New-NetFirewallRule -DisplayName "Allow Port 80" -Direction Inbound -LocalPort 80 -Protocol TCP -Action Allow
    New-NetFirewallRule -DisplayName "Allow Port 8080" -Direction Inbound -LocalPort 8080 -Protocol TCP -Action Allow
    New-NetFirewallRule -DisplayName "Allow Port 8001" -Direction Inbound -LocalPort 8001 -Protocol TCP -Action Allow
    New-NetFirewallRule -DisplayName "Allow Port 8002" -Direction Inbound -LocalPort 8002 -Protocol TCP -Action Allow
    ```
- Test this out from your host machine. In my case `http://192.168.19.11:8080`.

> This should be the result.

![x](/Images/Lab6-WindowsServerIIS-3.png)
![x](/Images/Lab6-WindowsServerIIS-4.png)

### 👉Step 3: DNS

- Create a directory `C:\shares\web3`.
    ```powershell
    mkdir C:\shares\web3
    ```
- Open `IIS Manager`. (`WIN + R` and type `inetmgr`).
- Click on `WINSERVER` and then `Sites`.
- Right click on `Sites` and click on `Add Website`.
    - Site name: `Web3`.
    - Physical path: `C:\shares\web3`.
    - Host name: `www.elias.org`.
- Create a file `start.htm` in the `C:\shares\web3` directory.
    ```powershell
    echo '<!DOCTYPE html><html lang="en"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0"><title>Windows Server IIS Web 3</title><style>body {font-family: Arial, sans-serif;background-color: #f0f0f0;text-align: center;margin-top: 50px;}.container {width: 50%;margin: 0 auto;background-color: #4F94F0;padding: 20px;border-radius: 10px;box-shadow: 0 0 10px rgba(0,0,0,0.1);}h1 {olor: #333;}.eliasdh {color: #ffffff;text-decoration: none;font-weight: bold;}.eliasdh:hover {color: #357ac0; text-decoration: none;}</style></head><body><div class="container"><h1>Windows Server IIS Web 3</h1><p>Welcome to my cool web page!</p><p>Design by Elias De Hondt<br>Copyright &copy; <a class="eliasdh" target="_blank" href="https://eliasdh.com">EliasDH</a><br>All rights Reserved</p></div></body></html>' > C:\shares\web3\index.html
    ```
- Open `DNS Manager`. (`WIN + R` and type `dnsmgmt`).
- Right click on `WINSERVER` and click on `Forward Lookup Zones`.
- Right click `New Zone...` and click on `Next`.
- Click on `Next` until you reach the `Zone Name` tab.
    - Zone name: `elias.org`.
    - Click on `Next` and then `Finish`.
- Right click on `elias.org` and click on `New Host (A or AAAA)`.
    - Name: `www`.
    - IP address: `192.168.19.10`.
- Test this out from the Windows server. In my case `www.elias.org`.
> This should be the result.

![x](/Images/Lab6-WindowsServerIIS-5.png)
![x](/Images/Lab6-WindowsServerIIS-6.png)
![x](/Images/Lab6-WindowsServerIIS-7.png)

### 👉Step 4: Active Directory

- Create a directory `C:\shares\web4`.
    ```powershell
    mkdir C:\shares\web4
    ```
- Open `IIS Manager`. (`WIN + R` and type `inetmgr`).
- Click on `WINSERVER` and then `Sites`.
- Right click on `Sites` and click on `Add Website`.
    - Site name: `Web4`.
    - Physical path: `C:\shares\web4`.
    - Host name: `www.dehondt.local`.
- Create a file `start.htm` in the `C:\shares\web4` directory.
    ```powershell
    echo '<!DOCTYPE html><html lang="en"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0"><title>Windows Server IIS Web 4</title><style>body {font-family: Arial, sans-serif;background-color: #f0f0f0;text-align: center;margin-top: 50px;}.container {width: 50%;margin: 0 auto;background-color: #4F94F0;padding: 20px;border-radius: 10px;box-shadow: 0 0 10px rgba(0,0,0,0.1);}h1 {olor: #333;}.eliasdh {color: #ffffff;text-decoration: none;font-weight: bold;}.eliasdh:hover {color: #357ac0; text-decoration: none;}</style></head><body><div class="container"><h1>Windows Server IIS Web 4</h1><p>Welcome to my cool web page!</p><p>Design by Elias De Hondt<br>Copyright &copy; <a class="eliasdh" target="_blank" href="https://eliasdh.com">EliasDH</a><br>All rights Reserved</p></div></body></html>' > C:\shares\web4\index.html
    ```
- Open `DNS Manager`. (`WIN + R` and type `dnsmgmt`).
- Right click on `WINSERVER` and click on `Forward Lookup Zones`.
- Right click on `dehondt.local` and click on `New Host (A or AAAA)`.
    - Name: `www`.
    - IP address: `192.168.19.10`.
- Test this out from a virtual `Windows 11` that is in the same domain. In my case `www.dehondt.local`.

> This should be the result.

![x](/Images/Lab6-WindowsServerIIS-8.png)


### 👉Step 5: HTTP Redirection

- Create a directory `C:\shares\web4\google`.
    ```powershell
    mkdir C:\shares\web4\google
    ```
- Open `IIS Manager`. (`WIN + R` and type `inetmgr`).
- Click on `WINSERVER` and then `Sites`.
- Right click on `Web4` and click on `Add Virtual Directory`.
    - Alias: `google`.
    - Physical path: `C:\shares\web4\google`.
- Click on `Web4\google` and then `HTTP Redirect`.
    - Check `Redirect requests to this destination`.
    - Type `http://www.google.com` and check `Only redirect requests to content in this directory (not subdirectories)`.
    Click on `Apply`.
- Test this out from a virtual `Windows 11` that is in the same domain. In my case `www.dehondt.local/google`

> This should be the result.

![x](/Images/Lab6-WindowsServerIIS-9.png)

### 👉Step 6: IIS Basic Authentication

- Create a directory `C:\shares\basic`.
    ```powershell
    mkdir C:\shares\basic
    ```
- Open `Active Directory Users and Computers`. (`WIN + R` and type `dsa.msc`).
- Right click on `Users` and click on `New` and then `User`.
    - First name: `webuser`.
    - User logon name: `webuser`.
    - Password: `webuser`.
- Open `IIS Manager`. (`WIN + R` and type `inetmgr`).
- Click on `WINSERVER` and then `Sites`.
- Right click on `Sites` and click on `Add Website`.
    - Site name: `Basic`.
    - Physical path: `C:\shares\basic`.
    - Port: `8001`.
- Click on `Basic` and then `Authentication`.
    - Disable `Anonymous Authentication`.
    - Enable `Basic Authentication`.
- Test this out from your host environment. In my case `http://192.168.70.136:8001`

> This should be the result.

![x](/Images/Lab6-WindowsServerIIS-10.png)

- Install the `HTTP header Live` in Firefox and intercept the encoded password for `webuser`.
    - Which encoding is used? 
    - Can you decode it?
> The encoding used is `base64`. You can decode it by using a `base64` decoder.

### 👉Step 7: IIS Windows Authentication

- Create a directory `C:\shares\windows`.
    ```powershell
    mkdir C:\shares\windows
    ```
- Open `IIS Manager`. (`WIN + R` and type `inetmgr`).
- Click on `WINSERVER` and then `Sites`.
- Right click on `Sites` and click on `Add Website`.
    - Site name: `Windows`.
    - Physical path: `C:\shares\windows`.
    - Port: `8002`.
- Click on `Windows` and then `Authentication`.
- Enable `Windows Authentication`.
- Test this out from your host environment. In my case `http://192.168.70.136:8002`

- You should be prompted to enter your credentials. If not, you can do this in powershell to force it.
    ```powershell
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\HTTP\Parameters" -Name "DisableServerHeader" -Value 0 -Type DWord
    ```
- Can you decode the password now?
> No, you can't decode the password now.

> This should be the result.

![x](/Images/Lab6-WindowsServerIIS-11.png)

### 👉Step 8: IP and Domain Restrictions

- Open `IIS Manager`. (`WIN + R` and type `inetmgr`).
- Click on `WINSERVER` and then `Sites`.
- Click on `Default Web Site` and then `IP Address and Domain Restrictions`.
- Click on `Add Deny Entry...`.
    - Select `IPv4 address range` and type `192.168.19.0` and `192.168.19.255`.
- Click on `OK`.
- Test this out from another machine. In my case `http://192.168.19.10:80`.
> You should not have access.

![x](/Images/Lab6-WindowsServerIIS-12.png)

## 📦Extra

- You can configure most of the above with a PowerShell script:
    ```powershell
    # Install IIS
    Install-WindowsFeature -Name Web-Server -IncludeManagementTools
    Install-WindowsFeature -Name Web-Ftp-Server
    Install-WindowsFeature -Name Web-Basic-Auth
    Install-WindowsFeature -Name Web-Windows-Auth
    Install-WindowsFeature -Name Web-Http-Redirect
    Install-WindowsFeature -Name Web-IP-Security

    # Create directories
    mkdir C:\shares\defaultweb
    mkdir C:\shares\web2
    mkdir C:\shares\web3
    mkdir C:\shares\web4
    mkdir C:\shares\basic
    mkdir C:\shares\windows

    # Create files
    echo '<!DOCTYPE html><html lang="en"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0"><title>Windows Server IIS Default Web Site</title><style>body {font-family: Arial, sans-serif;background-color: #f0f0f0;text-align: center;margin-top: 50px;}.container {width: 50%;margin: 0 auto;background-color: #4F94F0;padding: 20px;border-radius: 10px;box-shadow: 0 0 10px rgba(0,0,0,0.1);}h1 {olor: #333;}.eliasdh {color: #ffffff;text-decoration: none;font-weight: bold;}.eliasdh:hover {color: #357ac0; text-decoration: none;}</style></head><body><div class="container"><h1>Windows Server IIS Default Web Site</h1><a class="eliasdh" target="_blank" href="/test">Test Folder</a><p>Welcome to my cool web page!</p><p>Design by Elias De Hondt<br>Copyright &copy; <a class="eliasdh" target="_blank" href="https://eliasdh.com">EliasDH</a><br>All rights Reserved</p></div></body></html>' > C:\shares\defaultweb\start.htm
    echo '<!DOCTYPE html><html lang="en"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0"><title>Windows Server IIS Web 2</title><style>body {font-family: Arial, sans-serif;background-color: #f0f0f0;text-align: center;margin-top: 50px;}.container {width: 50%;margin: 0 auto;background-color: #4F94F0;padding: 20px;border-radius: 10px;box-shadow: 0 0 10px rgba(0,0,0,0.1);}h1 {olor: #333;}.eliasdh {color: #ffffff;text-decoration: none;font-weight: bold;}.eliasdh:hover {color: #357ac0; text-decoration: none;}</style></head><body><div class="container"><h1>Windows Server IIS Web 2</h1><p>Welcome to my cool web page!</p><p>Design by Elias De Hondt<br>Copyright &copy; <a class="eliasdh" target="_blank" href="https://eliasdh.com">EliasDH</a><br>All rights Reserved</p></div></body></html>' > C:\shares\web2\index.html
    echo '<!DOCTYPE html><html lang="en"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0"><title>Windows Server IIS Web 3</title><style>body {font-family: Arial, sans-serif;background-color: #f0f0f0;text-align: center;margin-top: 50px;}.container {width: 50%;margin: 0 auto;background-color: #4F94F0;padding: 20px;border-radius: 10px;box-shadow: 0 0 10px rgba(0,0,0,0.1);}h1 {olor: #333;}.eliasdh {color: #ffffff;text-decoration: none;font-weight: bold;}.eliasdh:hover {color: #357ac0; text-decoration: none;}</style></head><body><div class="container"><h1>Windows Server IIS Web 3</h1><p>Welcome to my cool web page!</p><p>Design by Elias De Hondt<br>Copyright &copy; <a class="eliasdh" target="_blank" href="https://eliasdh.com">EliasDH</a><br>All rights Reserved</p></div></body></html>' > C:\shares\web3\index.html
    echo '<!DOCTYPE html><html lang="en"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0"><title>Windows Server IIS Web 4</title><style>body {font-family: Arial, sans-serif;background-color: #f0f0f0;text-align: center;margin-top: 50px;}.container {width: 50%;margin: 0 auto;background-color: #4F94F0;padding: 20px;border-radius: 10px;box-shadow: 0 0 10px rgba(0,0,0,0.1);}h1 {olor: #333;}.eliasdh {color: #ffffff;text-decoration: none;font-weight: bold;}.eliasdh:hover {color: #357ac0; text-decoration: none;}</style></head><body><div class="container"><h1>Windows Server IIS Web 4</h1><p>Welcome to my cool web page!</p><p>Design by Elias De Hondt<br>Copyright &copy; <a class="eliasdh" target="_blank" href="https://eliasdh.com">EliasDH</a><br>All rights Reserved</p></div></body></html>' > C:\shares\web4\index.html

    # Create websites
    New-WebSite -Name "Default Web Site" -PhysicalPath "C:\shares\defaultweb" -Port 80
    New-WebSite -Name "Web2" -PhysicalPath "C:\shares\web2" -Port 8080
    New-WebSite -Name "Web3" -PhysicalPath "C:\shares\web3" -Port 80 -HostHeader "www.elias.org"
    New-WebSite -Name "Web4" -PhysicalPath "C:\shares\web4" -Port 80 -HostHeader "www.dehondt.local"
    New-WebSite -Name "Basic" -PhysicalPath "C:\shares\basic" -Port 8001
    New-WebSite -Name "Windows" -PhysicalPath "C:\shares\windows" -Port 8002

    # Create DNS records
    Add-DnsServerResourceRecordA -Name "www" -ZoneName "elias.org" -IPv4Address "192.168.19.10"
    Add-DnsServerResourceRecordA -Name "www" -ZoneName "dehondt.local" -IPv4Address "192.168.19.10"

    # Create Active Directory user
    New-ADUser -Name "webuser" -AccountPassword (ConvertTo-SecureString "webuser" -AsPlainText -Force) -Enabled $true

    # Create IP and Domain Restrictions
    New-WebConfiguration -Filter "system.webServer/security/ipSecurity" -PSPath "IIS:\Sites\Default Web Site" -Value @{ipAddress="192.168.19.10";allowed="True"}
    ```

## 🔗Links
- 👯 Web hosting company [EliasDH.com](https://eliasdh.com).
- 📫 How to reach us elias.dehondt@outlook.com