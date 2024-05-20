############################
# @author Elias De Hondt   #
# @see https://eliasdh.com #
# @since 25/04/2024        #
############################

<#
.SYNOPSIS
    Create a new Kubernetes cluster.
.DESCRIPTION
    This script creates a new Kubernetes cluster on Google Cloud.
    It creates a cluster with a master node and a Windows node pool.
    The script also applies a YAML file to the cluster.
.EXAMPLE
    New-Cluster.ps1 -LinuxNodes 1 -WindowsNodes 1 -ClusterName cs2-cluster -Yaml "my-yaml.yaml"
.NOTES
File: New-Cluster.ps1
Author: Elias De Hondt
Version: 1.0
#>

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