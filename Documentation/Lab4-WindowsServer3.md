![logo](/Images/logo.png)
# 💙🤍Lab4 Windows Server 3🤍💙

This is a lab for Windows Server. We will discuss the following items in this lab: Auditing, DFS, Login script.

---

## 📘Table of Contents

1. [Introduction](#introduction)
2. [Assignment](#assignment)
3. [Steps](#steps)

4. [Extra](#extra)
5. [Links](#links)

---

## 🖖Introduction

This lab is about Auditing, DFS, Login script. We will see how to configure the basics of these items. After this lab you will have a basic understanding of these items. And you will be able to configure them in a basic way.

### 📝Assignment 
> NOTE This is in Dutch

 
- DOEL: Auditing, DFS, Login script.
- REF: Windows Server slides op Canvas.

1. Auditing (zie Powerpoint op Canvas)
    - Bekijk de `default Domain Policy` met de `Group Policy Management Editor` terecht.
    - Ga naar Computer Configuration, Policies, Windows Settings, Security Settings, Local Policies, Audit Policy

    - Stel volgende Audit opties is:
        - Audit telkens iemand probeert in te loggen in het domain (onafhankelijk of dit lukt of niet)
        - Audit telkens er wijzigingen gebeuren (create, change, delete) aan accounts (gebruikers en groepen), ook mislukte pogingen tot wijziging dienen gelogd te worden
        - Audit telkens iemand probeert de `Audit policy` te wijzigen (waarom is dit nodig?)

    - Voer volgend commando uit in de shell (wat doen deze?):
        - `Auditpol /set /subcategory:"File System" /success:enable`
        - `Auditpol /set /subcategory:"File System" /failure:enable`

    - Maak in de Server Manager de share `pictures` aan.
    - Activeer Auditing op de share `pictures` met volgende opties (voor alle `Users`):
        - List `folder/read` data Failed
        - Create `files/write` data Successful en Failed
        - Create `folders/append` data Successful en Failed

    - Maak nu via de Event Viewer je Windows Security log leeg.
        - Test uit of het aanmaken van een nieuwe user gelogd wordt.
        - Test uit of het wijzigen van de Audit policy gelogd wordt.
        - Test uit of het copieren van een bestand naar de share een extra lijn in de log geeft.

2. DFS (zoek op het Internet)
    - Maak een DFS `Public` aan (zoek zelf op hoe je dit moet doen).

3. Login script (zoek op het Internet)
    - Maak een `login.bat` bestand aan, dat automatisch de drive `T:` mapt naar de DFS bij het inloggen van een gebruiker.
    - Welk commando plaats je in de `login.bat`?
    - Zoek op waar je dit `login.bat` bestand moet plaatsen zodat het werkt.
    - Wat moet je doen om deze `login.bat` te activeren voor alle gebruikers in het domein (2 mogelijkheden)?

4. Windows 10
    - Installeer Windows 10 in een virtuele machine.
    - Stel de netwerk settings in zodat deze kan communiceren met de Windows Server en ook toegang heeft tot het Internet.
    - Stel de Windows Server in als de DNS server voor de `Windows 10` (voor welke adapter moet je dit doen?)
    - Voeg de Windows 10 machine toe aan jou domain.
    - Log in met user `student1` op Windows 10 en check of de login.bat werkt.
    - Check of de policy instellingen van vorige week werken.

## ✨Steps

### 👉 Step 1: 

## 📦Extra


## 🔗Links
- 👯 Web hosting company [EliasDH.com](https://eliasdh.com).
- 📫 How to reach us eliasdehondt@outlook.com.