# Helm 简介

Helm 是 Kubernetes 包管理工具，可以方便地发现、共享和使用为Kubernetes构建的应用。

## 常用资源链接

[Helm 官网](https://helm.sh/)

[Helm 官方文档](https://helm.sh/docs/)

[Helm 官方文档中文翻译](https://github.com/whmzsu/helm-doc-zh-cn)

[Helm 官方仓库](https://hub.helm.sh/)
Helm 官方仓库提供了包含有最佳实践的 chart 包

[Helm on Github](https://github.com/helm/helm)

[Helm Charts](https://github.com/helm/charts)

[Awesome Helm](https://github.com/cdwv/awesome-helm)

## Helm 是什么？

* Helm 可以帮助我们管理Kubernetes应用 --- Helm Charts 可以帮我们定义、安装和升级非常复杂的 Kubernetes 应用
* Helm Chart 易于创建、版本化、分享和发布， 使用 Helm 就不用大量的拷贝粘贴了。
* Helm 的最新版本已由CNCF维护

## 为什么要用Helm

* 管理复杂的应用部署
* 升级更容易
* 便于分享
* 可以快速回滚

## Helm 基本概念

Helm 是Kubernetes 的包管理工具，可以方便地发现、共享和使用为Kubernetes构建的应用，它包含几个基本概念

* Chart：一个 Helm 包，其中包含了运行一个应用所需要的镜像、依赖和资源定义等，还可能包含 Kubernetes 集群中的服务定义
* Release: 在 Kubernetes 集群上运行的 Chart 的一个实例。在同一个集群上，一个 Chart 可以安装很多次。每次安装都会创建一个新的 release。每次安装都会生成自己的 Release，会有自己的 Release 名称。
* Repository：用于发布和存储 Chart 的仓库。

## Helm 组件

Helm 有两个主要部分：

Helm Client 是最终用户的命令行客户端。客户端负责以下部分：

* 本地 chart 开发
* 管理存储库
* 与 Tiller 服务交互
* 发送要安装的 chart
* 查询有关发布的信息
* 请求升级或卸载现有 release

Tiller Server 是一个集群内服务，与 Helm 客户端进行交互，并与 Kubernetes API 服务进行交互。服务负责以下内容：

* 监听来自 Helm 客户端的传入请求
* 结合 chart 和配置来构建发布
* 将 chart 安装到 Kubernetes 中，然后跟踪后续 release
* 通过与 Kubernetes 交互来升级和卸载 chart

简而言之，客户端负责管理 chart，而服务端负责管理 release。

## 部署

Helm 客户端使用 Go 编程语言编写，并使用 gRPC 协议套件与 Tiller 服务进行交互。

Tiller 服务也用 Go 编写。它提供了一个与客户端连接的 gRPC 服务，它使用 Kubernetes 客户端库与 Kubernetes 进行通信。目前，该库使用 REST + JSON。

Tiller 服务将信息存储在位于 Kubernetes 内的 ConfigMaps 中。它不需要自己的数据库。

如有可能，配置文件用YAML编写。

## Helm 命令

```
$ helm -h
The Kubernetes package manager

To begin working with Helm, run the 'helm init' command:

	$ helm init

This will install Tiller to your running Kubernetes cluster.
It will also set up any necessary local configuration.

Common actions from this point include:

- helm search:    search for charts
- helm fetch:     download a chart to your local directory to view
- helm install:   upload the chart to Kubernetes
- helm list:      list releases of charts

Environment:
  $HELM_HOME           set an alternative location for Helm files. By default, these are stored in ~/.helm
  $HELM_HOST           set an alternative Tiller host. The format is host:port
  $HELM_NO_PLUGINS     disable plugins. Set HELM_NO_PLUGINS=1 to disable plugins.
  $TILLER_NAMESPACE    set an alternative Tiller namespace (default "kube-system")
  $KUBECONFIG          set an alternative Kubernetes configuration file (default "~/.kube/config")
  $HELM_TLS_CA_CERT    path to TLS CA certificate used to verify the Helm client and Tiller server certificates (default "$HELM_HOME/ca.pem")
  $HELM_TLS_CERT       path to TLS client certificate file for authenticating to Tiller (default "$HELM_HOME/cert.pem")
  $HELM_TLS_KEY        path to TLS client key file for authenticating to Tiller (default "$HELM_HOME/key.pem")
  $HELM_TLS_ENABLE     enable TLS connection between Helm and Tiller (default "false")
  $HELM_TLS_VERIFY     enable TLS connection between Helm and Tiller and verify Tiller server certificate (default "false")
  $HELM_TLS_HOSTNAME   the hostname or IP address used to verify the Tiller server certificate (default "127.0.0.1")
  $HELM_KEY_PASSPHRASE set HELM_KEY_PASSPHRASE to the passphrase of your PGP private key. If set, you will not be prompted for
                       the passphrase while signing helm charts

Usage:
  helm [command]

Available Commands:
  completion  Generate autocompletions script for the specified shell (bash or zsh)
  create      create a new chart with the given name
  delete      given a release name, delete the release from Kubernetes
  dependency  manage a chart's dependencies
  fetch       download a chart from a repository and (optionally) unpack it in local directory
  get         download a named release
  help        Help about any command
  history     fetch release history
  home        displays the location of HELM_HOME
  init        initialize Helm on both client and server
  inspect     inspect a chart
  install     install a chart archive
  lint        examines a chart for possible issues
  list        list releases
  package     package a chart directory into a chart archive
  plugin      add, list, or remove Helm plugins
  repo        add, list, remove, update, and index chart repositories
  reset       uninstalls Tiller from a cluster
  rollback    roll back a release to a previous revision
  search      search for a keyword in charts
  serve       start a local http web server
  status      displays the status of the named release
  template    locally render templates
  test        test a release
  upgrade     upgrade a release
  verify      verify that a chart at the given path has been signed and is valid
  version     print the client/server version information

Flags:
      --debug                           enable verbose output
  -h, --help                            help for helm
      --home string                     location of your Helm config. Overrides $HELM_HOME (default "/Users/william/.helm")
      --host string                     address of Tiller. Overrides $HELM_HOST
      --kube-context string             name of the kubeconfig context to use
      --kubeconfig string               absolute path to the kubeconfig file to use
      --tiller-connection-timeout int   the duration (in seconds) Helm will wait to establish a connection to tiller (default 300)
      --tiller-namespace string         namespace of Tiller (default "kube-system")

Use "helm [command] --help" for more information about a command.
```

## 安装

### helm安装

#### Homebrew (macOS)

macOS 系统可以用 brew 命令进行安装

```
brew install kubernetes-helm

```

#### 脚本安装

```
$ curl https://raw.githubusercontent.com/helm/helm/master/scripts/get > get_helm.sh
$ chmod 700 get_helm.sh
$ ./get_helm.sh
```

### 安装 Tiller

### 配置 Helm 客户端访问权限

Helm在集群上安装`tiller`服务以管理`charts`. 由于RKE默认启用RBAC, 因此我们需要使用`kubectl`来创建一个`serviceaccount`，`clusterrolebinding`才能让`tiller`具有部署到集群的权限。

- 在kube-system命名空间中创建`ServiceAccount`；

- 创建`ClusterRoleBinding`以授予tiller帐户对集群的访问权限

- `helm`初始化`tiller`服务

```bash
  kubectl -n kube-system create serviceaccount tiller
  kubectl create clusterrolebinding tiller --clusterrole cluster-admin --serviceaccount=kube-system:tiller
```

使用阿里云的镜像和chart仓库，避免网络问题

```shell

# 安装 Tiller ($TILLER_TAG 改为和 helm version 版本一致)
$ helm init --service-account tiller --tiller-image registry.cn-shanghai.aliyuncs.com/rancher/tiller:$TILLER_TAG --stable-repo-url https://kubernetes.oss-cn-hangzhou.aliyuncs.com/charts

```

示例：

```
$ helm version
Client: &version.Version{SemVer:"v2.13.1", GitCommit:"618447cbf203d147601b4b9bd7f8c37a5d39fbb4", GitTreeState:"clean"}

$ helm init --service-account tiller --tiller-image registry.cn-shanghai.aliyuncs.com/rancher/tiller:v2.13.1 --stable-repo-url https://kubernetes.oss-cn-hangzhou.aliyuncs.com/charts

```

### 查看tiller部署情况

```
$ kubectl get deployment tiller-deploy --namespace kube-system
NAME            READY   UP-TO-DATE   AVAILABLE   AGE
tiller-deploy   1/1     1            1           14m
```

### 删除或重新安装 Tiller

推荐删除 Tiller 的方法是使用

```
kubectl delete deployment tiller-deploy --namespace kube-system
```

或执行

```
$ helm reset
Tiller (the Helm server-side component) has been uninstalled from your Kubernetes Cluster.
```



## 使用

### 添加 Chart 仓库地址

```shell
$ helm repo add rancher-latest https://releases.rancher.com/server-charts/latest

$ helm repo add bitnami https://charts.bitnami.com
```

### 查找可用的chart

```
$ helm search
NAME                          	CHART VERSION	APP VERSION  	DESCRIPTION
rancher-latest/rancher        	2.2.2        	v2.2.2       	Install Rancher Server to manage Kubernetes clusters acro...
stable/acs-engine-autoscaler  	2.1.3        	2.1.1        	Scales worker nodes within agent pools
stable/aerospike              	0.1.7        	v3.14.1.2    	A Helm chart for Aerospike in Kubernetes
stable/anchore-engine         	0.1.3        	0.1.6        	Anchore container analysis and policy evaluation engine s...
stable/artifactory            	7.0.3        	5.8.4        	Universal Repository Manager supporting all major packagi...

...

```

### 查找指定 Charts

```
$ helm search wordpress
NAME            	CHART VERSION	APP VERSION	DESCRIPTION
stable/wordpress	0.8.8        	4.9.4      	Web publishing platform for building blogs and websites.
```

### 查看 Charts 详细信息

```
$ helm inspect stable/wordpress
```

###  查看charts默认配置

```
$ helm inspect values stable/wordpress

```

### 安装 Charts

安装 Charts 发布名称为： `my-release`

```console
$ helm install --name my-release stable/wordpress

helm install --name my-redis-release -f ./values.yaml stable/redis
```

### 查看发布

```
$ helm list
```

## 卸载 Chart

卸载名为 `my-release` 发布

```console
$ helm delete my-release
```


## 开发模板


## 参考资料

[kubernetes之helm简介、安装、配置、使用指南](https://blog.csdn.net/bbwangj/article/details/81087911)

[Helm模版开发文档](https://blog.csdn.net/qq_24095941/article/details/88126207)

[Helm 入门指南](https://mp.weixin.qq.com/s?__biz=MzI3MTI2NzkxMA==&mid=2247486154&idx=1&sn=becd5dd0fadfe0b6072f5dfdc6fdf786&chksm=eac52be3ddb2a2f555b8b1028db97aa3e92d0a4880b56f361e4b11cd252771147c44c08c8913&mpshare=1&scene=24&srcid=0927K11i8Vke44AuSuNdFclU#rd)
