# 部署 kube-state-metrics

[GitHub 项目地址](https://github.com/kubernetes/kube-state-metrics)
https://github.com/kubernetes/kube-state-metrics

## 检查当前集群中是否部署 kube-state-metrics

```
kubectl get pods --namespace=kube-system | grep kube-state

```

## 从github上拉取kube-state-metrics项目

```
git clone https://github.com/kubernetes/kube-state-metrics
```

## 部署kube-state-metrics到Kubernetes集群

```

kubectl apply -f kube-state-metrics/kubernetes
kubectl get pods --namespace=kube-system | grep kube-state

```
