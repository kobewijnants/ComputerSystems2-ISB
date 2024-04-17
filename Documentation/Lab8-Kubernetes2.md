![logo](/Images/logo.png)
# 💙🤍Lab8 Kubernetes2🤍💙

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
- DOEL: Deploy Windows Container in Kubernetes
- REF:
  1. https://cloud.google.com/kubernetes-engine/docs/quickstart
	2. https://cloud.google.com/blog/products/containers-kubernetes/how-to-deploy-a-windows-container-on-google-kubernetes-engine

1. Maak een K8s cluster aan in de Google Cloud (zie REF 1, tot "Deploying an application to the cluster")
  Installeer kubectl op je laptop
  Maak een K8s cluster aan met 1 node, voeg opties `--release-channel=rapid --enable-ip-alias` toe (nodig voor punt 2.)
  Authenticeer met je cluster (ev. moet je de omgevingvariabele KUBECONFIG definiëren)
  Check of de cluster node aangemaakt is met het kubectl commando
  
2. Voeg een Windows node toe aan de K8s cluster (zie REF 2.)
  Je hebt reeds een cluster met de master node
  Voeg een Windows node toe (gebruik de `WINDOWS_LTSC_CONTAINERD` image i.p.v. de `WINDOWS_SAC` iamage)
  Check terug of de cluster node aangemaakt is met het kubectl commando

3. Run Windows Container in Pod (zie REF 2.)
  Copieer de iis-site-windows.yaml uit REF 2
  Pas deze aan zodat de container image uit het vorig lab gebruikt wordt
  We gebruiken dus de Docker Hub i.p.v. de Google Container Registry
  Maak de YAML deployment aan met het kubectl commando
  Check of de pod aangemaakt is
  
4. Kubernetes service (zie REF 2.)
  Start een K8S service van het type LoadBalancer, zodat de deployment toegankelijk is voor de buitenwereld
  Surf met de browser van je laptop naar deze service
  
5. Service in YAML
  Voeg de service toe aan de YAML file, zodat je deze niet meer apart achteraf moet opstarten
  Start de deployment opnieuw op met de aangepaste YAML file
  Surf terug met de browser van je laptop naar de iis site
  
6. Start/stop K8s cluster met Powershell
Maak 2 powershell scripts om je cluster te starten (met ev. applicatie erop) en te stoppen
 ` New-Cluster.ps1 [-LinuxNodes COUNT] [-WindowsNodes COUNT] [-ClusterName NAME] [-Yaml YAML_FILE]`
  `Remove-Cluster.ps1 [-ClusterName NAME]`
	LinuxNodes is het aantal Linux nodes, default is 1
	WindowsNodes is het aantal Windows nodes, default is 1
	ClusterName is de naam van de cluster, default is `cs2-cluster`
	Yaml is de naam van een K8s YAML file, default is lege string (dus geen applicatie)
  Test of het aantal `LinuxNodes >= 1` (Waarom?)

7. Verwijder alles wat je in de Google Cloud aangemaakt hebt!


## ✨Steps

### 👉 Step 1: 

## 📦Extra


## 🔗Links
- 👯 Web hosting company [EliasDH.com](https://eliasdh.com).
- 📫 How to reach us elias.dehondt@outlook.com