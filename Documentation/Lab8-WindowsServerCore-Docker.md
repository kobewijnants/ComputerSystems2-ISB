![logo](/Images/logo.png)
# 💙🤍Lab8 Windows Server Core Docker🤍💙

## 📘Table of Contents

1. [📘Table of Contents](#📘table-of-contents)
2. [🖖Introduction](#🖖introduction)
3. [📝Assignment](#📝assignment)
4. [✨Steps](#✨steps)
    1. [👉Step 0: Preparations](#👉step-0-preparations)
    2. [👉Step 1: Windows Server 2019 Datacenter for Containers](#👉step-1-windows-server-2019-datacenter-for-containers)
    3. [👉Step 2: Deploy Windows container in Google Cloud](#👉step-2-deploy-windows-container-in-google-cloud)
    4. [👉Step 3: Upload the image to Docker Hub](#👉step-3-upload-the-image-to-docker-hub)
    5. [👉Step 4: Create a script for full deployment](#👉step-4-create-a-script-for-full-deployment)
5. [🔗Links](#🔗links)

---

## 🖖Introduction

In this lab we will deploy a Windows container in Google Cloud. We will start by creating a Windows Server 2019 Datacenter for Containers. We will then deploy a Windows container in Google Cloud. We will write a Powershell script to deploy the container in Google Cloud. We will then delete everything we created in Google Cloud (except the machine image).

### 📝Assignment 
> NOTE This is in Dutch

- NODIG: Google Cloud SDK, Docker
- DOEL: Deploy Windows Container in Google Cloud
- REF:
  - https://cloud.google.com/sdk/
	- https://cloud.google.com/compute/docs/quickstart-windows
	- https://cloud.google.com/blog/products/containers-kubernetes/how-to-deploy-a-windows-container-on-google-compute-engine

0. Google cloud en Docker
  - Haal je Google Cloud credits en koppel deze aan je KdG account (zie Canvas). 
  - Installeer de gcloud SDK op je laptop en voor de configuratie uit.
  - Test met: gcloud config list.
  - Als je nog geen account hebt op de Docker Hub [Hub Docker](https://hub.docker.com), maak deze aan.
  
1. Windows Server 2019 Datacenter for Containers
  - `Windows Server 2019 Datacenter for Containers` is niet meer beschikbaar in Google Compute Engine.
  - We gaan daarom zelf hiervoor een image aanmaken.
  - Start `Windows Server 2019 Datacenter Core` in Compute Engine.
  - Maak een RDP verbinding vanop je laptop naar deze instance.
  - Installeer Docker met de volgende 2 commando's:
    - `Invoke-WebRequest -UseBasicParsing "https://raw.githubusercontent.com/microsoft/Windows-Containers/Main/helpful_tools/Install-DockerCE/install-docker-ce.ps1" -o install-docker-ce.ps1 .\install-docker-ce.ps1`
  - Test de Docker installatie bv. met: `docker images`.
  - Maak nu een `machine image` van deze virtuele machine aan via de Google Cloud console (noem deze bv. "win-docker-server")
  - Deze image bewaar je en ga je dus niet deleten.
  - De Windows Server Core VM mag je nu deleten.
  
2. Deploy Windows container in Google Cloud
  - Start nu een compute instance op met jouw `win-docker-server` machine image.
  - Maak een RDP verbinding vanop je laptop naar deze instance.
  - Voer het docker login commando uit.
  - Maak een directory `C:\my-windows-app` met de Docker file uit REF 3 en een content subdirectory.
  - Build de Dockerfile check de image.
  - **LET OP**: we gebruiken een andere tag: `<docker_hub_username>/iis-site-windows:v1.0`
  - Run de container en check.
  - Surf met de browser van je laptop naar de IIS site.

3. Image uploaden naar de Docker registry
  - Push je zojuist aangemaakte container image naar de Docker registry.
  - Check of je deze terugvindt op de Docker Hub site.
  - Als dit gelukt is, delete de Windows server instance in Google Cloud.
  
4. Schrijf een Powershell script om je container te deployen in de Google Cloud.
  - Het script `deploy.ps1` start een compute instance op met jouw `win-docker-server` machine image.
  - Maak hiervoor gebruik van de `gcloud instances create` commando.
  - In deze server wordt je container uit de Docker registry opgestart.
  - Maak hiervoor gebruik van de `--metadata windows-startup-script-cmd key`.
  - Wanneer de optie `-delete` wordt meegegeven, wordt de server instance terug verwijderd.
  - Indien een foute optie wordt meegegeven, schrijf een boodschap.

## ✨Steps

### 👉Step 0: Preparations

- Insall the Google Cloud CLI [Instructions GCloud CLI](https://github.com/EliasDH-com/Documentation/blob/main/Documentation/Instructions-GCloud-CLI.md)

### 👉Step 1: Windows Server 2019 Datacenter for Containers

- Enable Compute Engine API (**Local Host**)
```powershell
gcloud services enable compute.googleapis.com
```

- Start `Windows Server 2019 Datacenter Core` in Compute Engine.
```powershell
gcloud compute instances create win-docker-server --image-family=windows-2019-core --image-project=windows-cloud --zone=us-central1-c
```

- Open firewall for RDP/HTTP/HTTPS & Connect (**Local Host**)
```powershell
gcloud compute firewall-rules create win-docker-server-allow-rdp --allow tcp:3389 --target-tags win-docker-server --description "Allow RDP from any source"
gcloud compute firewall-rules create win-docker-server-allow-http --allow tcp:80 --target-tags win-docker-server --description "Allow HTTP from any source"
gcloud compute firewall-rules create win-docker-server-allow-https --allow tcp:443 --target-tags win-docker-server --description "Allow HTTPS from any source"

# Set Windows password
gcloud compute reset-windows-password win-docker-server --zone=us-central1-c

# Connect with RDP
mstsc
```

- Open Powershell in cmd (**Gcloud Instance**)
```cmd
powershell
```

- Install Docker (**Gcloud Instance**)
```powershell
Invoke-WebRequest -UseBasicParsing "https://raw.githubusercontent.com/microsoft/Windows-Containers/Main/helpful_tools/Install-DockerCE/install-docker-ce.ps1" -o install-docker-ce.ps1

.\install-docker-ce.ps1
```

- Test Docker (**Gcloud Instance**)
```powershell
docker info
```

- Stop the VM (**Local Host**)
```powershell
gcloud compute instances stop win-docker-server --zone=us-central1-c
```

- Create a machine image (**Local Host**)
> **NOTE**: This wil make a snapshot of the current state of the VM (Gcloud Instance)
```powershell
# gcloud compute images create win-docker-server --source-disk=win-docker-server --source-disk-zone=us-central1-c
gcloud compute machine-images create win-docker-server --source-instance=win-docker-server --source-instance-zone=us-central1-c
```

- Delete the VM (**Local Host**)
```powershell
gcloud compute instances delete win-docker-server --zone=us-central1-c --quiet
```

### 👉Step 2: Deploy Windows container in Google Cloud

- Start a compute instance with the image (**Local Host**)
```powershell
gcloud compute instances create win-docker-server-new --image=projects/cs2-isb-elias-de-hondt/global/images/win-docker-server --zone=us-central1-c
```

- Start a compute instance with the machine image (**Local Host**)
```powershell
gcloud compute instances create win-docker-server-new --source-machine-image=win-docker-server --zone=us-central1-c
# For 
```

- Connect with RDP (**Local Host**)
```powershell
# Set Windows password
gcloud compute reset-windows-password win-docker-server-new --zone=us-central1-c

# Connect with RDP
mstsc
```

- Open Powershell in cmd (**Gcloud Instance**)
```cmd
powershell
```

- Login to Docker (**Gcloud Instance**)
```powershell
docker login -u <docker_hub_username> -p <docker_hub_password>
```

- Create a directory and Dockerfile (**Gcloud Instance**)
> **NOTE**: From now on we will only use PowerShell commandos so no aliases
```powershell
New-Item -Path C:\my-windows-app -ItemType Directory
New-Item -Path C:\my-windows-app\Dockerfile -ItemType File
# Open the Dockerfile in notepad
notepad C:\my-windows-app\Dockerfile
```

- Add the following content to the Dockerfile (**Gcloud Instance**)
```Dockerfile
############################
# @author Elias De Hondt   #
# @see https://eliasdh.com #
# @since 24/04/2024        #
############################

# Use the IIS image
FROM mcr.microsoft.com/windows/servercore/iis

LABEL author="Elias De Hondt <elias.dehondt@student.kdg.be>" \
      description="This is a Dockerfile to create a ISS server" \
      version="1.0"

# Make a Hello World page
RUN echo "Hello World - Windows IIS" > C:\inetpub\wwwroot\index.html
```
[Dockerfile](/Documentation/Scripts/Dockerfile)

- Build the Dockerfile (**Gcloud Instance**)
```powershell
docker build -t eliasdh/iis-site-windows:v1.0 C:\my-windows-app
```

- Run the container (**Gcloud Instance**)
```powershell
docker run -d -p 80:80 eliasdh/iis-site-windows:v1.0
```

- Check the container (**Gcloud Instance**)
```powershell
docker ps
```

- Surf to the IIS site (**Local Host**)
```bash
curl http://$(gcloud compute instances describe win-docker-server-new --zone=us-central1-c --format='value(networkInterfaces[0].accessConfigs[0].natIP)')/index.html
```

### 👉Step 3: Upload the image to Docker Hub

- Push the container image to the Docker registry (**Gcloud Instance**)
```powershell
docker push eliasdh/iis-site-windows:v1.0
```

- Check if the image is on the Docker Hub site (**Local Host**)
```bash
curl https://hub.docker.com/r/eliasdh/iis-site-windows
```

- Delete the Windows server instance in Google Cloud (**Local Host**)
```powershell
gcloud compute instances delete win-docker-server-new --zone=us-central1-c --quiet
```

### 👉Step 4: Create a script for full deployment

- Create a script to deploy the container in Google Cloud (**Local Host**)
```powershell
New-Item -Path C:\deploy.ps1 -ItemType File
# Open the deploy.ps1 in notepad
notepad C:\deploy.ps1
```

- Add the following content to the deploy.ps1 (**Local Host**)
```powershell
############################
# @author Elias De Hondt   #
# @see https://eliasdh.com #
# @since 24/04/2024        #
############################

param (
    [string]$action = "-deploy"
)

if ($action -eq "-deploy") {
    gcloud compute instances create win-docker-server-new `
    --project=cs2-isb-elias-de-hondt `
    --source-machine-image=win-docker-server `
    --zone=us-central1-c `
    --metadata="windows-startup-script-ps1=docker run eliasdh/iis-site-windows:v1.0"
} elseif ($action -eq "-delete") {
    gcloud compute instances delete win-docker-server-new `
    --zone=us-central1-c `
    --quiet
} else {
    Write-Host "Invalid option"
}
```
[Deploy.ps1](/Documentation/Scripts/deploy.ps1)

- Run the script to deploy the container in Google Cloud (**Local Host**)
```powershell
.\deploy.ps1 -deploy
```

- Run the script to delete the container in Google Cloud (**Local Host**)
```powershell
.\deploy.ps1 -delete
```

## 🔗Links
- 👯 Web hosting company [EliasDH.com](https://eliasdh.com).
- 📫 How to reach us elias.dehondt@outlook.com