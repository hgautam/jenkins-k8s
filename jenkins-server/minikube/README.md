## Jenkins on Minikube

### This example is without Ingress. Directly pointing to the NodePort for accessing Jenkins

Verify minikube is running:
```
minikube status
minikube
type: Control Plane
host: Running
kubelet: Running
apiserver: Running
kubeconfig: Configured
```

Create namespace:
```
$ kubectl create -f minikube/jenkins-namespace.yaml
kubectl create namespace jenkins
```

Add Jenkins Helm Repo
```
helm repo add jenkins https://charts.jenkins.io
helm repo update
```

Execute helm:
```
Non-ingress Helm based install
$ helm install jenkins jenkins/jenkins --namespace jenkins --values helm/values.yaml
```


Check admin password for jenkins:
```bash
# Get your 'admin' user password by running:
kubectl exec --namespace jenkins -it svc/jenkins -c jenkins -- /bin/cat /run/secrets/chart-admin-password && echo

# Visit http://192.168.64.43.nip.io
```

Helm list and install a release

```
helm list -n jenkins
helm uninstall jenkins -n jenkins
```
