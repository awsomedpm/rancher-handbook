# centos7 安装


## 国内用户安装 kubectl

k8s官网给的yum源国内访问不了，替换成阿里的yum源

`
### 配置阿里的yum源

```
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=http://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=0
repo_gpgcheck=0
gpgkey=http://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg
        http://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF
```

### 使用 `yum install` 安装 kubectl

```
yum install -y kubectl
```
