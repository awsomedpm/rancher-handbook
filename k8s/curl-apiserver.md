# 使用 curl 访问 k8s apiserver

## 使用ServiceAccount Token的方式访问apiserver

### 创建 serviceaccount

```
$ kubectl -n kube-system create serviceaccount curl
serviceaccount/curl created
```

### 创建  clusterrolebinding

```
$ kubectl create clusterrolebinding curl --clusterrole cluster-admin --serviceaccount=kube-system:curl
clusterrolebinding.rbac.authorization.k8s.io/curl created

```

### 查看 serviceaccount 详情

```
$ kubectl describe sa  curl -n kube-system
Name:                curl
Namespace:           kube-system
Labels:              <none>
Annotations:         <none>
Image pull secrets:  <none>
Mountable secrets:   curl-token-nllbz
Tokens:              curl-token-nllbz
Events:              <none>
```

### 根据创建serviceaccount对应的 secret 获取token

```
$ kubectl get secret curl-token-nllbz -n kube-system -o jsonpath={".data.token"} | base64 --decode
eyJhbGciOiJSUzI1NiIsImtpZCI6IiJ9.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJrdWJlLXN5c3RlbSIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJjdXJsLXRva2VuLW5sbGJ6Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQubmFtZSI6ImN1cmwiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC51aWQiOiJlZjg3MDFjMS03N2JmLTExZTktODAyYy01MjU0MDA1OTk4OGIiLCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6a3ViZS1zeXN0ZW06Y3VybCJ9.wHrbrBbJ5cbXBv24oGz70jz1gTsfDNqwjTB6M0WgG7Qgr9hOntJzbKApOP_CsXh0sVURQUbZG_OeJ0jr86f1_Kd80bQFGIUmytOowP32MjhQNcrpv1YnEnpe6-bJnLx5C1HqSabrBkil_0upxhhVYqZgwtDuNpbmLdsDl_vUd3k446hZ2sRktCn1R0jE5nlqKL3dvPToSyzgZCG85Y0UgXqiTjC3VE3rdbmur1ayhg7ZUA_2RuJ849WUsGyXHt0Dbfm5O6WbuGTv-ZyMrbUxO6kzIKOFEL_a8uB7mlopSBk9bqvRUJP931AEG66KkS3aLbSHqv619wuQ7BlHcmX4RQ
```

### curl使用该token访问apiserver


curl -k -H 'Authorization: Bearer token' https://apiserver-ip:6443/


