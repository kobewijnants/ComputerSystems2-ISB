![logo](/Images/logo.png)
# 💙🤍Lab3 Windows Server 2🤍💙

This is a lab for Windows Server. We will discuss the following items in this lab: NIC Teaming, Storage Spaces and Group Policies.

---

## 📘Table of Contents

1. [Introduction](#introduction)
2. [Assignment](#assignment)
3. [Steps](#steps)

4. [Extra](#extra)
5. [Links](#links)

---

## 🖖Introduction

This lab is about NIC Teaming, Storage Spaces and Group Policies. We will see how to configure the basics of these items. After this lab you will have a basic understanding of these items. And you will be able to configure them in a basic way.

### 📝Assignment 
> NOTE This is in Dutch

- DOEL: NIC Teaming, Storage spaces en Group Policies.
- REF: Windows Server slides op Canvas.

1. NIC teaming
    - Maak een nieuw virtueel Host-Only netwerk aan in VMWare.
    - Zorg dat in het netwerk automatisch adressen worden uitgedeeld.
    - Voeg 2 extra `Host-Only` adapters toe in je virtuele systeem met dat nieuwe netwerk.
    - Combineer deze 2 netwerkadapters met NIC teaming (Switch Independent/Address Hash).
    - Verwijder nadien dit team, de extra adapters en het nieuwe Host-Only netwerk.

2. Storage spaces
    - Voeg 3 extra IDE(!) schijven van 5GB toe in je virtuele systeem.
    - Maak een storage pool aan met deze 3 schijven. De laatste schijf gebruik je als hot spare.
    - Maak een virtuele disk op deze storage pool (mirrored).
    - Maak dan een nieuw Volume aan met deze virtuele schijf.
    - Copieer een bestand naar je nieuwe schijf.
    - Schakel je VM uit en verwijder de eerste schijf.
    - Test uit of je na heropstarten je bestand nog kan zien.
    - Verwijder nadien de storage space.

3. Activeer de Recycle Bin in Active Directory
    - Test uit of je, na het verwijderen van de `cisco` account, deze opnieuw kan herstellen vanuit de recycle bin.

4. Group Policies
    - We willen er nu voor zorgen dat `student1` niet te veel kan verknoeien op een domaincontroller.
    - Open `Group Policy Management`, klik rechts op `Studenten`.
    - Maak een nieuw `Group Policy Object` aan voor de `Studenten` (geef als naam `Studenten Policy`).
    - Doe volgende wijzigingen aan alle studentenprofielen:
        - Zorg dat studenten niet aan de lokale `C:` schijf kunnen (via de file manager).
        - Zorg dat studenten geen display settings, achtergronden of screensavers kunnen zetten.
        - Zorg dat volgende windows applicaties niet mogen gedraaid worden via de file manager: `cmd.exe, powershell.exe`.
        - Zorg dat de PC geen autoplay uitvoert.
        - Verwijder die lastige `balonnetjestips`.
        - Gebruikers mogen niet aan het control panel.
        - Bij `Ctrl + ALT + DEL` mag paswoord niet veranderd kunnen worden.

## ✨Steps

### 👉 Step 1: NIC Teaming

- Add a new network cards VMWare.

![logo](/Images/Lab3-WindowsServer2-1.png)

![logo](/Images/Lab3-WindowsServer2-2.png)

> This should be the result.

![logo](/Images/Lab3-WindowsServer2-3.png)

- Combine the two network cards in Windows Server.
    - Go to `Server Manager`.
    - Click on `Local Server`.
    - Click on `Disabled` next to `NIC Teaming`.
    - Click on `Tasks` and then `New Team`. (In `Teams`).
    - Select the network cards you want to combine.
    - Give the team a name and click `OK`. (I named it `Host-Only-Team`).
    - Go to additional properties and select `Switch Independent` and `Address Hash`.
    - Click on `OK`.

> This should be the result.

![logo](/Images/Lab3-WindowsServer2-4.png)

- Remove the team, the network cards and the network.
    - Go to `Server Manager`.
    - Click on `Local Server`.
    - Click on `Enabled` next to `NIC Teaming`.
    - Click on `Tasks` and then `Delete Team`. (In `Teams`).
    - Select the team and click `OK`.
    - Go to `Network Connections`.
    - Right click on the network cards and click `Delete`.
    - Go to `Server Manager`.
    - Click on `Local Server`.
    - Click on `Disabled` next to `NIC Teaming`.

### 👉 Step 2: Storage Spaces

- Add 3 extra IDE drives in VMWare. (5GB each).

![logo](/Images/Lab3-WindowsServer2-5.png)

![logo](/Images/Lab3-WindowsServer2-6.png)

![logo](/Images/Lab3-WindowsServer2-7.png)

- Create a storage pool with these 3 drives. The last drive is used as a hot spare.
    - Go to `Server Manager`.
    - Click on `File and Storage Services`.
    - Click on `Storage Pools`.
    - Click on `Tasks` and then `New Storage Pool`. (In `Storage Pools`).
    - Click on `Next`.
    - Name the storage pool and click `Next`. (I named it `StoragePool`).
    - Select the drives and click `Next`. (I selected all 3 drives).
    - The first drive is used as a hot spare.
        - Click on `Allocation` and then `Hot Spare`.
    - Click `Next` and then `Create`.

> This should be the result.

![logo](/Images/Lab3-WindowsServer2-8.png)

- Create a virtual disk on this storage pool (mirrored).
    - Go to `Server Manager`.
    - Click on `File and Storage Services`.
    - Click on `Storage Pools`.
    - Click on `Tasks` and then `New Virtual Disk`. (In `Virtual Disks`).
    - Select the storage pool and click `OK`.
    - Click `Next`.
    - Name the virtual disk and click `Next`. (I named it `VirtualDisk`).
    - Click `Next`.
    - Select `Mirrored` and click `Next`.
    - Select `Fixed` and click `Next`.
    - Select `Maximum size` and click `Next`.
    - Click `Create`.

> This should be the result.

![logo](/Images/Lab3-WindowsServer2-9.png)

- Create a new Volume with this virtual disk.
    - Go to `Server Manager`.
    - Click on `File and Storage Services`.
    - Click on `Volumes`.
    - Click on `Tasks` and then `New Volume`. (In `Volumes`).
    - Click `Next`.
    - Select the virtual disk and click `Next`.
    - Click `Next`.
    - Select Drive Letter `E:` and click `Next`.
    - Select `NTFS` and name the volume `Volume` and click `Next`.
    - Click `Create`.

> This should be the result.

![logo](/Images/Lab3-WindowsServer2-10.png)

- To undo the steps we did above, simply do it in reverse.

### 👉 Step 3: Recycle Bin in Active Directory

- Enable the Recycle Bin in Active Directory.
    - Open `Active Directory Administrative Center`.
    - Right click on the domain and click `Enable Recycle Bin`.
    - Click `OK`.

- Test if you can restore the `cisco` account after deleting it.
    - Delete the `cisco` account. 
        - Go to `Active Directory Users and Computers`.
        - Go to `domain` and then `Users`. Or in my case `Admins` and then `Users`.
        - Right click on the `cisco` account and click `Delete`.
    - Restore the `cisco` account.
        - Go to `Active Directory Administrative Center`.
        - Click on `Deleted Objects`.
        - Right click on the `cisco` account and click `Restore`.

![logo](/Images/Lab3-WindowsServer2-11.png)

### 👉 Step 4: Group Policies

- Create group policy object.
    - Go to `Group Policy Management`.
    - Right click on `Studenten` and click `Create a GPO in this domain, and Link it here...`.
    - Name the GPO `Studenten Policy`.
    - Click on `OK`.

- Make changes to the student profiles.
    - Hide `C` disk.
        - Go to `Group Policy Management`.
        - Click on `Studenten Policy`.
        - Right click on `Studenten Policy` and click `Edit`.
        - Go to `User Configuration` and then `Policies` and then `Administrative Templates`.
        - Go to `Windows Components` and then `File Explorer`.
        - Enable `Hide these specified drives in My Computer`.
        - Select `Restrict C drives only` and click `OK`.
    - Disable backgrounds and screensavers settings.
        - Go to `Group Policy Management`.
        - Click on `Studenten Policy`.
        - Right click on `Studenten Policy` and click `Edit`.
        - Go to `User Configuration` and then `Policies` and then `Administrative Templates`.
        - Go to `Control Panel` and then `Personalization`.
        - Enable `Prevent changing color and appearance`.
        - Enable `Prevent changing desktop background`.
        - Enable `Prevent changing desktop icons`.
        - Enable `Prevent changing mouse pointers`.
        - Enable `Prevent changing screen saver`.
    - Disable display settings.
        - Go to `Group Policy Management`.
        - Click on `Studenten Policy`.
        - Right click on `Studenten Policy` and click `Edit`.
        - Go to `User Configuration` and then `Policies` and then `Administrative Templates`.
        - Go to `Control Panel` and then `Display`.
        - Enable `Disable the Display Control Panel`.
        - Enable `Hide Settings tab`.
    - Disable `cmd.exe` and `powershell.exe`.
        - Go to `Group Policy Management`.
        - Click on `Studenten Policy`.
        - Right click on `Studenten Policy` and click `Edit`.
        - Go to `User Configuration` and then `Policies` and then `Administrative Templates`.
        - Go to `System` and then `Don't run specified Windows applications`.
        - Enable `Don't run specified Windows applications`.
        - Add `cmd.exe` and `powershell.exe`.
    - Disable autoplay.
        - Go to `Group Policy Management`.
        - Click on `Studenten Policy`.
        - Right click on `Studenten Policy` and click `Edit`.
        - Go to `User Configuration` and then `Policies` and then `Administrative Templates`.
        - Go to `Windows Components` and then `AutoPlay Policies`.
        - Enable `Turn off Autoplay`.
    - Disable balloon tips.
        - Go to `Group Policy Management`.
        - Click on `Studenten Policy`.
        - Right click on `Studenten Policy` and click `Edit`.
        - Go to `User Configuration` and then `Policies` and then `Administrative Templates`.
        - Go to `Start Menu and Taskbar`.
        - Enable `Turn off all balloon notifications`.
    - Disable control panel.
        - Go to `Group Policy Management`.
        - Click on `Studenten Policy`.
        - Right click on `Studenten Policy` and click `Edit`.
        - Go to `User Configuration` and then `Policies` and then `Administrative Templates`.
        - Go to `Control Panel`.
        - Enable `Prohibit access to Control Panel and PC settings`.
    - Disable `Ctrl + ALT + DEL` password change.
        - Go to `Group Policy Management`.
        - Click on `Studenten Policy`.
        - Right click on `Studenten Policy` and click `Edit`.
        - Go to `User Configuration` and then `Policies` and then `Administrative Templates`.
        - Go to `System` and then `Ctrl + ALT + DEL Options`.
        - Enable `Remove Change Password`.

## 📦Extra

- You can also do this lab in a different way. You can also use PowerShell to do this lab. This is a good way to learn PowerShell.

## 🔗Links
- 👯 Web hosting company [EliasDH.com](https://eliasdh.com).
- 📫 How to reach us eliasdehondt@outlook.com.