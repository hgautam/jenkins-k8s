#! /bin/bash
######################
# Create The Cluster #
######################

# Assumption: Connectivity is all set
#gcloud auth login
# Uses helm 3
CLUSTER_NAME=jenkins

ZONE=us-west1-a

MACHINE_TYPE=n1-highcpu-2

gcloud container clusters \
    create $CLUSTER_NAME \
    --zone $ZONE \
    --machine-type $MACHINE_TYPE \
    --enable-autoscaling \
    --num-nodes 1 \
    --max-nodes 1 \
    --min-nodes 1

kubectl create clusterrolebinding \
    cluster-admin-binding \
    --clusterrole cluster-admin \
    --user $(gcloud config get-value account)

###################
# Install Ingress #
###################

kubectl apply \
    -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.34.1/deploy/static/provider/cloud/deploy.yaml

echo "Retrieving LB IP....."
sleep 60
# Retrieve ingress ip
LB_IP=$(kubectl -n ingress-nginx\
    get svc ingress-nginx-controller \
    -o jsonpath="{.status.loadBalancer.ingress[0].ip}"); echo $LB_IP
