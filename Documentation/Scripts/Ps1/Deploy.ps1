############################
# @author Elias De Hondt   #
# @see https://eliasdh.com #
# @since 24/04/2024        #
############################

<#
.SYNOPSIS
    Deploy a new Windows instance.    
.DESCRIPTION
    This script deploys a new Windows instance on Google Cloud.
    The instance is created from a Windows image and a startup script is applied.
    The script also creates a firewall rule to allow HTTP traffic.
.EXAMPLE
    Deploy.ps1 -action deploy (c)
    Deploy.ps1 -action delete (r)
.NOTES
File: Deploy.ps1
Author: Elias De Hondt
Version: 1.0
#>

param (
    [string]$action = "deploy"
)

$project="cs2-isb-elias-de-hondt"
$zone="us-central1-c"
$nameInstances="win-docker-server-new"
$nameImage="win-docker-server"
$nameFirewallRule="allow-http-win-docker-server-new"

if ($action -eq "deploy" -or $action -eq "c") {
    Write-Host "Creating instance"

    gcloud compute instances create $nameInstances `
    --project=$project `
    --source-machine-image=$nameImage `
    --zone=$zone `
    --metadata="windows-startup-script-ps1=docker run eliasdh/iis-site-windows:v1.0"

    gcloud compute firewall-rules create $nameFirewallRule `
    --project=$project `
    --direction=INGRESS `
    --priority=1000 `
    --network=default `
    --action=ALLOW `
    --rules=tcp:80
} elseif ($action -eq "delete" -or $action -eq "r") {
    Write-Host "Deleting instance"

    gcloud compute instances delete $nameInstances `
    --project=$project `
    --zone=us-central1-c `
    --quiet
    gcloud compute firewall-rules delete $nameFirewallRule `
    --project=$project `
    --quiet
} else {
    Write-Host "Invalid option"
}