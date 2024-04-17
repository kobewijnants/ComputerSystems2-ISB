![logo](/Images/logo.png)
# 💙🤍Kubernetes Basics🤍💙

## 📘Table of Contents

1. [📘Table of Contents](#📘table-of-contents)
2. [🖖Introduction](#🖖introduction)
3. [📝Assignment](#📝assignment)
4. [✨Steps](#✨steps)
5. [🔗Links](#🔗links)

---

## 🖖Introduction



## ✨Steps

[Kubernetes Basics](https://kubernetes.io/docs/tutorials/kubernetes-basics)

### 👉Cluster Nodes

- Enable the Kubernetes Engine API
```powershell
gcloud services enable container.googleapis.com
```

- Create a Kubernetes cluster
```powershell
gcloud container clusters create "cluster-1" --location=europe-west1-b
```

- Get authentication credentials for the cluster
```powershell
gcloud container clusters get-credentials "cluster-1" --region=europe-west1-b
```

- View the nodes in your cluster
```powershell
kubectl get nodes
```

![Kubernetes Basics](/Images/Kubernetes-Basics-1.png)

### 👉Deploy Your App

- Create a Deployment
```powershell
kubectl create deployment "kubernetes-bootcamp" --image=gcr.io/google-samples/kubernetes-bootcamp:v1
```

- List your deployments
```powershell
kubectl get deployments
```

- View the deployment details
```powershell
kubectl describe deployments/kubernetes-bootcamp
```

- List the pods created by the deployment
```powershell
kubectl get pods
```

### 👉Explore Your App

- Execute an interactive bash shell on your container in the pod
```powershell
kubectl exec -ti "kubernetes-bootcamp-855d5cc575-8fkb2" -- bash
```

- Look at all processes in the container, which application is running?
```bash
ps aux # Is node server.js
```

- Check whether the application is responding with curl on localhost (find the port!)
```bash
curl localhost:8080
exit
```

- Delete the pod running your deployment. What happens?
```powershell
kubectl delete pods "kubernetes-bootcamp-855d5cc575-8fkb2"
# The pod is deleted and a new pod is created
kubectl get pods
```

- Delete the deployment
```powershell
kubectl delete deployment "kubernetes-bootcamp"
```


## 🔗Links
- 👯 Web hosting company [EliasDH.com](https://eliasdh.com).
- 📫 How to reach us elias.dehondt@outlook.com