```
$ kubectl get secret curl-token-nllbz -n kube-system -o jsonpath={".data.token"} | base64 --decode
eyJhbGciOiJSUzI1NiIsImtpZCI6IiJ9.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJrdWJlLXN5c3RlbSIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJjdXJsLXRva2VuLW5sbGJ6Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQubmFtZSI6ImN1cmwiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC51aWQiOiJlZjg3MDFjMS03N2JmLTExZTktODAyYy01MjU0MDA1OTk4OGIiLCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6a3ViZS1zeXN0ZW06Y3VybCJ9.wHrbrBbJ5cbXBv24oGz70jz1gTsfDNqwjTB6M0WgG7Qgr9hOntJzbKApOP_CsXh0sVURQUbZG_OeJ0jr86f1_Kd80bQFGIUmytOowP32MjhQNcrpv1YnEnpe6-bJnLx5C1HqSabrBkil_0upxhhVYqZgwtDuNpbmLdsDl_vUd3k446hZ2sRktCn1R0jE5nlqKL3dvPToSyzgZCG85Y0UgXqiTjC3VE3rdbmur1ayhg7ZUA_2RuJ849WUsGyXHt0Dbfm5O6WbuGTv-ZyMrbUxO6kzIKOFEL_a8uB7mlopSBk9bqvRUJP931AEG66KkS3aLbSHqv619wuQ7BlHcmX4RQ

$ curl -k -H 'Authorization: Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IiJ9.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJrdWJlLXN5c3RlbSIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJjdXJsLXRva2VuLW5sbGJ6Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZXJ2aWNlLWFjY291bnQubmFtZSI6ImN1cmwiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC51aWQiOiJlZjg3MDFjMS03N2JmLTExZTktODAyYy01MjU0MDA1OTk4OGIiLCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6a3ViZS1zeXN0ZW06Y3VybCJ9.wHrbrBbJ5cbXBv24oGz70jz1gTsfDNqwjTB6M0WgG7Qgr9hOntJzbKApOP_CsXh0sVURQUbZG_OeJ0jr86f1_Kd80bQFGIUmytOowP32MjhQNcrpv1YnEnpe6-bJnLx5C1HqSabrBkil_0upxhhVYqZgwtDuNpbmLdsDl_vUd3k446hZ2sRktCn1R0jE5nlqKL3dvPToSyzgZCG85Y0UgXqiTjC3VE3rdbmur1ayhg7ZUA_2RuJ849WUsGyXHt0Dbfm5O6WbuGTv-ZyMrbUxO6kzIKOFEL_a8uB7mlopSBk9bqvRUJP931AEG66KkS3aLbSHqv619wuQ7BlHcmX4RQ' https://apiserver-ip:6443/
{
  "paths": [
    "/api",
    "/api/v1",
    "/apis",
    "/apis/",
    "/apis/admissionregistration.k8s.io",
    "/apis/admissionregistration.k8s.io/v1beta1",
    "/apis/apiextensions.k8s.io",
    "/apis/apiextensions.k8s.io/v1beta1",
    "/apis/apiregistration.k8s.io",
    "/apis/apiregistration.k8s.io/v1",
    "/apis/apiregistration.k8s.io/v1beta1",
    "/apis/apps",
    "/apis/apps/v1",
    "/apis/apps/v1beta1",
    "/apis/apps/v1beta2",
    "/apis/authentication.k8s.io",
    "/apis/authentication.k8s.io/v1",
    "/apis/authentication.k8s.io/v1beta1",
    "/apis/authorization.k8s.io",
    "/apis/authorization.k8s.io/v1",
    "/apis/authorization.k8s.io/v1beta1",
    "/apis/autoscaling",
    "/apis/autoscaling/v1",
    "/apis/autoscaling/v2beta1",
    "/apis/autoscaling/v2beta2",
    "/apis/batch",
    "/apis/batch/v1",
    "/apis/batch/v1beta1",
    "/apis/certificates.k8s.io",
    "/apis/certificates.k8s.io/v1beta1",
    "/apis/cluster.cattle.io",
    "/apis/cluster.cattle.io/v3",
    "/apis/coordination.k8s.io",
    "/apis/coordination.k8s.io/v1beta1",
    "/apis/crd.projectcalico.org",
    "/apis/crd.projectcalico.org/v1",
    "/apis/events.k8s.io",
    "/apis/events.k8s.io/v1beta1",
    "/apis/extensions",
    "/apis/extensions/v1beta1",
    "/apis/metrics.k8s.io",
    "/apis/metrics.k8s.io/v1beta1",
    "/apis/monitoring.coreos.com",
    "/apis/monitoring.coreos.com/v1",
    "/apis/networking.k8s.io",
    "/apis/networking.k8s.io/v1",
    "/apis/policy",
    "/apis/policy/v1beta1",
    "/apis/rbac.authorization.k8s.io",
    "/apis/rbac.authorization.k8s.io/v1",
    "/apis/rbac.authorization.k8s.io/v1beta1",
    "/apis/scheduling.k8s.io",
    "/apis/scheduling.k8s.io/v1beta1",
    "/apis/storage.k8s.io",
    "/apis/storage.k8s.io/v1",
    "/apis/storage.k8s.io/v1beta1",
    "/healthz",
    "/healthz/autoregister-completion",
    "/healthz/etcd",
    "/healthz/log",
    "/healthz/ping",
    "/healthz/poststarthook/apiservice-openapi-controller",
    "/healthz/poststarthook/apiservice-registration-controller",
    "/healthz/poststarthook/apiservice-status-available-controller",
    "/healthz/poststarthook/bootstrap-controller",
    "/healthz/poststarthook/ca-registration",
    "/healthz/poststarthook/generic-apiserver-start-informers",
    "/healthz/poststarthook/kube-apiserver-autoregistration",
    "/healthz/poststarthook/rbac/bootstrap-roles",
    "/healthz/poststarthook/scheduling/bootstrap-system-priority-classes",
    "/healthz/poststarthook/start-apiextensions-controllers",
    "/healthz/poststarthook/start-apiextensions-informers",
    "/healthz/poststarthook/start-kube-aggregator-informers",
    "/healthz/poststarthook/start-kube-apiserver-admission-initializer",
    "/logs",
    "/metrics",
    "/openapi/v2",
    "/swagger-2.0.0.json",
    "/swagger-2.0.0.pb-v1",
    "/swagger-2.0.0.pb-v1.gz",
    "/swagger.json",
    "/swaggerapi",
    "/version"
  ]
}
```
