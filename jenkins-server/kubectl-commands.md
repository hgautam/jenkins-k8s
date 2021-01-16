## Useful commands

Describe the deployment:
* kubectl -n jenkins describe deployment jenkins

List the pod:
* kubectl -n jenkins get pods --selector app.kubernetes.io/component=jenkins-master

List the pod Json:
* JENKINS_POD=$(kubectl -n jenkins \
        get pods \
        --selector app.kubernetes.io/component=jenkins-master \
        --output jsonpath='{.items[0].metadata.name}'); echo $JENKINS_POD

Copy credentials:
* kubectl -n jenkins cp \
    $JENKINS_POD:var/jenkins_home/credentials.xml \
    
Connect to a running pod:
* kubectl -n jenkins exec --stdin --tty $JENKINS_POD -- /bin/bash