### Minikube example

* Using Jenkins Kubernetes plugin
* [Jenins Kubernetes Plugin Documentation](https://github.com/jenkinsci/kubernetes-plugin)
* Use the following example to quickly test the set up
```groovy
podTemplate {
    node(POD_LABEL) {
        stage('Run shell') {
            sh 'echo hello world'
        }
    }
}
```
* **Dont pass any commands to run or additional args to the build container**
* The image shown in the documentation doest work.
