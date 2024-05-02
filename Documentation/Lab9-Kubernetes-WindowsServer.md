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
    4. [👉Step 4: Kubernetes service](#👉step-4-kubernetes-service)
    5. [👉Step 5: Service in YAML](#👉step-5-service-in-yaml)
    6. [👉Step 6: Ingress in YAML](#👉step-6-ingress-in-yaml)
    7. [👉Step 7: Create PowerShell Scripts](#👉step-7-create-powershell-scripts)
5. [📦Extra](#📦extra)
6. [🔗Links](#🔗links)

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
    - Start een K8S service van het type `LoadBalancer`, zodat de deployment toegankelijk is voor de buitenwereld.
    - Surf met de browser van je laptop naar deze service.

5. Service in YAML
    - Voeg de service toe aan de YAML file, zodat je deze niet meer apart achteraf moet opstarten.
    - Start de deployment opnieuw op met de aangepaste YAML file.
    - Surf terug met de browser van je laptop naar de iis site.

6. Ingress in YAML
    - Maak een versie 3 van de YAML file, waarin je een Ingress gebruikt om de IIS site toegankelijk voor de buitenwereld te maken.

7. Start/stop K8s cluster met Powershell
    - Maak 2 powershell scripts om je cluster te starten (met ev. applicatie erop) en te stoppen.
      - `New-Cluster.ps1 [-LinuxNodes COUNT] [-WindowsNodes COUNT] [-ClusterNameNAME] [-Yaml YAML_FILE]`
      - `Remove-Cluster.ps1 [-ClusterName NAME]`.
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

![x](/Images/Lab9-Kubernetes-WindowsServer-1.png)

### 👉Step 2: Add Windows node to the cluster

- Add a Windows node to the cluster:
```powershell
gcloud container node-pools create "windows-pool" --cluster="cs2-cluster" --image-type=WINDOWS_LTSC_CONTAINERD --num-nodes=1 --no-enable-autoupgrade --machine-type=n1-standard-4 --zone=us-central1-c
```

> **NOTE** To delete the Windows node pool:
```powershell
gcloud container node-pools delete "windows-pool" --cluster="cs2-cluster" --zone=us-central1-c --quiet
```

- Check if the cluster node is created with the following command:
```powershell
kubectl get nodes
```

![x](/Images/Lab9-Kubernetes-WindowsServer-2.png)

### 👉Step 3: Run Windows Container in Pod

- Copy the `iis-site-windows-v1.yaml` file from the reference 2.
```yaml
############################
# @author Elias De Hondt   #
# @see https://eliasdh.com #
# @since 25/04/2024        #
############################
---
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

[iis-site-windows-v1.yaml](/Documentation/Scripts/iis-site-windows-v1.yaml)

- Change the image to the Docker Hub image:
```yaml
image: eliasdh/iis-site-windows:v1.0
```

[iis-site-windows-v1.yaml](/Documentation/Scripts/iis-site-windows-v1.yaml)

- Create the YAML deployment with the following command:
```powershell
kubectl apply -f iis-site-windows-v1.yaml
```

- Check if the pod is created with the following command:
```powershell
kubectl get nodes,deployments,pods
```

![x](/Images/Lab9-Kubernetes-WindowsServer-3.png)

> **NOTE** Delete the deployment with the following command:
```powershell
kubectl delete deployment iis-site-windows
```

> **NOTE** If it doesn't work, you can try to set a firewall rule to allow traffic on port 80,443,22:
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

### 👉Step 4: Kubernetes service

- Start a K8S service of type `LoadBalancer`, so the deployment is accessible to the outside world:
```powershell
kubectl expose deployment iis-site-windows --type=LoadBalancer
```

- Surf with the browser of your laptop to this service:
```powershell
kubectl get services
```

![x](/Images/Lab9-Kubernetes-WindowsServer-4.png)


- Go to the external IP address in your browser:

![x](/Images/Lab9-Kubernetes-WindowsServer-5.png)


### 👉Step 5: Service in YAML

- Delete the service and deployment:
```powershell
kubectl delete service iis-site-windows
kubectl delete deployment iis-site-windows
```

- Get all the services and deployments:
```powershell
kubectl get services,deployments
```

- Create a version 2 of the YAML file, where you add the service `LoadBalancer`:
```yaml
############################
# @author Elias De Hondt   #
# @see https://eliasdh.com #
# @since 25/04/2024        #
############################
---
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
---
apiVersion: v1
kind: Service
metadata:
  name: iis-site-windows
spec:
  selector:
    app: iis-site-windows
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
  type: LoadBalancer
```

[iis-site-windows-v2.yaml](/Documentation/Scripts/iis-site-windows-v2.yaml)

- Create the deployment with the following command:
```powershell
kubectl apply -f iis-site-windows-v2.yaml
```

> **NOTE** This will go much faster than the first time because the image is already downloaded on the Windows node.

- Check if the pod is created with the following command:
```powershell
kubectl get nodes,deployments,pods,services
```

![x](/Images/Lab9-Kubernetes-WindowsServer-6.png)

- Go to the external IP address in your browser:

![x](/Images/Lab9-Kubernetes-WindowsServer-7.png)

### 👉Step 6: Ingress in YAML

- Delete the service and deployment:
```powershell
kubectl delete service iis-site-windows
kubectl delete deployment iis-site-windows
```

- Get all the services and deployments:
```powershell
kubectl get services,deployments
```

- Create a version 3 of the YAML file, where you use an Ingress to make the IIS site accessible to the outside world:
```yaml
############################
# @author Elias De Hondt   #
# @see https://eliasdh.com #
# @since 25/04/2024        #
############################
---
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
---
apiVersion: v1
kind: Service
metadata:
  name: iis-site-windows
spec:
  selector:
    app: iis-site-windows
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
  type: LoadBalancer
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: iis-site-windows
spec:
  rules:
  - host: demo-cs2.eliasdh.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: iis-site-windows
            port:
              number: 80
```

[iis-site-windows-v3.yaml](/Documentation/Scripts/iis-site-windows-v3.yaml)

- Create the deployment with the following command:
```powershell
kubectl apply -f iis-site-windows-v3.yaml
```

- Check if the pod is created with the following command:
```powershell
kubectl get ingress # Remember the IP address
```

![x](/Images/Lab9-Kubernetes-WindowsServer-8.png)

> **NOTE** For Windows users, you can add the domain to the `C:\Windows\System32\drivers\etc\hosts` with the following command:
```powershell
Add-Content C:\Windows\System32\drivers\etc\hosts "`n35.201.120.103 demo-cs2.eliasdh.com"
```

- Go to the domain in your browser:

![x](/Images/Lab9-Kubernetes-WindowsServer-9.png)

- Delete the service, deployment and ingress:
```powershell
kubectl delete service iis-site-windows
kubectl delete deployment iis-site-windows
kubectl delete ingress iis-site-windows
```

- Get all the services, deployments and ingress:
```powershell
kubectl get services,deployments,ingress
```

- Delete de demo cluster:
```powershell
gcloud container clusters delete "cs2-cluster" --zone=us-central1-c --quiet
```

## 👉Step 7: Create PowerShell Scripts

- Start by creating a new PowerShell script `New-Cluster.ps1` with the following content:
```powershell
############################
# @author Elias De Hondt   #
# @see https://eliasdh.com #
# @since 25/04/2024        #
############################

param (
  [int]$LinuxNodes = 1,
  [int]$WindowsNodes = 1,
  [string]$ClusterName = "cs2-cluster",
  [string]$Yaml = ""
)

if ($LinuxNodes -lt 1) {
  Write-Host "LinuxNodes must be greater than or equal to 1 (This is for the master node)"
  exit
}

gcloud container clusters create $ClusterName `
    --num-nodes=$LinuxNodes `
    --release-channel=rapid `
    --enable-ip-alias `
    --location=us-central1-c `
    --machine-type=n1-standard-4

gcloud container node-pools create "windows-pool" `
    --cluster=$ClusterName `
    --image-type=WINDOWS_LTSC_CONTAINERD `
    --num-nodes=$WindowsNodes `
    --no-enable-autoupgrade `
    --machine-type=n1-standard-4 `
    --zone=us-central1-c

gcloud container clusters get-credentials $ClusterName `
    --zone=us-central1-c

if ($Yaml -ne "") {
  Write-Host "Running YAML file: $Yaml"
  kubectl apply -f $Yaml
}
```

- Execute the script with the following command:
```powershell
.\New-Cluster.ps1 -LinuxNodes 3 -WindowsNodes 2 -ClusterName "cs2-cluster" -Yaml "iis-site-windows-v3.yaml"
```

[New-Cluster.ps1](/Documentation/Scripts/New-Cluster.ps1)

- Create a new PowerShell script `Remove-Cluster.ps1` with the following content:
```powershell
############################
# @author Elias De Hondt   #
# @see https://eliasdh.com #
# @since 25/04/2024        #
############################

param (
  [string]$ClusterName = "cs2-cluster"
)

gcloud container clusters delete $ClusterName `
    --zone=us-central1-c `
    --quiet
```

- Execute the script with the following command:
```powershell
.\Remove-Cluster.ps1 -ClusterName "cs2-cluster"
```

[Remove-Cluster.ps1](/Documentation/Scripts/Remove-Cluster.ps1)

## 📦Extra

- Delete all deployment? services, nodes and clusters
```powershell
kubectl delete deployment --all
kubectl delete service --all
gcloud container clusters delete "cs2-cluster" --zone=us-central1-c --quiet
```

- This is a advanced YAML file -> 2 Database pods, 5 Webserver pods and 2 LoadBalancer one for the Database and one for the Webserver pods + 2 Ingress:
```yaml
############################
# @author Elias De Hondt   #
# @see https://eliasdh.com #
# @since 25/04/2024        #
############################
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: db
  labels:
    app: db
spec:
  replicas: 2
  selector:
    matchLabels:
      app: db
  template:
    metadata:
      labels:
        app: db
    spec:
      containers:
      - name: db
        image: eliasdh/db:v1.0
        ports:
        - containerPort: 3306
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web
  labels:
    app: web
spec:
  replicas: 5
  selector:
    matchLabels:
      app: web
  template:
    metadata:
      labels:
        app: web
    spec:
      containers:
      - name: web
        image: eliasdh/web:v1.0
        ports:
        - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: db
spec:
  selector:
    app: db
  ports:
    - protocol: TCP
      port: 3306
      targetPort: 3306
  type: LoadBalancer
---
apiVersion: v1
kind: Service
metadata:
  name: web
spec:
  selector:
    app: web
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
  type: LoadBalancer
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: web
spec:
  rules:
  - host: demo-cs2.eliasdh.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: web
            port:
              number: 80
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: db
spec:
  rules:
  - host: db.demo-cs2.eliasdh.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: db
            port:
              number: 3306
```

## 🔗Links
- 👯 Web hosting company [EliasDH.com](https://eliasdh.com).
- 📫 How to reach us elias.dehondt@outlook.com