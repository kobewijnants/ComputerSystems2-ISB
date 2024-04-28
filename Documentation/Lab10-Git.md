![logo](/Images/logo.png)
# 💙🤍Lab10 Git🤍💙

## 📘Table of Contents

1. [📘Table of Contents](#📘table-of-contents)
2. [🖖Introduction](#🖖introduction)
3. [📝Assignment](#📝assignment)
4. [✨Steps](#✨steps)

---

## 🖖Introduction



### 📝Assignment 
> NOTE This is in Dutch

- NODIG:    
    - Windows Server 2019 met AD
    - Git https://git-scm.com/
	- Server: Gitea https://gitea.io/
- DOEL: Opzetten van een git server

- REF: Git slides (zie Canvas)

1. Installatie van Git laatste versie (64 bit) op een Windows Server met AD:
    - Download van https://git-scm.com/download/win
    - Installeer met de default settings (uitgez.: nano gebruiken, Windows default console gebruiken, Files System Caching en Git Credential Mgr afzetten)
    - Werkt het `git version` commando? Indien niet log uit/in.

2. Installatie van Gitea (64 bit):
    - Download de laatste versie van Gitea en plaats de exe in `C:\Gitea`
    - Hernoem de exe file naar gitea.exe en start deze.
    - Open een web browser en ga naar de Gitea server (welke poort ga je gebruiken?).
    - Voer via de browser de installatiestappen voor de First-Time Run uit:
        - Gebruike SQLite3 neem `C:\Gitea\repo` (maak deze aan) als repository.
        - Maak een 1ste gitea user aan en stop dan Gitea.

3. Installatie van Gitea als Windows service
    - Maak een alias in DNS voor jou Windows server met als naam: `gitea.jou_domein_naam`
    - Zie https://docs.gitea.io/en-us/windows-service/
    - Gebruik de gitea DNS naam die je zopas aangemaakt heb, het corresponderend IP adres en poort `80` (check of deze vrij is!).
        - let op, in Powershell is sc ook een Alias.
        - Zorg ervoor dat deze service manueel start (en niet automatic).
    - Start Gitea nu met het `net start` commando.
    - Open een web browser en test de Gitea server met `http://gitea.jou_domein_naam`

4. Connecteer Gitea met Active Directory
    - Log in met de 1ste gitea user, aangemaakt in punt 2 (deze heeft Admin rechten).
    - Open het `Site Administrator` door rechts bovenaan op de dropdown box te klikken.
    - Kies "Authentication Sources" en dan `Add Authentication Source`.
    - Lees de verklaring op https://docs.gitea.io/en-us/authentication/
        - Gebruik LDAP authenticatie via BindDN.
        - Zoek het juiste poortnummer van Active Directory op!
        - Maak in AD een gebruiker `ldap` aan (met paswoord) onder `Users`, deze gebruiken we om aan te loggen in AD ("Bind DN").
        - Zoek op hoe je de CN, OU, DC syntax gebruikt bij opzoekingen in een LDAP server.
        - Je vindt deze syntax ook terug in ADUC bij Properties->Attribute Editor. Zet in View de Advanced Features aan. 
        - Maak in AD een OU `OUGitea` aan, alle users in deze OU gaan we toelaten om in Gitea in te loggen (zet deze in User Search Base).
        - User Filter: `(&(objectClass=User)(cn=%s))`
    - Maak een user `giteauser` aan in `OUGitea` en test of je hiermee kan inloggen in Gitea.

5. Installeer Git (zie stap 1) nu ook op je host machine
    - Start de Git `CMD`
    - Check de installatie met `git version`
    - Voer de initi le configuratie uit: https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup.
    - Maak een directory `LocalRepos` aan onder je homedirectory.
    - Maak hieronder een directory `Project1` aan en maak hierin een git repository.
    - Maak een tekst file `HelloWorld.java` aan in Project1 en doe `git status`.
    - Voeg deze file toe aan de `Staging area` en doe daarna `git status`.
    - Voeg deze nu toe aan de locale repository en doe daarna `git status` en `git log`.
    - Ga naar `LocalRepo` en voer hierin uit: `git clone https://github.com/mikefrobbins/PowerShell.git`.
    - Voer uit: `git status` en `git log` in deze nieuwe repository.

6. Werken met remote repositories
    - Surf van op je host machine naar de Gitea server en log in met je initi le user.
    - Maak een repository `Project1` aan.
    - Ga in de directory `Project1` in de locale repo.
    - Voer uit: `git remote add origin http://server_ip/your_username/Project1.git`.
    - Check met `git remote -v`.
    - Voer uit: `git push -u origin master`.
    - Surf nu opnieuw naar de remote repository.
    - Zorg ervoor dat `giteauser` in deze repository kan schrijven.

7. Tweede local repository
    - Log aan met `giteauser` op je virtuele Windows 10.
    - Installeer git op deze machine.
    - Doe de initiele git configuratie.
    - Maak een clone van de `Project1` remote repository op je Windows server naar je home directory.
    - Wijzig de `HelloWorld.java` file.
    - Commit de wijzigingen naar de locale repository.
    - Push de wijzigingen naar de remote repository (log aan met `giteauser`).
  
8. Merge repositories
    - Wijzig de `HelloWorld.java` file (op een andere lijn dan in punt 7.) in `LocalRepos\Project1` voer nu git add en git commit uit in Git CMD.
    - Probeer `git push`, lukt dit?
    - Hoe krijg je nu de wijzigingen in de remote repository?
    - Wat zou er gebeuren indien we dezelfde lijn aangepast hadden?






## ✨Steps

### 👉Step 1: 

## 📦Extra


## 🔗Links
- 👯 Web hosting company [EliasDH.com](https://eliasdh.com).
- 📫 How to reach us elias.dehondt@outlook.com