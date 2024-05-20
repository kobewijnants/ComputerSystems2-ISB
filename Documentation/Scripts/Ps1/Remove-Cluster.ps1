############################
# @author Elias De Hondt   #
# @see https://eliasdh.com #
# @since 25/04/2024        #
############################

<#
.SYNOPSIS
    Remove a Kubernetes cluster.
.DESCRIPTION
    This script removes a Kubernetes cluster on Google Cloud.
    It removes the cluster with the specified name.
.EXAMPLE
    Remove-Cluster.ps1 -ClusterName cs2-cluster
.NOTES
File: Remove-Cluster.ps1
Author: Elias De Hondt
Version: 1.0
#>

param (
    [string]$ClusterName = "cs2-cluster"
)

gcloud container clusters delete $ClusterName `
    --zone=us-central1-c `
    --quiet