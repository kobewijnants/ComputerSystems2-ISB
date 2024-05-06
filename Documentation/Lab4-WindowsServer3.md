![logo](/Images/logo.png)
# 💙🤍Lab4 Windows Server 3🤍💙

## 📘Table of Contents

1. [📘Table of Contents](#📘table-of-contents)
2. [🖖Introduction](#🖖introduction)
3. [📝Assignment](#📝assignment)
4. [✨Steps](#✨steps)
    1. [👉Step 1: Auditing](#👉step-1-auditing)
    2. [👉Step 2: DFS](#👉step-2-dfs)
    3. [👉Step 3: Login script](#👉step-3-login-script)
    4. [👉Step 4: Windows 10 client](#👉step-4-windows-10-client)
5. [📦Extra](#📦extra)
6. [🔗Links](#🔗links)

---

## 🖖Introduction

This lab is about Auditing, DFS, Login script. We will see how to configure the basics of these items. After this lab you will have a basic understanding of these items. And you will be able to configure them in a basic way.

### 📝Assignment 
> NOTE This is in Dutch

 
- DOEL: Auditing, DFS, Login script.
- REF: Windows Server slides op Canvas.

1. Auditing
    - Bekijk de `default Domain Policy` met de `Group Policy Management Editor` terecht.
    - Ga naar `Computer Configuration` -> `Policies` -> `Windows Settings` -> `Security Settings` -> `Local Policies` -> `Audit Policy`.

    - Stel volgende Audit opties is:
        - Audit telkens iemand probeert in te loggen in het domain (onafhankelijk of dit lukt of niet).
        - Audit telkens er wijzigingen gebeuren (create, change, delete) aan accounts (gebruikers en groepen), ook mislukte pogingen tot wijziging dienen gelogd te worden.
        - Audit telkens iemand probeert de `Audit policy` te wijzigen.

    - Voer volgend commando uit in de shell (wat doen deze?):
        - `Auditpol /set /subcategory:"File System" /success:enable`.
        - `Auditpol /set /subcategory:"File System" /failure:enable`.

    - Maak in de Server Manager de share `pictures` aan.
    - Activeer Auditing op de share `pictures` met volgende opties (voor alle `Users`):
        - List `folder/read` data Failed.
        - Create `files/write` data Successful en Failed.
        - Create `folders/append` data Successful en Failed.

    - Maak nu via de Event Viewer je Windows Security log leeg.
        - Test uit of het aanmaken van een nieuwe user gelogd wordt.
        - Test uit of het wijzigen van de Audit policy gelogd wordt.
        - Test uit of het copieren van een bestand naar de share een extra lijn in de log geeft.

2. DFS
    - Maak een DFS `Public` aan (zoek zelf op hoe je dit moet doen).

3. Login script
    - Maak een `login.bat` bestand aan, dat automatisch de drive `T:` mapt naar de DFS bij het inloggen van een gebruiker.
    - Welk commando plaats je in de `login.bat`?
    - Zoek op waar je dit `login.bat` bestand moet plaatsen zodat het werkt.
    - Wat moet je doen om deze `login.bat` te activeren voor alle gebruikers in het domein?

4. Windows 10 client
    - Installeer `Windows 10` in een virtuele machine.
    - Stel de netwerk settings in zodat deze kan communiceren met de Windows Server en ook toegang heeft tot het Internet.
    - Stel de Windows Server in als de DNS server voor de `Windows 10`.
    - Voeg de `Windows 10` machine toe aan jou domain.
    - Log in met user `student1` op `Windows 10` en check of de `login.bat` werkt.
    - Check of de policy instellingen van vorige week werken.

## ✨Steps

### 👉Step 1: Auditing

> Auditing = The process of tracking changes to an IT environment. This includes changes to hardware, software, and data. Auditing is a critical component of security and compliance.

- Open `Group Policy Management Editor`.
- Go to `Computer Configuration` -> `Policies` -> `Windows Settings` -> `Security Settings` -> `Local Policies` -> `Audit Policy`.
- Set the following Audit options:
    - Audit whenever someone tries to log in to the domain (regardless of whether it is successful or not).
        - Enable `Audit account logon events`. Set to `Success` and `Failure`.
    - Audit whenever changes are made (create, change, delete) to accounts (users and groups), failed attempts to change should also be logged.
        - Enable `Audit account management`. Set to `Success` and `Failure`.
    - Audit whenever someone tries to change the `Audit policy`.
        - Enable `Audit policy change`. Set to `Success` and `Failure`.

- Run the following command in the shell (what do these do?):
    ```powershell
    Auditpol /set /subcategory:"File System" /success:enable # This command enables auditing for the file system. (Default is disabled)
    Auditpol /set /subcategory:"File System" /failure:enable # This command enables auditing for the file system. (Default is disabled)
    ```

- Create the share `pictures` in the `Server Manager`.
    - Create the folder in the `C:\` drive.
        ```powershell
        New-Item -ItemType Directory -Path "C:\shares\pictures"
        ```
    - Share the folder.
        ```powershell
        New-SmbShare -Name "pictures" -Path "C:\shares\pictures" -FullAccess "Everyone"
        ```
- Activate Auditing on the share `pictures` with the following options (for all `Users`):
    - List `folder/read` data Failed.
    - Create `files/write` data Successful and Failed.
    - Create `folders/append` data Successful and Failed.
        - `Right click` on the folder `pictures` -> `Properties` -> `Security` -> `Advanced` -> `Auditing` -> `Add` -> `Principal: Everyone` -> `OK` -> `Type: All` -> `Applies to: This folder, subfolders and files` -> `Show advanced permissions`.
        - Then select only `List folder / read data` and `Create files / write data` and `Create folders / append data` -> `OK` -> `OK` -> `OK`.

> This should be the result.

![x](/Images/Lab4-WindowsServer3-1.png)

- Now empty the Windows Security log via the Event Viewer.
    - Empty the Security log.
        ```powershell
        Clear-EventLog -LogName Security # This command clears the Security log.
        ```
    - Open the Windows Security
        ```powershell
        eventvwr.msc # This command opens the Event Viewer.
        ```
        - Go to `Windows Logs` -> `Security` -> `Clear Log` -> `Clear`.

- Test whether creating a new user is logged.
    - Create a new user.
        ```powershell
        New-LocalUser -Name "testuser" -FullName "Test User" -Description "This is a test user."
        ```
        > Event 4720 should be logged.

- Test whether changing the Audit policy is logged.
    - Change the Audit policy.
        ```powershell
        Auditpol /set /subcategory:"File System" /success:disable
        ```
        > Event 4719 should be logged.

- Test whether copying a file to the share gives an extra line in the log.
    - Copy a file to the share.
        ```powershell
        Copy-Item -Path "C:\Windows\System32\drivers\etc\hosts" -Destination "\\localhost\pictures"
        ```
        > Event 5145 should be logged.

### 👉Step 2: DFS

> DFS = Distributed File System. DFS is a set of client and server services that allow an organization using Microsoft Windows servers to organize many distributed SMB file shares into a distributed file system.

- Install the `DFS` role.
    - Use the `PowerShell` to install the `DFS` role.
        ```powershell
        Install-WindowsFeature -Name FS-DFS-Namespace -IncludeManagementTools # This command installs the DFS role.
        ```
    - Or use the `Server Manager`.
        - `Add roles and features` -> `Next` -> `Role-based or feature-based installation` -> `Next` -> `Select a server from the server pool` -> `Next` -> `File and Storage Services` -> `File and iSCSI Services` -> Select `DFS Namespaces` and `DFS Replication` -> `Next` -> `Install`.

- Create a DFS `Public`.
    - Open the `DFS Management`.
    ```powershell
    dfsmgmt.msc # This command opens the DFS Management.
    ```
    - Right click on `Namespaces` -> `New Namespace`.
    - Enter the `Namespace server`.
        - e.g. `WINSERVER`.
    - Enter the `Namespace name`.
        - e.g. `Public`.
    - Click `Next` -> `Next` -> `Create`.
    - Right click on `Public` -> `New Folder`.
    - Enter the `Folder name`.
        - e.g. `Test`.
    - Click `OK`.

> This should be the result.

![x](/Images/Lab4-WindowsServer3-2.png)

### 👉Step 3: Login script

- Create a `login.bat` file that automatically maps the drive `T:` to the DFS when a user logs in.
    - Open `Notepad`. (`C:\Users\Administrator\Desktop`)
    - Enter the following command.
        ```batch
        net use T: \\WINSERVER\Public\Test
        ```
    - Save the file as `login.bat`.

- Place the `login.bat` file in the `\\WINSERVER\netlogon` folder.
    ```powershell
    Copy-Item -Path "C:\Users\Administrator\Desktop\login.bat" -Destination "\\WINSERVER\netlogon"
    ```

- To activate this `login.bat` for all users in the domain, you must link the `login.bat` to the `Default Domain Policy`.
    - Open the `Group Policy Management Editor`.
    - Go to `User Configuration` -> `Policies` -> `Windows Settings` -> `Scripts (Logon/Logoff)` -> `Logon`.
    - Click `Add` -> `\\WINSERVER\netlogon\login.bat` -> `OK` -> `OK`.

> This should be the result.

![x](/Images/Lab4-WindowsServer3-3.png)

### 👉Step 4: Windows 10 client

- Install `Windows 11` in a virtual machine.
- Set the network settings so that it can communicate with the Windows Server and also has access to the Internet.

![x](/Images/Lab4-WindowsServer3-4.png)

- Set the Windows Server as the DNS server for the `Windows 11`
    - Go to `Network and Sharing Center` -> `Change adapter settings` -> `Properties` -> `Internet Protocol Version 4 (TCP/IPv4)` -> `Properties` -> `Use the following DNS server addresses` -> `Preferred DNS server:
        - e.g. `192.168.19.10`. (IP address of the Windows Server)

- `WINSERVER` NIC settings.
    - NIC 1:
        - Name: `Host-Only-Team`.
        - IP: `192.168.19.10`.
        - Subnet: `255.255.255.0`.
        - Default Gateway: `NULL`.
        - DNS: `127.0.0.1`.
    - NIC 2:
        - Name: `Host-Only1`.
        - Is in a team with `Host-Only-Team`.
    - NIC 3:
        - Name: `Host-Only2`.
        - Is in a team with `Host-Only-Team`.
    - NIC 4:
        - Name: `NAT`.
        - IP: `DHCP`.
        - Subnet: `255.255.255.0`.
        - Default Gateway: `DHCP`.
        - DNS: `DHCP`.

- `Client1` NIC settings.
    - NIC 1:
        - Name: `Host-Only1`.
        - IP: `DHCP`.
        - Subnet: `255.255.255.0`.
        - Default Gateway: `NULL`.
        - DNS: `192.168.19.10`.
    - NIC 2:
        - Name: `NAT`.
        - IP: `DHCP`.
        - Subnet: `255.255.255.0`.
        - Default Gateway: `DHCP`.
        - DNS: `DHCP`.

- Rename the `Client` machine to `Client1`.
    - Open `PowerShell`.
    - Enter the following command.
        ```powershell
        Rename-Computer -NewName "Client1"
        ```
- Restart the `Client` machine.
    - Open `PowerShell`.
    - Enter the following command.
        ```powershell
        Restart-Computer
        ```
- Add the `Client` machine to your domain.
    - Open `PowerShell`.
    - Enter the following command.
        ```powershell
        Add-Computer -DomainName "dehondt.local" -Credential "dehondt\Administrator"
        ```
- Restart the `Client` machine.
    - Open `PowerShell`.
    - Enter the following command.
        ```powershell
        Restart-Computer
        ```
- Log in with user `student1` on `Client1` and check if the `login.bat` works.

> This should be the result.

![x](/Images/Lab4-WindowsServer3-5.png)

- Check if the policy settings from last week work.

> This should be the result.

![x](/Images/Lab4-WindowsServer3-6.png)

## 📦Extra

- Picture of the results.

![x](/Images/Lab4-WindowsServer3-7.png)

- This is a script to create the `login.bat` file and place it in the `\\WINSERVER\netlogon` folder.
    ```powershell
    # Create the login.bat file.
    $loginBat = @"
    net use T: \\WINSERVER\Public\Test
    "@
    $loginBat | Out-File -FilePath "C:\Users\Administrator\Desktop\login.bat"

    # Place the login.bat file in the \\WINSERVER\netlogon folder.
    Copy-Item -Path "C:\Users\Administrator\Desktop\login.bat" -Destination "\\WINSERVER\netlogon"
    ```

- This is a script to create a bunch of users in the `Active Directory` with very plausible credentials. (100 users) And we will also add them to the `Domain Users` group and the `Student` group.
    ```powershell
    # Create 100 users in the Active Directory.
    1..100 | ForEach-Object {
        $username = "student$_"
        $password = "P@ssw0rd$_"
        $fullname = "Student $_"
        $description = "This is student $_."
        $ou = "OU=Students,OU=Users,DC=dehondt,DC=local"
        $user = Get-ADUser -Filter {SamAccountName -eq $username}
        if ($user -eq $null) {
            New-ADUser -Name $username -SamAccountName $username -AccountPassword (ConvertTo-SecureString -AsPlainText $password -Force) -Enabled $true -PasswordNeverExpires $true -Path $ou -Description $description -ChangePasswordAtLogon $false -PassThru
        }
    }

    # Add the users to the Domain Users group and the Student group.
    1..100 | ForEach-Object {
        $username = "student$_"
        Add-ADGroupMember -Identity "Domain Users" -Members $username
        Add-ADGroupMember -Identity "Student" -Members $username
    }
    ```

- Disable ctrl+alt+del in UI.
    - Open `Group Policy Management Editor`.
    - Go to `Computer Configuration` -> `Policies` -> `Windows Settings` -> `Security Settings` -> `Local Policies` -> `Security Options`.
    - Set `Interactive logon: Do not require CTRL+ALT+DEL` to `Enabled`.
    - Restart the `Client` machine.
    
- Disable ctrl+alt+del in PowerShell.
    ```powershell
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "DisableCAD" -Value 1
    Restart-Computer
    ```
    

## 🔗Links
- 👯 Web hosting company [EliasDH.com](https://eliasdh.com).
- 📫 How to reach us elias.dehondt@outlook.com