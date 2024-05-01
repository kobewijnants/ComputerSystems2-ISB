![logo](/Images/logo.png)
# 💙🤍Lab10 Git🤍💙

## 📘Table of Contents

1. [📘Table of Contents](#📘table-of-contents)
2. [🖖Introduction](#🖖introduction)
3. [📝Assignment](#📝assignment)
4. [✨Steps](#✨steps)
    1. [👉Step 1: Install Git on the windows AD server](#👉step-1-install-git-on-the-windows-ad-server)
    2. [👉Step 2: Install Gitea on the windows AD server](#👉step-2-install-gitea-on-the-windows-ad-server)
    3. [👉Step 3: Install Gitea as a Windows service](#👉step-3-install-gitea-as-a-windows-service)
    4. [👉Step 4: Connect Gitea with Active Directory](#👉step-4-connect-gitea-with-active-directory)

---

## 🖖Introduction

In this lab we are going to setup a Git server on a Windows Server 2019 machine. We are going to use Gitea as our Git server. We are going to connect Gitea to Active Directory and we are going to create a repository and push some code to it. We are also going to clone the repository on a Windows 10 machine and push some code to it. We are going to merge the repositories and see what happens when we try to push the same file with different changes to the remote repository.

### 📝Assignment 
> NOTE This is in Dutch

- NODIG:    
    - Windows Server 2019 met AD
    - Git https://git-scm.com
	- Server: Gitea https://gitea.io
    - Gitea Docs: https://docs.gitea.io/en-us/windows-service
- DOEL: Opzetten van een git server

- REF: Git slides (zie Canvas)

1. Installatie van Git laatste versie (64 bit) op een Windows Server met AD:
    - Download van https://git-scm.com/download/win
    - Installeer met de default settings (uitgez.: nano gebruiken, Windows default console gebruiken, Files System Caching en Git Credential Mgr afzetten)
    - Werkt het `git version` commando? Indien niet log uit/in.

2. Installatie van Gitea (64 bit):
    - Download de laatste versie van Gitea en plaats de exe in `C:\Gitea`
    - Hernoem de `.exe` file naar `gitea.exe` en start deze.
    - Open een web browser en ga naar de Gitea server.
    - Voer via de browser de installatiestappen voor de First-Time Run uit:
        - Gebruike `SQLite3` neem `C:\Gitea\repo` als repository.
        - Maak een 1ste gitea user aan en stop dan Gitea.

3. Installatie van Gitea als Windows service
    - Maak een alias in DNS voor jou Windows server met als naam: `gitea.jou_domein_naam`
    - Gebruik de gitea DNS naam die je zopas aangemaakt heb, het corresponderend IP adres en poort `80`.
        - Let op, in Powershell is `sc` ook een Alias.
        - Zorg ervoor dat deze service manueel start (en niet automatic).
    - Start Gitea nu met het `net start` commando.
    - Open een web browser en test de Gitea server met `http://gitea.jou_domein_naam`

4. Connecteer Gitea met Active Directory
    - Log in met de 1ste gitea user, aangemaakt in punt 2 (deze heeft Admin rechten).
    - Open het `Site Administrator` door rechts bovenaan op de dropdown box te klikken.
    - Kies "Authentication Sources" en dan `Add Authentication Source`.
    - Lees de verklaring op https://docs.gitea.io/en-us/authentication
        - Gebruik LDAP authenticatie via BindDN.
        - Zoek het juiste poortnummer van Active Directory op!
        - Maak in AD een gebruiker `ldap` aan (met paswoord) onder `Users`, deze gebruiken we om aan te loggen in AD ("Bind DN").
        - Zoek op hoe je de CN, OU, DC syntax gebruikt bij opzoekingen in een LDAP server.
        - Je vindt deze syntax ook terug in ADUC bij Properties->Attribute Editor. Zet in View de Advanced Features aan. 
        - Maak in AD een OU `OUGitea` aan, alle users in deze OU gaan we toelaten om in Gitea in te loggen (zet deze in User Search Base).
        - User Filter: `(&(objectClass=User)(cn=%s))`
    - Maak een user `giteauser` aan in `OUGitea` en test of je hiermee kan inloggen in Gitea.

5. Installeer Git nu ook op je host machine
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

### 👉Step 1: Install Git on the windows AD server

- Download the latest version of Git from [here](https://github.com/git-for-windows/git/releases/download/v2.45.0.windows.1/Git-2.45.0-64-bit.exe).
- Install Git with the default settings.
    - Use nano as the default editor.
    - Use the Windows default console.
    - Disable File System Caching and Git Credential Manager.
- Check if the git version command works:
    ```powershell
    git version # Or git -v
    ```
- Remove git executable from the downloads folder.
    ```powershell
    Remove-Item -Path "C:\Users\Administrator\Downloads\Git-2.45.0-64-bit.exe"
    ```

### 👉Step 2: Install Gitea on the windows AD server

- Download the latest version of Gitea from [here](https://dl.gitea.com/gitea/1.21.4/gitea-1.21.4-gogit-windows-4.0-amd64.exe).
- Create a new directory
    ```powershell
    New-Item -Path "C:\Gitea" -ItemType Directory # Create a new directory for Gitea
    New-Item -Path "C:\Gitea\repo" -ItemType Directory # Create a new directory for the repositories
    ```
- Move and rename the Gitea executable to the Gitea directory.
    ```powershell
    Move-Item -Path "C:\Users\Administrator\Downloads\gitea-1.21.4-gogit-windows-4.0-amd64.exe" -Destination "C:\Gitea\gitea.exe"
    ```
- Start the Gitea executable.
    ```powershell
    Start-Process -FilePath "C:\Gitea\gitea.exe"
    ```
- Open a web browser and go to the Gitea server [Gitea Server](http://localhost:3000).
- Follow the installation steps for the First-Time Run:
    | Field                  | Value                  |
    | ---------------------- | ---------------------- |
    | Database Type          | SQLite3                |
    | Path                   | C:\Gitea\data\gitea.db |
    | Site Title             | Gitea - DEHONDT        |
    | Repository Root Path   | C:\Gitea\repo          |
    | Git LFS Root Path      | C:\Gitea\data\lfs      |
    | Run As Username        | Administrator          |
    | Server Domain          | localhost              |
    | SSH Server Port        | 22                     |
    | Gitea HTTP Listen Port | 3000                   |
    | Gitea Base URL         | http://localhost:3000/ |
    | Log Path               | C:\Gitea\log           |
    | Enable Update Checkers | Unchecked              |
- Press the `Install Gitea` button.
- Press the `Register Account` button.
    | Field       | Value       |
    | ----------- | ----------- |
    | Username    | root        |
    | Email       | root@root   |
    | Password    | root123'    |
    | Confirm     | root123'    |
- Stop the Gitea server.
    ```powershell
    Stop-Process -Name "gitea"
    ```

### 👉Step 3: Install Gitea as a Windows service

- Create an alias in DNS for your Windows server with the name: `gitea.dehondt.local`.
    ```powershell
    # The "-Name" parameter should be "gitea"
    # The "-ZoneName" parameter should be "last_name.local"
    # The "-IPv4Address" parameter should be the IP address of the Windows server
    Add-DnsServerResourceRecordA -Name "gitea" -ZoneName "dehondt.local" -IPv4Address "192.168.70.136"
    ```
- Install Gitea as a Windows service. (Port `80` is not available due to the ISS service so use port 3000`)
    ```powershell
    # The "-ServiceName" parameter should be "gitea"
    # The "-DisplayName" parameter should be "Gitea"
    # The "-BinaryPathName" parameter should be "C:\Gitea\gitea.exe web --config C:\Gitea\custom\conf\app.ini"
    # The "-Description" parameter should be "Gitea Git Server"
    # The "-StartupType" parameter should be "Manual"
    New-Service -Name "gitea" -DisplayName "Gitea" -BinaryPathName "C:\Gitea\gitea.exe web --config C:\Gitea\custom\conf\app.ini" -Description "Gitea Git Server" -StartupType Manual -Port 3000
    ```
- Remove the Windows service.
    ```powershell
    Remove-Service -Name "gitea"
    ```
- Start the Gitea service.
    ```powershell
    Start-Service -Name "gitea" # Or net start gitea
    Stop-Service -Name "gitea" # Or net stop gitea
    ```
- Open a web browser and test the Gitea server with [Gitea Server](http://gitea.dehondt.local:3000).

- For external access, you need to open the port `3000` on the Windows firewall.
    ```powershell
    New-NetFirewallRule -DisplayName "Allow Gitea Port 3000" -Direction Inbound -Protocol TCP -LocalPort 3000 -Action Allow
    ```

### 👉Step 4: Connect Gitea with Active Directory

- Log in with the root user created in [Step 2](#👉step-2-install-gitea-on-the-windows-ad-server)
- Open the `Site Administration` by clicking on the dropdown box in the top right corner.
- Choose `Identity & Access` and then `Authentication Sources`.
- Click on the `Add Authentication Source` button.
- Configure the new authentication source:
    | Field                | Value                                |
    | -------------------- | ------------------------------------ |
    | Authentication Type  | LDAP (via BindDN)                    |
    | Authentication Name  | AD                                   |
    | Security Protocol    | Unencrypted                          |
    | Host                 | dehondt.local                        |
    | Port                 | 389                                  |
    | Bind DN              | CN=ldap,CN=Users,DC=dehondt,DC=local |
    | Bind Password        | ldap123'                             |
    | User Search Base     | OU=OUGitea,DC=dehondt,DC=local       |
    | User Filter          | (&(objectClass=User)(cn=%s))         |
    | Admin Filter         | (&(objectClass=User)(cn=%s))         |
    | Username Attribute   | sAMAccountName                       |
    | First Name Attribute | givenName                            |
    | Surname Attribute    | sn                                   |
    | Email Attribute      | mail                                 |
    | Public Key Attribute | sshPublicKey                         |
    | Avatar Attribute     | jpegPhoto                            |
    | Enable LDAP group    | Unchecked                            |
    | Use Page Search      | Unchecked                            |
    | Skip local 2FA       | Unchecked                            |
- Create a user AD user `ldap` with the password `ldap123'` in the `Users` container.
    ```powershell
    New-ADUser -Name "ldap" -AccountPassword (ConvertTo-SecureString "ldap123'" -AsPlainText -Force) -Enabled $true -Path "CN=Users,DC=dehondt,DC=local"
    ```
- Create an OU `OUGitea` in the `dehondt.local` domain.
    ```powershell
    New-ADOrganizationalUnit -Name "OUGitea" -Path "DC=dehondt,DC=local"
    ```
- Create a user `giteauser` in the `OUGitea` OU.
    ```powershell
    New-ADUser -Name "giteauser" -AccountPassword (ConvertTo-SecureString "gitea123'" -AsPlainText -Force) -Enabled $true -Path "OU=OUGitea,DC=dehondt,DC=local"
    ```
- Test if you can log in with the `giteauser` user.
    - Username: `giteauser`
    - Password: `gitea123'`

> **NOTE:** OU = Organizational Unit, DC = Domain Component, CN = Common Name

### 👉Step 5: Install Git on the host machine

- Install Git on the host machine by downloading the latest version from [here](https://github.com/git-for-windows/git/releases/download/v2.45.0.windows.1/Git-2.45.0-64-bit.exe).
- Check if the git version command works  (***Not necessary if you have already configured Git***): 
    ```powershell
    git version # Or git -v
    ```
- Configure the initial Git settings (***Not necessary if you have already configured Git***).
    ```powershell
    git config --global user.name "giteauser"
    git config --global user.email "giteauser@localhost.local"
    ```
- Create a directory `LocalRepos` under your home directory.
    ```powershell
    New-Item -Path "$env:USERPROFILE\LocalRepos" -ItemType Directory
    ```
- Create a directory `Project1` under the `LocalRepos` directory.
    ```powershell
    New-Item -Path "$env:USERPROFILE\LocalRepos\Project1" -ItemType Directory
    ```
- Create a text file `HelloWorld.java` in the `Project1` directory.
    ```powershell
    New-Item -Path "$env:USERPROFILE\LocalRepos\Project1\HelloWorld.java" -ItemType File
    ```
- Check the status of the Git repository.
    ```powershell
    cd "$env:USERPROFILE\LocalRepos\Project1"
    git init
    git status
    ```
- Add the file to the staging area.
    ```powershell
    git add HelloWorld.java
    git status
    ```
- Commit the file to the local repository.
    ```powershell
    git commit -m "Add HelloWorld.java file"
    git status
    git log
    ```
- Go to the `LocalRepos` directory and clone the `PowerShell` repository.
    ```powershell
    cd "$env:USERPROFILE\LocalRepos"
    git clone https://github.com/mikefrobbins/PowerShell.git
    ```
- Check the status of the cloned repository.
    ```powershell
    cd "$env:USERPROFILE\LocalRepos\PowerShell"
    git status
    git log
    ```

### 👉Step 6: Working with remote repositories

- Go to the Gitea server and log in with your initial user. In my case [Gitea Server](http://192.168.70.136:3000).

![x](/Images/Lab10-Git-1.png)
    
- Create a repository `Project1`.
> The only thing you need to fill out in the form is the name of the repository, the rest is default.

![x](/Images/Lab10-Git-2.png)

- Go to the `Project1` directory in the local repository.
    ```powershell
    cd "$env:USERPROFILE\LocalRepos\Project1"
    ```
- Add the remote repository to the local repository.
    ```powershell
    git remote add origin http://192.168.70.136:3000/root/Project1.git
    git remote -v
    ```
- Add code to the [HelloWorld.java](/Documentation/Scripts/HelloWorld.java) file.
    ```java
    /*
    * @author Elias De Hondt
    * @see https://eliasdh.com
    * @since 01/05/2024
    */

    // Package
    package Documentation.Scripts;

    // Class
    public class HelloWorld {
        public static void main(String[] args) {
            System.out.println("Hello world, Elias De hondt.");
        }
    }
    ```
- Add the file to the staging area.
    ```powershell
    git add HelloWorld.java
    git status
    ```
- Commit the file to the local repository.
    ```powershell
    git commit -m "Add HelloWorld.java file"
    git status
    ```
- Push the file to the remote repository.
    ```powershell
    git push -u origin master
    ```

[x](/Images/Lab10-Git-3.png)
> If you get this prompt, just sign in with the `root` user.

- Go to the remote repository and make sure that the push was successful.

![x](/Images/Lab10-Git-4.png)

- Add the `giteauser` to the repository so that it can write to it.
    - Go to the repository settings.
    - Click on the `Collaboration` tab.
    - Add the `giteauser` to the repository.

![x](/Images/Lab10-Git-5.png)

### 👉Step 7: Second local repository

- Log in with the `giteauser` on your Windows 10/11 machine.
- Install Git on the host machine by downloading the latest version from [here](https://github.com/git-for-windows/git/releases/download/v2.45.0.windows.1/Git-2.45.0-64-bit.exe).
- Check if the git version command works  (***Not necessary if you have already configured Git***): 
    ```powershell
    git version # Or git -v
    ```
- Remove git executable from the downloads folder.
    ```powershell
    Remove-Item -Path "C:\Users\Administrator\Downloads\Git-2.45.0-64-bit.exe"
    ```
- Configure the initial Git settings (***Not necessary if you have already configured Git***).
    ```powershell
    git config --global user.name "giteauser"
    git config --global user.email "giteauser@localhost.local"
    git config --global user.password "gitea123'"
    ```
- Clone the `Project1` remote repository to your home directory.
    ```powershell
    cd "$env:USERPROFILE"
    git clone http://gitea.dehondt.local:3000/root/Project1.git
    ```
- Change the `HelloWorld.java` file.
    ```java
    /*
    * @author Elias De Hondt
    * @see https://eliasdh.com
    * @since 01/05/2024
    */

    // Package
    package Documentation.Scripts;

    // Class
    public class HelloWorld {
        public static void main(String[] args) {
            System.out.println("Hello world, Elias De hondt. This is the second local repository.");
        }
    }
    ```
- Add the file to the staging area.
    ```powershell
    git add HelloWorld.java
    git status
    ```
- Commit the file to the local repository.
    ```powershell
    git commit -m "Add HelloWorld.java file"
    git status
    ```
- Push the file to the remote repository.
    ```powershell
    git push # If still necessary signing with web UI and try again.
    ```
- Log in with the `giteauser` on the Gitea server and check if the push was successful.

### 👉Step 8: Merge repositories

- Open the `HelloWorld.java` file in notepad and change the text.
    ```powershell
    notepad "$env:USERPROFILE\LocalRepos\Project1\HelloWorld.java"
    ```
- Change the `HelloWorld.java` file in the `LocalRepos\Project1` directory.
    ```java
    /*
    * @author Elias De Hondt
    * @see https://eliasdh.com
    * @since 01/05/2024
    */

    // Package
    package Documentation.Scripts;

    // Class
    public class HelloWorld {
        public static void main(String[] args) {
            System.out.println("Hello world, Elias De hondt. This is the second local repository.");
        }
        public void frustra() {
            a = 1;
            b = 2;
            c = a + b;
            System.out.println("The sum of a and b is: " + c);
        }
    }
    ```
- Add the file to the staging area.
    ```powershell
    git add HelloWorld.java
    git status
    ```
- Commit the file to the local repository.
    ```powershell
    git commit -m "Add HelloWorld.java file"
    git status
    ```
- Try to push the file to the remote repository.
    ```powershell
    git push
    ```

![x](/Images/Lab10-Git-6.png)

- Options:
    1. Merge the changes locally and then push the changes to the remote repository. (Recommended)
        ```powershell
        git pull
        git push
        ```
    2. Force push the changes to the remote repository. (Not recommended)
        ```powershell
        git push -f
        ```
    4. Revert the changes and then push the changes to the remote repository. (Not recommended)
        ```powershell
        git reset --hard
        git push -f
        ```

## 📦Extra

- This is a list of all useful Git commands:
    ```powershell
    git --version                                                           # Check the Git version
    git config --list                                                       # List all the Git configurations
    git config --global user.name "giteauser"                               # Set the global Git username
    git config --global user.email "giteauser@localhost.local"              # Set the global Git email
    git config --global user.password "gitea123'"                           # Set the global Git password
    git init                                                                # Initialize a new Git repository
    git status                                                              # Check the status of the Git repository
    git add HelloWorld.java                                                 # Add the file to the staging area
    git commit -m "Add HelloWorld.java file"                                # Commit the file to the local repository
    git log                                                                 # Show the commit log
    git clone https://github.com/EliasDeHondt/ComputerSystems2-ISB.git      # Clone a remote repository
    ```

- This is a list of all useful Gitea commands:
    ```powershell
    gitea --version                                                         # Check the Gitea version
    gitea web --config C:\Gitea\custom\conf\app.ini                         # Start the Gitea server
    ```
- This is a list of all useful Active Directory commands:
    ```powershell
    Get-ADUser -Filter *                                                    # Get all the AD users
    Get-ADUser -Identity "ldap"                                             # Get the AD user with the identity "ldap"
    New-ADUser -Name "ldap" -AccountPassword (ConvertTo-SecureString "ldap123'" -AsPlainText -Force) -Enabled $true -Path "CN=Users,DC=dehondt,DC=local"
    New-ADOrganizationalUnit -Name "OUGitea" -Path "DC=dehondt,DC=local"
    New-ADUser -Name "giteauser" -AccountPassword (ConvertTo-SecureString "gitea123'" -AsPlainText -Force) -Enabled $true -Path "OU=OUGitea,DC=dehondt,DC=local"
    ```
- This is a list of all useful DNS commands:
    ```powershell
    Add-DnsServerResourceRecordA -Name "gitea" -ZoneName "dehondt.local" -IPv4Address "
    ```
- This is a list of all useful Windows service commands:
    ```powershell
    New-Service -Name "gitea" -DisplayName "Gitea" -BinaryPathName "C:\Gitea\gitea.exe web --config C:\Gitea\custom\conf\app.ini" -Description "Gitea Git Server" -StartupType Manual -Port 3000
    Remove-Service -Name "gitea"
    Start-Service -Name "gitea"
    Stop-Service -Name "gitea"
    ```
- This is a list of all useful Windows firewall commands:
    ```powershell
    New-NetFirewallRule -DisplayName "Allow Gitea Port 3000" -Direction Inbound -Protocol TCP -LocalPort 3000 -Action Allow
    ```


## 🔗Links
- 👯 Web hosting company [EliasDH.com](https://eliasdh.com).
- 📫 How to reach us elias.dehondt@outlook.com