# ucloud 上快速部署rancher

##

[Rancher 快速入门]（https://www.cnrancher.com/quick-start/）

## 准备两台云主机

rancher 2核4G内存

Kubernetes 	2核8G内存

### 查看系统版本

```
# cat /etc/centos-release
CentOS Linux release 7.5.1804 (Core)
```

### 安装docker环境

两台云主机上分别运行以下脚本安装docker和优化系统

#### 运行docker安装脚本

[18.09.sh](https://releases.rancher.com/install-docker/18.09.sh)

```
# curl https://releases.rancher.com/install-docker/18.09.sh | bash -
```
#### 运行系统优化脚本

[updates-centos7.sh](update-centos7.sh)

```
# curl https://dclingcloud.github.io/rancher-in-action/installation/update-centos7.sh  | bash -
```
同时创建 rancher 普通用户并将其加入docker组


## 使用rancher用户运行Rancher Server

```
# su - rancher
$ sudo docker run -d -v /data/var/lib/rancher/:/var/lib/rancher/ --restart=unless-stopped -p 80:80 -p 443:443 rancher/rancher:stable
```

### 查看 Rancher Server 容器运行情况

```
$ docker ps
CONTAINER ID        IMAGE                    COMMAND             CREATED             STATUS              PORTS                                      NAMES
695862314d56        rancher/rancher:stable   "entrypoint.sh"     26 minutes ago      Up 26 minutes       0.0.0.0:80->80/tcp, 0.0.0.0:443->443/tcp   mystifying_matsumoto
```

一旦Rancher Server容器运行起来，就可以通过 https://<server_ip> 访问 Rancher UI。

## 使用rancher创建k8s集群

登录rancher 管理界面
选择添加集群 选择Custom方式 （From my own existing nodes）

输入集群名后点击下一步

选择 Node Role

这三项全部选上

* etcd  
* Control Plane  
* Worker

按提示在Kubernetes节点机 切换到rancher用户执行界面上生成的命令

```
# su - rancher
sudo docker run -d --privileged --restart=unless-stopped --net=host -v /etc/kubernetes:/etc/kubernetes -v /var/run:/var/run rancher/rancher-agent:v2.2.2 --server https://urancher.dclingcloud.cn --token bx6zsjsh8xrvzc94c7s8n92cqk28jl6fctwnlxtn9xpbwdl5qkvgkj --ca-checksum e61427499702ec11b4fb8459c81d402365c0e30de46b06d5dc4cdfee3d01286f --etcd --controlplane --worker
```

 等一会 集群状态变为绿色的 Active 就可以了。
