#! /bin/bash

######################
# Create The Cluster #
######################
# Assumption:  connectivity is already configured
#gcloud auth login

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


# Latest version of nginx controller
kubectl apply \
    -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.34.1/deploy/static/provider/cloud/deploy.yaml
