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
    - Voeg 3 extra IDE(!) schijven van 5GB toe in je virtuele systeem
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
    - Indien je nog geen user `student1` hebt, maak deze aan in OU `OU Studenten` en zorg dat deze lokaal kan aanloggen.
    - We willen er nu voor zorgen dat `student1` niet te veel kan verknoeien op een domaincontroller.
    - Open Group Policy Management, klik rechts op `OU Studenten`
    - Maak een nieuw Group Policy Object aan voor de OU Studenten (geef als naam `Studenten Policy`)
    - Doe volgende wijzigingen aan alle studentenprofielen:

- Zorg dat studenten niet aan de lokale `C:` schijf kunnen (via de file manager)
- Zorg dat studenten geen display settings, achtergronden of screensavers kunnen zetten
- Zorg dat volgende windows applicaties niet mogen gedraaid worden via de file manager: `cmd.exe, powershell.exe`
- Zorg dat de PC geen autoplay uitvoert
- Verwijder die lastige `balonnetjestips`
- Gebruikers mogen niet aan het control panel
- Bij `Ctrl + ALT + DEL` mag paswoord niet veranderd kunnen worden

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

## 📦Extra


## 🔗Links
- 👯 Web hosting company [EliasDH.com](https://eliasdh.com).
- 📫 How to reach us eliasdehondt@outlook.com.