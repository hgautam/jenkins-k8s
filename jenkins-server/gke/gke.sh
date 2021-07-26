#!/bin/bash

######################
# Create The Cluster #
######################
# Assumption:  connectivity is already configured
# helm 3 is being used for deploying Helm based Jenkins package
#gcloud auth login

CLUSTER_NAME=jenkins

ZONE=us-west4-a

MACHINE_TYPE=n1-highcpu-2

gcloud container clusters \
    create $CLUSTER_NAME \
    --zone $ZONE \
    --machine-type $MACHINE_TYPE \
    --enable-autoscaling \
    --num-nodes 3 \
    --max-nodes 3 \
    --min-nodes 1

kubectl create clusterrolebinding \
    cluster-admin-binding \
    --clusterrole cluster-admin \
    --user $(gcloud config get-value account)


#Latest version of nginx controller
# https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.34.1/deploy/static/provider/cloud/deploy.yaml
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
