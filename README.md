# jenkins-k8s

## Build image

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

TODO: investigate:
```bash
error: error validating "kubernetes/service.yaml": error validating data: ValidationError(Service.metadata): unknown field "fqdn" in io.k8s.apimachinery.pkg.apis.meta.v1.ObjectMeta; if you choose to ignore these errors, turn validation off with --validate=false
```

Get the port via:

```bash
kc get service -n jenkins
```

Open http://nuc1:30128 in a browser.

## Install via Helm

NOT WORKING YET...need to tweak storage bits to use ceph.

```bash
helm repo add stable https://kubernetes-charts.storage.googleapis.com
helm install my-release stable/jenkins -f helm/values.yaml
```

* Reference: https://github.com/helm/charts/tree/master/stable/jenkins