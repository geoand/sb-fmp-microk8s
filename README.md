# Instructions

## Install microk8s

```bash
sudo snap install microk8s --classic --channel=1.11/stable
sleep 10
microk8s.enable dns registry
```

Ensure everything is running by inspecting the output of:

```bash
microk8s.kubectl get all --all-namespaces
```

It should look something like:

```
NAMESPACE            NAME                                       READY     STATUS    RESTARTS   AGE
container-registry   pod/registry-6bc95dfd76-274lc              1/1       Running   0          40s
kube-system          pod/hostpath-provisioner-9979c7f64-f96tw   1/1       Running   0          41s
kube-system          pod/kube-dns-864b8bdc77-68kmn              2/3       Running   0          41s

NAMESPACE            NAME                 TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
container-registry   service/registry     NodePort    10.152.183.175   <none>        5000:32000/TCP   50s
default              service/kubernetes   ClusterIP   10.152.183.1     <none>        443/TCP          1m
kube-system          service/kube-dns     ClusterIP   10.152.183.10    <none>        53/UDP,53/TCP    56s

NAMESPACE            NAME                                   DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
container-registry   deployment.apps/registry               1         1         1            1           50s
kube-system          deployment.apps/hostpath-provisioner   1         1         1            1           51s
kube-system          deployment.apps/kube-dns               1         1         1            0           56s

NAMESPACE            NAME                                             DESIRED   CURRENT   READY     AGE
container-registry   replicaset.apps/registry-6bc95dfd76              1         1         1         41s
kube-system          replicaset.apps/hostpath-provisioner-9979c7f64   1         1         1         41s
kube-system          replicaset.apps/kube-dns-864b8bdc77              1         1         0         41s
```

## Setup environment for FMP to work

```bash
microk8s.kubectl config view --raw > /tmp/kubeconfig
```

## Deploy application

```bash
export KUBECONFIG=/tmp/kubeconfig
./mvnw clean package fabric8:build fabric8:push fabric8:deploy 
```

Make sure the application was deployed be executing:

```bash
microk8s.kubectl get pod -l app=sb-fmp-microk8s
```

It should look something like:

```
NAME                               READY     STATUS    RESTARTS   AGE
sb-fmp-microk8s-5fbb7646dc-66t7b   1/1       Running   0          57s
```

You can also see the service in action by issuing:

```bash
curl http://localhost:32222
```

An integration test can also be run against the service which is deployed inside the cluster by executing:

```bash
./mvnw verify -Pit -Dfabric8.skip
```


