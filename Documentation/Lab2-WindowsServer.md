![logo](/Images/logo.png)
# 💙🤍Lab1 Windows Server🤍💙



---

## 📘Table of Contents

1. [Introduction](#introduction)
2. [Assignment](#assignment)
3. [Steps](#steps)



---

## 🖖Introduction



### 📝Assignment 
> NOTE This is in Dutch

- DOEL: Basis Configuratie van een Windows 2022 server.
- REF: Windows Server slides op Canvas.

0. INSTALLATIE
    - Download Windows Server 2022 64-bit (English) van Microsoft DreamSpark.
    - Installeer deze in VirtualBox (met Dekstop Experience).
    - Maak hiervan een Kloon in VirtualBox.

1. ALGEMENE INSTELLINGEN
    - Let op dat je eerst volgende instellingen aanpast bij je virtuele machine:
        - Extra netwerkkaart toevoegen in je virtuele machine (1 NAT + 1 host-only, waarom?).
        - Verander de naam van de server naar WINSERVER via Sever Manager -> Local Server.
        - Geef de host-only adapter (waarom deze en niet de NAT adapter?) een vast IP adres (waarom?) kies het adres rekening houdend met de DHCP range van het host-only netwerk in VirtualBox (waarom?).
        - De Folder settings aanpassen zodat je alle extensies ziet.

2. INSTALLATIE AD EN DNS
    - Start de server manager op.
    - Installeer volgende Roles:
        - Active Directory Domain Services, DNS server.
        - Voer de post-deployment configuratie uit: promote server to domain controller (new forest).
        - Kies als domein naam jouw_achternaam.local  (bv vandeputte.local).

3. OPSTARTEN CONSOLE EN ACTIVE DIRECTORY
    - Start "Group Policy Management" (via Server Manager -> Tools).
	    - Klik in de linkerkolom de Forest en Domains open.
	    - Ga bij jou domain name (bv vandeputte.local) op "Default Domain Policy" staan.
	    - Klik hierop met rechtermuisknop.
	    - Bekijk nu de "default Domain Policy" door "Edit" te kiezen.
	    - Je komt in de Group Policy Management Editor terecht.
    - Group Policy Management Editor:
        - Ga naar Computer Configuration, Policies, Windows Settings en Security Settings.
        - Zorg hier dat gebruikers ook als paswoord gewoon hun gebruikersnaam kunnen ingeven.
        - Dus een eenvoudig paswoord zonder al te veel vereisten.
    - Ga nu naar AD Users and Computers (via Server Manager -> Tools).
        - Probeer hier een copy te doen van het administrator account.
        - Als login naam en paswoord geef je cisco in.
        - Als het systeem een melding geeft, gebruik je het commando "gpupdate /force".
        - Test of je met de user cisco kan inloggen.

4. AANMAAK OU EN USERS
    - Ga terug staan op je domain name (bv vandeputte.local). Rechtermuisklik op Domain Name en kies New Organizational Unit (OU).
    - Maak volgende structuur rechtermuiskliksgewijze aan:
        - OU Admins met user cisco.
        - OU Docenten met user docent1 .
        - OU Studenten met sub OU's INF1 en INF2 met users student1 en student2 respectievelijk. 
    - Vergelijk gebruik ADUC (Active Directory Users and Computers) en ADAC (Server Manager -> Tools Menu -> Active Directory Administration Center).

5. AANMAAK SHARES
    - Maak een group "StudentenGroep" en "DocentenGroep" (Global, Security) aan in de resp. OU's, waarin alle studenten/docenten zitten.
    - Maak volgende shares aan op de server. (Geef Domain Administrators telkens Full Control):
        - C:\Shares\Throughput: Studenten Read, Docenten Modify  (deze zou bv. op een client PC als T: drive gemapt kunnen worden).
        - C:\Shares\home\student1 homedirectory voor student1. Welke rechten geef je?
        - C:\Shares\home\student2 homedirectory voor student2 (deze zou bv. op een client PC als H: drive gemapt kunnen worden).
        - Maak je gebruik van "Share permissies" of van "NTFS permissies"? Wat is best? Waarom?
    - Maak een map C:\Shares\examens aan waar studenten hun examen in kunnen "droppen", maar niet elkaars oplossing kunnen lezen en waar docenten/administrator wel in kan lezen.
        - Welke security settings stel je hiervoor in? 
        - Dit lukt niet met standaard security settings dus je zal dit zeker moeten uittesten!
        - Je kan dit voorlopig uittesten door lokaal aan te loggen met de verschillende gebruikers.
        - Hiervoor moet je wel in de "Domain Controller Policy" toelaten dat gebruikers lokaal kunnen aanloggen (Google?).
    - Bekijk de shares via: Server Manager (File and Storage Services -> Shares) en File Manager (Properties van de directory)

6. REMOTE DESKTOP
    - Kan je op je laptop een remote desktop RDP verbinding (Verbinden met extern bureaublad) maken?
    - Wat moet je hiervoor aanzetten op je Windows Server?
    - Log via RDP in met de user cisco.

## ✨Steps

### 👉 Step 1: 



## 🔗Links
- 👯 Web hosting company [EliasDH.com](https://eliasdh.com).
- 📫 How to reach us eliasdehondt@outlook.com.