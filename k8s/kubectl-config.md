# kubectl 连接多个 kubernetes 集群的配置

## 使用场景

我们在实际生产中可能会有多个kubernetes集群，我们可能需要配置kubectl访问多个集群。

## 生成融合配置文件

本例演示两个集群的配置文件(config)文件，在控制台执行命令:

KUBECONFIG=第一个配置文件:第二个配置文件 kubectl config view --flatten

这时控制台会输出融合后的配置内容，复制配置内容覆盖原有的$HOME/.kube/config.

例子：

```
$ KUBECONFIG=dev01:dev02 kubectl config view --flatten > ~/.kube/config
```

## 查看集群信息

```
kubectl config view
```

## 查看当前默认集群

```
$ kubectl config current-context
dev01
```

## 连接到指定集群:

```
kubectl --context dev01 get nodes  
```

此处的 dev01 为config文件中contexts.context.name属性, 可从 kubectl config view 命令中看到.


## 修改当前默认集群

```
kubectl config use-context dev02
```
