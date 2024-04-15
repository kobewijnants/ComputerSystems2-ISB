![logo](/Images/logo.png)
# 💙🤍Lab7 Kubernetes1🤍💙

## 📘Table of Contents

1. [📘Table of Contents](#📘table-of-contents)
2. [🖖Introduction](#🖖introduction)
3. [📝Assignment](#📝assignment)
4. [✨Steps](#✨steps)

---

## 🖖Introduction



### 📝Assignment 
> NOTE This is in Dutch

- NODIG: Google Cloud SDK, Docker

- DOEL: Deploy Windows Container in Google Cloud

- REF:
    1. https://cloud.google.com/sdk/
	2. https://cloud.google.com/compute/docs/quickstart-windows
	3. https://cloud.google.com/blog/products/containers-kubernetes/how-to-deploy-a-windows-container-on-google-compute-engine

0. Google cloud en Docker
  Haal je Google Cloud credits en koppel deze aan je KdG account (zie Canvas) 
  Installeer de gcloud SDK op je laptop (zie REF 1) en voor de configuratie uit.
  Test met: `gcloud config list`
  Als je nog geen account hebt op de Docker Hub [Docker Hub](https://hub.docker.com/), maak deze aan.
  
1. Deploy Windows container in Google Cloud (zie REF 3)
  Start een `Windows Server 2019 Core` for Containers instance in zone `europe-west1-b`
  Maak een RDP verbinding vanop je laptop naar deze instance
  Voer het docker login commando uit (met je Docker Hub account uit 0.)
  Maak een directory `C:\my-windows-app` met de Docker file uit REF 3 en een content subdirectory
  Build de Dockerfile check de image.
  LET OP: we gebruiken een andere tag: `<docker_hub_username>/iis-site-windows:v1.0`
  Run de container en check
  Surf met de browser van je laptop naar de IIS site

2. Image uploaden naar de Docker registry
  Push je zojuist aangemaakte container image naar de Docker registry
  Check of je deze terugvindt op de Docker Hub site
  Als dit gelukt is, delete de Windows server instance in Google Cloud
  
3. Schrijf een Powershell script om je container te deployen in de Google Cloud
  Het script deploy.ps1 maakt een Windows Server 2019 Core for Containers instance aan
  Maak hiervoor gebruik van de `gcloud instances create` commando
  In deze server wordt je container uit de Docker registry opgestart
  Maak hiervoor gebruik van de `--metadata windows-startup-script-cmd key`
  Wanneer de optie `-delete` wordt meegegeven, wordt de server instance terug verwijderd
  Indien een foute optie wordt meegegeven, schrijf een boodschap
  
3. Verwijder alles wat je in de Google Cloud aangemaakt hebt!

## ✨Steps

### 👉 Step 1: 

## 📦Extra


## 🔗Links
- 👯 Web hosting company [EliasDH.com](https://eliasdh.com).
- 📫 How to reach us eliasdehondt@outlook.com.