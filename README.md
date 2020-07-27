# jenkins-k8s

The intent of this document is to outline the steps necessary to install Jenkins with the Kubernetes plugin on a cluster. The Kubernetes plugin allows for a scale to zero solution for build agents which saves on resources.

## Technology Components

* [Kubernetes](https://kubernetes.io/) cluster
* [Rook](https://rook.io/), [Ceph File System](https://docs.ceph.com/docs/master/cephfs/)
* [Jenkins](https://www.jenkins.io/)
* [Kubernetes | Jenkins plugin](https://plugins.jenkins.io/kubernetes/)


## Build image

The following will build a Jenkins container image via `Dockerfile` and automate the installation of plugins defined in the `plugins.txt` file.

Update `plugins.txt` as needed.

```
docker build -t digitalsanctum/jenkins:2.235.2 .
docker login
docker push digitalsanctum/jenkins:2.235.2
```


Test locally.

```
docker run -d --name jenkins -p 8080:8080 --rm digitalsanctum/jenkins:2.235.2
```

## Install via kubectl

Update image/version in `kubernetes/deployment.yaml` as needed.

```bash
kc apply -f kubernetes/namespace.yaml
kc apply -f kubernetes
kc apply -f kubernetes/service.yaml --validate=false
```

Get the port via:

```bash
kc get service -n jenkins
```

## Install via Helm

NOT WORKING YET...need to tweak storage bits to use ceph.

```bash
helm repo add stable https://kubernetes-charts.storage.googleapis.com
helm install my-release stable/jenkins -f helm/values.yaml
```

* Reference: https://github.com/helm/charts/tree/master/stable/jenkins
