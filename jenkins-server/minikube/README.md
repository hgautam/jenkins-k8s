# Jenkins on Minikube

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
Enable ingress

```
minikube addons enable ingress
```
Enable Helm/Tiller(Not required anymore)

```
minikube addons enable helm-tiller
```

Create namespace:
```
$ kubectl create -f minikube/jenkins-namespace.yaml
kubectl create namespace jenkins
```

Create persistent volume (folder /data is persistent on minikube)
```
# Modify values file to use the persistent volume
$ kubectl create -f minikube/jenkins-volume.yaml
```

Add Jenkins Helm Repo
```
helm repo add jenkins https://charts.jenkins.io
helm repo update
```

Execute helm:
```
Non-ingress Helm based install
$ helm install jenkins jenkins/jenkins --namespace jenkins --values helm/jenkins-values.yaml
```


Check admin password for jenkins:
```bash
# Get your 'admin' user password by running:
kubectl exec --namespace jenkins -it svc/jenkins -c jenkins -- /bin/cat /run/secrets/chart-admin-password && echo

# Visit http://192.168.64.43.nip.io
```

Helm 2 list and delete a release

```
helm list
helm delete <releaseName>
```
