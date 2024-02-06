![logo](/Images/logo.png)
# 💙🤍Lab1 Apache🤍💙

This is a lab for Apache server. The goal of this lab is to install and configure an Apache server on a Windows system with a minimal number of activated modules (so as efficiently as possible), and to understand the options of Apache.

---

## 📘Table of Contents

1. [Introduction](#introduction)
2. [Assignment](#assignment)
3. [Steps](#steps)


---

## 🖖Introduction

This is a lab for Apache server. The goal of this lab is to install and configure an Apache server on a Windows system with a minimal number of activated modules (so as efficiently as possible), and to understand the options of Apache. And to understand the options of Apache.

### 📝Assignment 
> NOTE This is in Dutch

NODIG:
- Windows 7,8,...
- Apache server 2.4.x for windows 

DOEL:
- Installeren en configureren van een Apache server op een windows systeem met een minimaal aantal geactiveerde modules (dus zo efficient mogelijk), Begrijpen van de opties van Apache. 

REF:
- http://httpd.apache.org/docs/2.4/mod/directives.html
- http://httpd.apache.org/docs/2.4/mod/
- https://winaero.com/create-symbolic-link-windows-10-powershell/

OPGAVE:

1. Installatie Apache Webserver op Windows:
    - Kijk na of er geen andere web server meer draait. Stop bv. IIS in cmd.exe met: `net stop w3svc`
    - Installeer apache 2.4.x:
        http://httpd.apache.org/docs/2.4/platform/windows.html download Windows httpd van `Apache Lounge` lees de ReadMe voor de installatie! Kies als installatielocatie `c:\apache24` installeer Apache als een service (Zorg er voor dat deze niet telkens automatisch opstart! Hoe?) test met in cmd.exe: `net start apache2.4`

2. Backup originele httpd.conf en opkuisen configuratie:
    Stop de service met: `net stop apache2.4`
    Ga naar de directory `c:/apache24/conf/`
    Hernoem httpd.conf naar httpd.conf.backup
    Maak een nieuw, leeg bestand `c:/apache24/conf/httpd.conf` aan
    Stel nu in je nieuwe `httpd.conf` je `ServerName` in. 
    Deze moet gelijk zijn aan de naam die je terugkrijgt wanneer je in cmd.exe (of powershell.exe) het commando hostname uitvoert.
    Stel als ServerRoot `c:/apache24` in.
    Maak onder ServerRoot een directory web/kdg aan en stel deze in als DocumentRoot


3. Opstartfouten oplossen:
    Probeer de server op te starten in cmd.exe met:
    `c:\apache24\bin\httpd -f c:/apache24/conf/httpd.conf`
    Deze geeft onder andere als fout dat er geen Listening Sockets zijn: Laat de server luisteren op poort 80.
    Start de server opnieuw op
    Surf nu naar `http://127.0.0.1/` in een browser
    Je krijgt de foutmelding "Internal server error"
    Bekijk de logfile, welke foutmelding vind je terug?
    Zoek vie het Internet hoe de deze fout kan oplossen (tip: door het toevoegen van n LoadModule, welke?)
    Bekijk wat deze module doet op de apache website (zie REF 3)
    Na het toevoegen van de LoadModule, stop/start Apache
    `Not Found`  betekent hier dat je server al werkt!

4. Bekijken website:
    Maak een eenvoudig html bestand `web/kdg/index.html` met een persoonlijke tekst.
    Surf naar `http://localhost/index.html`
    Werkt `http://localhost` ook?
    Voeg `DirectoryIndex index.html` toe aan je config file
    Herstart de webserver. Welke foutmelding geeft dit?
    Zoek zelf op via de apache website welke module je hiervoor moet activeren (zie REF 2)
    Voeg deze module toe met LoadModule in je config
    Test nu uit op `http://127.0.0.1`

5. Directory Auto Index:
    Als de HTML niet ge nterpreteerd wordt, dien je de mime module te laden.
    Voeg nu de module autoindex toe.
    Maak onder DocumenRoot een Directory "test" aan en definieer deze als volgt in je httpd.conf
        <Directory C:/apache24/web/kdg/test>
        Options Indexes
        </Directory>
    Bekijk de directory op `http://127.0.0.1/test/`

6. Symbolische link en server info:
    Maak nu een link aan van `c:\apache24\web\kdg\test\link` naar de directory logs in ServerRoot 
    Je kan dit in Powershell doen (zie referentie)
    Zorg dat je links `http://localhost/test/link/` kan gebruiken
    Activeer de module info. Als deze draait, kan je op `http://127.0.0.1/server-info` alle apache instellingen opvragen.
    Bekijk als inspiratie `conf/extra/httpd-info.conf`

7. Port based Virtual hosts:
    Maak een 2de website die beschikbaar is via poort 8080 met als DocumentRoot `c:/apache24/htdocs`
    `http://localhost` en `http://<jou_host_naam>` verwijzen naar `c:/apache24/web/kdg`
    `http://localhost:8080` en `http://<jou_host_naam>:8080` verwijzen naar C:/apache24/htdocs
    Denk eraan dat je apache moet vertellen om op 2 poorten te luisteren!

8. Authenticatie:
    Maak apache accounts student1 en student2 aan. Geef ze hetzelfde paswoord als de gebruikersnaam. 
    Gebruik het bestand `c:/apache24/web/users` om de paswoorden in op te slaan. 
    Stop student1 en student2 in de groep "studenten", dit sla je op in `c:/apache24/web/group`.

    Maak apache accounts docent1 en docent2 aan. Geef ze hetzelfde paswoord als de gebruikersnaam. 
    Stop docent1 en docent2 in de groep "docenten".

    Beveilig je 2de website zodat enkel docenten hierop kunnen (hiervoor moet je de juiste authenticatieinstellingen doorvoeren in de virtual host).
    Laad de juiste modules voor authenticatie in.

9. .htaccess:
    Maak onder DocumenRoot een Directory "test2" aan en plaats hierin een index.html bestand.
    Laat in deze directory enkel een override van authenticatie toe.
    Bekijk de directory op `http://localhost/test2/`
    Plaats nu in deze directory een .htaccess en zorg ervoor dat enkel studenten toegang hebben.
    Test opnieuw met `http://localhost/test2/`
    Heb je hiervoor de webserver moeten herstarten? Waarom wel/niet?

10. UserDir:
    Voorzie de nodige modules voor gebruikersdirectories.
    Zorg ervoor dat alle Windows gebruikers die gedefinieerd zijn op jou PC een eigen website kunnen aanmaken.
    Hiervoor moeten ze een directory "www" aanmaken in hun home directory `c:/Users/<username>/www`. 

11. Redirect:
    Zoek op internet hoe je een redirect kan implementeren in apache. 
    Gebruikers die surfen naar `http://jouw_server/google` moeten automatisch doorgestuurd worden naar `http://google.com` 

12. Op IP filteren:
    Laat enkel de locale machine toe om de server info te bekijken.
    Start een virtuele machine op (Kies in Virtual Box een Host-only netwerk adapter)
    Test of deze virtuele guest machine toegang heeft.

## ✨Steps

### 👉 Step 1:




## 🔗Links
- 👯 Web hosting company [EliasDH.com](https://eliasdh.com).
- 📫 How to reach us eliasdehondt@outlook.com.