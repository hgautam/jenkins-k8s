### Minikube example

* Using Jenkins Kubernetes plugin
* [Jenins Kubernetes Plugin Documentation](https://github.com/jenkinsci/kubernetes-plugin)

```groovy
podTemplate {
    node(POD_LABEL) {
        stage('Run shell') {
            sh 'echo hello world'
        }
    }
}
```
