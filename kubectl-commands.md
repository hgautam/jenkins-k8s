## Useful commands

Describe the deployment
* kubectl -n jenkins describe deployment jenkins

List the pod
* kubectl -n jenkins get pods --selector app.kubernetes.io/component=jenkins-master

List the pod Json

