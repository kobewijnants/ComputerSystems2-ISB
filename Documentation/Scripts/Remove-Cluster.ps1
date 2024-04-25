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