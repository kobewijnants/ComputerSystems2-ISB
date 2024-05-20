![logo](https://eliasdh.com/assets/media/images/logo-github.png)
# 💙🤍Tutorial 1 Kubernetes Basics🤍💙

## 📘Table of Contents

1. [📘Table of Contents](#📘table-of-contents)
2. [🖖Introduction](#🖖introduction)
3. [📝Assignment](#📝assignment)
4. [✨Steps](#✨steps)
    1. [👉Cluster Nodes](#👉cluster-nodes)
    2. [👉Deploy Your App](#👉deploy-your-app)
    3. [👉Explore Your App](#👉explore-your-app)
    4. [👉Expose Your App Publicly](#👉expose-your-app-publicly)
    5. [👉Scale Your App](#👉scale-your-app)
    6. [👉Update Your App](#👉update-your-app)
    7. [👉Create a YAML file](#👉create-a-yaml-file)
    8. [👉Kubernetes ClusterIP vs NodePort vs LoadBalancer vs Ingress](#👉kubernetes-clusterip-vs-nodeport-vs-loadbalancer-vs-ingress)
5. [🔗Links](#🔗links)

---

## 🖖Introduction

This is a tutorial to get started with Kubernetes. Kubernetes is an open-source container-orchestration system for automating computer application deployment, scaling, and management. It was originally designed by Google and is now maintained by the Cloud Native Computing Foundation.

## ✨Steps

[Kubernetes Basics](https://kubernetes.io/docs/tutorials/kubernetes-basics)
[Kubernetes YAML](https://www.mirantis.com/blog/introduction-to-yaml-creating-a-kubernetes-deployment)

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

![x](/Images/Tutorial1-Kubernetes-Basics-1.png)

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

### 👉Expose Your App Publicly

- Start a deployment with name `ex2` and image `nginx`
```powershell
kubectl create deployment "ex2" --image=nginx
```

- Create a service with a type LoadBalancer for this deployment, use 8000 as external port (what is the target port?)
```powershell
kubectl expose deployment/ex2 --type="LoadBalancer" --port=8000 --target-port=80
# The target port is 80
```

- Verify in the Google Cloud console that the loadbalancer is created (this can take a few minutes)
```powershell
kubectl get services
```

- Execute an interactive bash shell on your container in the pod
```powershell
kubectl exec -ti "ex2-5c59d59444-cj7s5" -- bash
```

- Install the package "dnsutils"
```bash
apt-get update -y
apt-get install dnsutils -y
```

- Check with nslookup whether the service name is translated to an IP address (which one?)
```bash
nslookup ex2
# The service name is translated to the external IP address of the load balancer
```

- Browse to your nginx website from your coputer Can you use the service name here?
    - No, you need to use the external IP address of the load balancer
    - You can find the external IP address with the following command
    ```powershell
    kubectl get services ex2
    ```
    - If you browse to the external IP address you should see the nginx welcome page if not, wait a few minutes and try again or check the logs of the pod
    ```powershell
    kubectl logs "ex2-5c59d59444-cj7s5"
    ```
    - Dont forget the port 8000 in the URL (http://external-ip:8000)
    - You can also check that the service is working by using curl
    ```powershell
    curl "http://external-ip:8000"
    ```

- Delete the service. Delete the deployment.
```powershell
kubectl delete service "ex2"
kubectl delete deployment "ex2"
```

### 👉Scale Your App

- Start a deployment with name `ex3` and image `gcr.io/google-samples/kubernetes-bootcamp:v1`
```powershell
kubectl create deployment "ex3" --image=gcr.io/google-samples/kubernetes-bootcamp:v1
```

- Create a service with type `LoadBalancer` on port `8000` for this deployment
```powershell
kubectl expose deployment/ex3 --type="LoadBalancer" --port=8000 --target-port=8080
```

- Create 5 replicas
```powershell
kubectl scale deployment/ex3 --replicas=5
```

- Find out the IP address of the loadbalancer and Browse to the application
```powershell
kubectl get services ex3
```

- Go to the website and refresh a few times. What do you see?
```powershell
curl "http://external-ip:8000"
```

![x](/Images/Tutorial1-Kubernetes-Basics-2.png)

### 👉Update Your App

- Do a rolling upgrade to image `jocatalin/kubernetes-bootcamp:v2`
```powershell
kubectl set image deployment/ex3 kubernetes-bootcamp=jocatalin/kubernetes-bootcamp:v2
```

- Check that the upgrade finished succesfully
```powershell
kubectl rollout status deployment/ex3
```

- Roll back to previous version and check whether this is succesfull
```powershell
kubectl rollout undo deployment/ex3
kubectl rollout status deployment/ex3
```

- Delete the service. Delete the deployment.
```powershell
kubectl delete service "ex3"
kubectl delete deployment "ex3"
```

- Delete the cluster
```powershell
gcloud container clusters delete "cluster-1" --region=europe-west1-b -q
```

## 👉Create a YAML file

- Create a Kubernetes cluster
```powershell
gcloud container clusters create "cluster-2" --location=us-central1-c --num-nodes=2
```

- Get authentication credentials for the cluster
```powershell
gcloud container clusters get-credentials "cluster-2" --region=us-central1-c
```

- Create a YAML file [Ex4.yaml](/Documentation/Scripts/Yaml/Ex4.yaml) for:
    - A deployment with name `ex4`
    - `1 pod` with `1 container`
    - Container with image `gcr.io/google-samples/kubernetes-bootcamp:v1` and port `8080`

- Create the deployment from the YAML file
```powershell
kubectl apply -f ex4.yaml # kubectl delete -f ex4.yaml
```

- Look at your nodes, pods and deployments
```powershell
kubectl get nodes
kubectl get pods
kubectl get deployments
```

![x](/Images/Tutorial1-Kubernetes-Basics-3.png)

- Execute an interactive bash shell on your container in the pod
```powershell
kubectl exec -ti "ex4-868f8ff686-fk8pq" -- bash
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

![x](/Images/Tutorial1-Kubernetes-Basics-4.png)

- Change the replica's in [Ex4.yaml](/Documentation/Scripts/Yaml/Ex4.yaml) to `2` and update the deployment

```powershell
kubectl apply -f ex4.yaml
```

- Check the nbr of pods
```powershell
kubectl get pods
```
> **Note:** You should see 2 pods running

![x](/Images/Tutorial1-Kubernetes-Basics-5.png)

- Delete the deployment and check that the pods are deleted
```powershell
kubectl delete deployment "ex4"
kubectl get pods
```

- Create a YAML file [Ex5.yaml](/Documentation/Scripts/Yaml/Ex5.yaml) for:
    - A deployment with name `ex5`
    - `3` pod with `1` container
    - Container with image `gcr.io/google-samples/kubernetes-bootcamp:v1` and port `8080`
    - A service with name `ex5` and type `LoadBalancer` on port `80` for this deployment

- Create the deployment and service from the YAML file
```powershell
kubectl apply -f ex5.yaml
```

- Find out the IP address of the loadbalancer and Browse to the application
```powershell
kubectl get services ex5
```

- Go to the website and refresh a few times. What do you see?
```powershell
curl "http://35.239.30.154:80" # External IP address of the load balancer (:80 is not necessary)
```

![x](/Images/Tutorial1-Kubernetes-Basics-6.png)

- Delete the service. Delete the deployment.
```powershell
kubectl delete service "ex5"
kubectl delete deployment "ex5"
```

- Delete the cluster
```powershell
gcloud container clusters delete "cluster-2" --region=us-central1-c -q
```

### 👉Kubernetes ClusterIP vs NodePort vs LoadBalancer vs Ingress

- Create a Kubernetes cluster
```powershell
gcloud container clusters create "cluster-3" --location=us-central1-c --num-nodes=2 --machine-type=n1-standard-4
```

- Get authentication credentials for the cluster
```powershell
gcloud container clusters get-credentials "cluster-3" --region=us-central1-c
```

- When should I use what?

[Kubernetes ClusterIP vs NodePort vs LoadBalancer vs Ingress](https://medium.com/google-cloud/kubernetes-nodeport-vs-loadbalancer-vs-ingress-when-should-i-use-what-922f010849e0)

1. ClusterIP:
  - Yaml file example [Clusterip-demo.yaml](/Documentation/Scripts/Yaml/Clusterip-demo.yaml)
  - Run the service
  ```powershell
  kubectl apply -f clusterip-demo.yaml
  ```
  - Image for the deployment
  ![x](/Images/Tutorial1-Kubernetes-Basics-7.png)

2. NodePort:
  - Yaml file example [Nodeport-demo.yaml](/Documentation/Scripts/Yaml/Nodeport-demo.yaml)
  - Run the service
  ```powershell
  kubectl apply -f nodeport-demo.yaml
  ```
  - Image for the deployment
  ![xs](/Images/Tutorial1-Kubernetes-Basics-8.png)

3. LoadBalancer:
  - Yaml file example [Loadbalancer-demo.yaml](/Documentation/Scripts/Yaml/Loadbalancer-demo.yaml)
  - Run the service
  ```powershell
  kubectl apply -f loadbalancer-demo.yaml
  ```
  - Image for the deployment
  ![x](/Images/Tutorial1-Kubernetes-Basics-9.png)

4. Ingress
  - Yaml file example [Ingress-demo.yaml](/Documentation/Scripts/Yaml/Ingress-demo.yaml)
  - Run the service
  ```powershell
  kubectl apply -f ingress-demo.yaml
  ```
  - Image for the deployment
  ![x](/Images/Tutorial1-Kubernetes-Basics-10.png)

- Delete the cluster
```powershell
gcloud container clusters delete "cluster-3" --region=us-central1-c -q
```

## 🔗Links
- 👯 Web hosting company [EliasDH.com](https://eliasdh.com).
- 📫 How to reach us elias.dehondt@outlook.com