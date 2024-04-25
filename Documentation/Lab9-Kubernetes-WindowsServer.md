![logo](/Images/logo.png)
# 💙🤍Lab9 Kubernetes Windows Server🤍💙

## 📘Table of Contents

1. [📘Table of Contents](#📘table-of-contents)
2. [🖖Introduction](#🖖introduction)
3. [📝Assignment](#📝assignment)
4. [✨Steps](#✨steps)
    1. [👉Step 1: Create demo cluster](#👉step-1-create-demo-cluster)
    2. [👉Step 2: Add Windows node to the cluster](#👉step-2-add-windows-node-to-the-cluster)
    3. [👉Step 3: Run Windows Container in Pod](#👉step-3-run-windows-container-in-pod)

---

## 🖖Introduction

In this lab we will deploy a Windows Container in Kubernetes. We will create a K8s cluster in Google Cloud, add a Windows node to the cluster, run a Windows Container in a Pod, create a Kubernetes service, create a service in YAML, create an Ingress in YAML and create a start/stop K8s cluster with Powershell.

### 📝Assignment 
> NOTE This is in Dutch

- NODIG: Google Cloud SDK, Docker
- DOEL: Deploy Windows Container in Kubernetes
- REF: 
    - https://cloud.google.com/kubernetes-engine/docs/quickstart
    - https://cloud.google.com/blog/products/containers-kubernetes/how-to-deploy-a-windows-container-on-google-kubernetes-engine

1. Maak een K8s cluster aan in de Google Cloud.
    - Maak een K8s cluster aan met 1 node, voeg opties `--release-channel=rapid --enable-ip-alias` toe.
    - Authenticeer met je cluster (ev. moet je de omgevingvariabele KUBECONFIG definiëren).
    - Check of de cluster node aangemaakt is met het kubectl commando.

2. Voeg een Windows node toe aan de K8s cluster
    - Je hebt reeds een cluster met de master node.
    - Voeg een Windows node toe (gebruik de `WINDOWS_LTSC_CONTAINERD`).
    - Check terug of de cluster node aangemaakt is met het kubectl commando.

3. Run Windows Container in Pod
    - Copieer de `iis-site-windows.yaml` uit REF 2.
    - Pas deze aan zodat de container image uit het vorig lab gebruikt wordt.
    - We gebruiken dus de Docker Hub i.p.v. de Google Container Registry.
    - Maak de YAML deployment aan met het kubectl commando.
    - Check of de pod aangemaakt is.

4. Kubernetes service
    - Start een K8S service van het type LoadBalancer, zodat de deployment toegankelijk is voor de buitenwereld.
    - Surf met de browser van je laptop naar deze service.

5. Service in YAML
    - Voeg de service toe aan de YAML file, zodat je deze niet meer apart achteraf moet opstarten.
    - Start de deployment opnieuw op met de aangepaste YAML file.
    - Surf terug met de browser van je laptop naar de iis site.

6. Ingress in YAML
    - Maak een versie 2 van de YAML file, waarin je een Ingress gebruikt om de IIS site toegankelijk voor de buitenwereld te maken.

7. Start/stop K8s cluster met Powershell
    - Maak 2 powershell scripts om je cluster te starten (met ev. applicatie erop) en te stoppen.
        `New-Cluster.ps1 [-LinuxNodes COUNT] [-WindowsNodes COUNT] [-ClusterNameNAME] [-Yaml YAML_FILE]`
        `Remove-Cluster.ps1 [-ClusterName NAME]`.
    - LinuxNodes is het aantal Linux nodes, default is 1.
    - WindowsNodes is het aantal Windows nodes, default is 1.
    - ClusterName is de naam van de cluster, default is `cs2-cluster` Yaml is de naam van een K8s YAML file, default is lege string (dus geen applicatie).
    - Test of het aantal LinuxNodes >= 1 (Waarom?).

## ✨Steps

### 👉Step 1: Create demo cluster

- Create a new cluster with the following command:
```powershell
gcloud container clusters create "cs2-cluster" --num-nodes=1 --release-channel=rapid --enable-ip-alias --location=us-central1-c --machine-type=n1-standard-4
```

- Authenticate with the cluster:
```powershell
gcloud container clusters get-credentials "cs2-cluster" --zone=us-central1-c
```

- Check if the cluster node is created with the following command:
```powershell
kubectl get nodes
```

![Lab9-Kubernetes-WindowsServer-1](/Images/Lab9-Kubernetes-WindowsServer-1.png)

### 👉Step 2: Add Windows node to the cluster

- Add a Windows node to the cluster:
```powershell
gcloud container node-pools create "windows-pool" --cluster="cs2-cluster" --image-type=WINDOWS_LTSC_CONTAINERD --num-nodes=1 --machine-type=n1-standard-4 --zone=us-central1-c
```

- Check if the cluster node is created with the following command:
```powershell
kubectl get nodes
```

![Lab9-Kubernetes-WindowsServer-2](/Images/Lab9-Kubernetes-WindowsServer-2.png)

### 👉Step 3: Run Windows Container in Pod

- Copy the `iis-site-windows.yaml` file from the reference 2.
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: iis-site-windows
  labels:
    app: iis-site-windows
spec:
  replicas: 2
  selector:
    matchLabels:
      app: iis-site-windows
  template:
    metadata:
      labels:
        app: iis-site-windows
    spec:
      nodeSelector:
        kubernetes.io/os: windows
      containers:
      - name: iis-site-windows
        image: eliasdh/iis-site-windows:v1.0
        ports:
        - containerPort: 80
```

- Change the image to the Docker Hub image:
```yaml
image: eliasdh/iis-site-windows:v1.0
```

[iis-site-windows.yaml](/Documentation/Scripts/iis-site-windows.yaml)

- Create the YAML deployment with the following command:
```powershell
kubectl apply -f iis-site-windows.yaml
```

- Check if the pod is created with the following command:
```powershell
kubectl get nodes,deployments,pods
```

> **NOTE** Delete the deployment with the following command:
```powershell
kubectl delete deployment iis-site-windows
```

> **NOTE** If it doesn't work, you can try to set a firewall rule to allow traffic on port 80,443,22
```powershell
# To Create the firewall rules
gcloud compute firewall-rules create allow-http --allow tcp:80
gcloud compute firewall-rules create allow-https --allow tcp:443
gcloud compute firewall-rules create allow-ssh --allow tcp:22
# To Delete the firewall rules
gcloud compute firewall-rules delete allow-http --quiet
gcloud compute firewall-rules delete allow-https --quiet
gcloud compute firewall-rules delete allow-ssh --quiet
```





## 📦Extra

- Delete all deployment? services, nodes and clusters
```powershell
kubectl delete deployment --all
kubectl delete service --all
gcloud container clusters delete "cs2-cluster" --zone=us-central1-c --quiet
```


## 🔗Links
- 👯 Web hosting company [EliasDH.com](https://eliasdh.com).
- 📫 How to reach us elias.dehondt@outlook.com