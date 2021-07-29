#!/bin/bash

######################
# Create The Cluster #
######################
# Assumption:  connectivity is already configured
# helm 3 is being used for deploying Helm based Jenkins package
#gcloud auth login

CLUSTER_NAME=jenkins

REGION=us-central1

gcloud container clusters \
    create-auto $CLUSTER_NAME \
    --region $ZONE


kubectl create clusterrolebinding \
    cluster-admin-binding \
    --clusterrole cluster-admin \
    --user $(gcloud config get-value account)


#Latest version of nginx controller
kubectl apply \
    -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.48.1/deploy/static/provider/cloud/deploy.yaml

# Wait to make sure that LB IP is ready
echo "Retrieving LB IP....."
for i in $(seq 1 60); do
    echo -ne "."
    sleep 1
done
echo

# Retrieve ingress ip
LB_IP=$(kubectl -n ingress-nginx\
    get svc ingress-nginx-controller \
    -o jsonpath="{.status.loadBalancer.ingress[0].ip}"); echo $LB_IP

# create jenkins namespace
kubectl create namespace jenkins
