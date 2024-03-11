![logo](/Images/logo.png)
# 💙🤍Lab6 Windows Server IIS🤍💙

## 📘Table of Contents

1. [📘Table of Contents](#📘table-of-contents)
2. [🖖Introduction](#🖖introduction)
3. [📝Assignment](#📝assignment)
4. [✨Steps](#✨steps)

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
- Maak een site "Windows" aan op poort 8002 met pad `C:\shares\Windows` en Windows authentication.
- Test uit vanop je host omgeving. 
Kan je nu het paswoord ook decoderen?

8. IP and Domain Restrictions
- Filter je IP adres, zodat je vanuit een andere machine (bv je host of een andere virtuele machine) niet op de default website geraakt (maar wel bv vanop je windows server zelf).
- De andere websites moeten wel toegankelijk blijven voor deze andere machine.

## ✨Steps

### 👉 Step 1: 

## 📦Extra


## 🔗Links
- 👯 Web hosting company [EliasDH.com](https://eliasdh.com).
- 📫 How to reach us eliasdehondt@outlook.com.