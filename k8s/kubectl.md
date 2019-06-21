# Kubectl

## 查看版本信息

```
$ kubectl version
Client Version: version.Info{Major:"1", Minor:"14", GitVersion:"v1.14.0", GitCommit:"641856db18352033a0d96dbc99153fa3b27298e5", GitTreeState:"clean", BuildDate:"2019-03-26T00:05:06Z", GoVersion:"go1.12.1", Compiler:"gc", Platform:"darwin/amd64"}
Server Version: version.Info{Major:"1", Minor:"13", GitVersion:"v1.13.5", GitCommit:"2166946f41b36dea2c4626f90a77706f426cdea2", GitTreeState:"clean", BuildDate:"2019-03-25T15:19:22Z", GoVersion:"go1.11.5", Compiler:"gc", Platform:"linux/amd64"}
```

## 查看集群信息

```
$ kubectl cluster-info
```

## 获取集群状态

```
$ kubectl get cs
NAME                 STATUS    MESSAGE              ERROR
controller-manager   Healthy   ok
scheduler            Healthy   ok
etcd-0               Healthy   {"health": "true"}
```

## 连接Kubernetes的配置信息

kubectl 连接Kubernetes的配置信息存放在文件 ~/.kube/config

可以包含多个Kubernetes集群的信息，使用某个集群时可以切换 context

## 查看 kubectl 连接 Kubernetes 集群的 context

```
$ kubectl config get-contexts
CURRENT   NAME                     CLUSTER                      AUTHINFO             NAMESPACE
*         docker-for-desktop       docker-for-desktop-cluster   docker-for-desktop
          myk8s001                 myk8s001                     user-xkxhs
          myk8s001-test-node-001   myk8s001-test-node-001       user-xkxhs
```



## 切换context(切换到docker-for-desktop)

```

$ kubectl config use-context myk8s001
Switched to context "myk8s001".

```

## 查看集群节点机信息

```
$ kubectl get nodes
NAME                 STATUS   ROLES    AGE   VERSION
docker-for-desktop   Ready    master   6d    v1.10.11
```

## 查看集群所有命名空间下的 pod 信息

```
$ kubectl get pods --all-namespaces
```

## 查看集群指定命名空间下的 pod 信息

```
$ kubectl get pods --namespace apm
NAME                        READY   STATUS    RESTARTS   AGE
detector-65f7c4d569-xqbt2   1/1     Running   0          6d1h
fusion-58ff8549bb-8j5ls     1/1     Running   0          6d1h
nginx-5cccd9d786-pp8tx      1/1     Running   0          6h34m
reactor-8c9b7b5c4-z9w65     1/1     Running   0          6d1h
receiver-685c8fc5b6-j7cql   1/1     Running   0          6d1h
```
或简写为
```
$ kubectl get pods -n apm
NAME                        READY   STATUS    RESTARTS   AGE
detector-65f7c4d569-xqbt2   1/1     Running   0          6d1h
fusion-58ff8549bb-8j5ls     1/1     Running   0          6d1h
nginx-5cccd9d786-pp8tx      1/1     Running   0          6h34m
reactor-8c9b7b5c4-z9w65     1/1     Running   0          6d1h
receiver-685c8fc5b6-j7cql   1/1     Running   0          6d1h
```

## 查看pod详情

```
kubectl describe pods detector-65f7c4d569-xqbt2 -n apm
```

## 获取指定命名空间的服务

```
$ kubectl get svc -n apm
NAME                TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)                                        AGE
detector            ClusterIP   None            <none>        42/TCP                                         6d1h
fusion              ClusterIP   10.43.172.182   <none>        6001/TCP,3000/TCP                              6d1h
fusion-nodeport     NodePort    10.43.255.88    <none>        6001:31015/TCP,3000:31014/TCP                  6d1h
nginx               ClusterIP   10.43.74.50     <none>        80/TCP,10443/TCP                               6d1h
nginx-nodeport      NodePort    10.43.247.192   <none>        80:30000/TCP,10443:30443/TCP                   6d1h
reactor             ClusterIP   None            <none>        42/TCP                                         6d1h
receiver            ClusterIP   10.43.5.206     <none>        3001/TCP,3002/UDP,3003/TCP                     6d1h
receiver-nodeport   NodePort    10.43.175.199   <none>        3001:31011/TCP,3002:31012/UDP,3003:31013/TCP   6d1h
```

## 查看API

```
$  kubectl api-versions
admissionregistration.k8s.io/v1beta1
apiextensions.k8s.io/v1beta1
apiregistration.k8s.io/v1
apiregistration.k8s.io/v1beta1
apps/v1
apps/v1beta1
apps/v1beta2
authentication.k8s.io/v1
authentication.k8s.io/v1beta1
authorization.k8s.io/v1
authorization.k8s.io/v1beta1
autoscaling/v1
autoscaling/v2beta1
autoscaling/v2beta2
batch/v1
batch/v1beta1
certificates.k8s.io/v1beta1
cluster.cattle.io/v3
coordination.k8s.io/v1beta1
crd.projectcalico.org/v1
events.k8s.io/v1beta1
extensions/v1beta1
metrics.k8s.io/v1beta1
monitoring.coreos.com/v1
networking.k8s.io/v1
policy/v1beta1
rbac.authorization.k8s.io/v1
rbac.authorization.k8s.io/v1beta1
scheduling.k8s.io/v1beta1
storage.k8s.io/v1
storage.k8s.io/v1beta1
v1
```

##

```

$ kubectl config view
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: DATA+OMITTED
    server: https://rancher.vapicloud.com/k8s/clusters/c-rzsr8
  name: myk8s02
- cluster:
    certificate-authority-data: DATA+OMITTED
    server: https://106.75.25.178:6443
  name: myk8s02-k8s-master-node
contexts:
- context:
    cluster: myk8s02
    user: user-xkxhs
  name: myk8s02
- context:
    cluster: myk8s02-k8s-master-node
    user: user-xkxhs
  name: myk8s02-k8s-master-node
current-context: myk8s02
kind: Config
preferences: {}
users:
- name: user-xkxhs
  user:
    token: kubeconfig-user-xkxhs.c-rzsr8:n6pl78qrwftpbt6x225xgnnttm49hb2jjcx7klfjfgcdc76h6gm7cz
mybook:tmp william$
```
