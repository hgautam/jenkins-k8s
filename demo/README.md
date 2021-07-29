### Jenkins on K8s Demo

This is demo shows how to install Jenkins on a Kubernetes cluster. As part of the demo, we will create a 3 node Kubernetes cluster using Google Kubernetes Engine(GKE).
Infrastructure created as part of this demo will have a small cost if you don't have free credit available.

* **Requirements:**
    - kubectl
    - helm 3.0
    - GCP active account
    - gcloud configured to talk to your GCP project [gcloud](https://cloud.google.com/sdk/gcloud)

```bash
# create a cluster
./gke.sh

# update the IP address

# Run Helm install
helm install jenkins jenkins/jenkins --namespace jenkins --values values.yaml

# Verify

# clean up
./cluster-cleanup.sh
```