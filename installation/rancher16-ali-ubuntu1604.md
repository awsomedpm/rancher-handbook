# 阿里云使用Ubuntu16.04部署Rancher1.6

## 主机信息 2c 8g

47.93.54.209  Rancher master
47.93.57.22   Rancher node

```
# cat /etc/os-release
NAME="Ubuntu"
VERSION="16.04.6 LTS (Xenial Xerus)"
```
## 安装docker环境

[docker版本适用对比](https://rancher.com/docs/rancher/v1.6/zh/hosts/#docker%E7%89%88%E6%9C%AC%E9%80%82%E7%94%A8%E5%AF%B9%E6%AF%94)

在每台主机上运行以下命令安装docker环境

```
curl https://releases.rancher.com/install-docker/17.06.sh | sh
```

## Rancher1.6 环境搭建

```
sudo docker run -d --restart=unless-stopped -p 8080:8080 rancher/server
```

Rancher1.6 控制台访问地址：
http://47.93.54.209:8080

## 基本配置

### 权限配置

1. 系统管理---》访问控制
2. 选择本地认证
3. 输入管理员用户名和密码

登录用户名:admin
登录密码：CAdemo123

### 设置主机注册地址

要填写公网IP或者域名。

http://47.93.54.209:8080

注：不要填写127.0.0.1或者localhost这种地址

## 添加主机

选custom图标

* 第3项给主机上增加标签（可选）
* 第4项输入用于注册这台主机的公网IP。
* 第5项会自动生成需要在主机上执行的脚本，点击右边的复制图标，将复制的脚本拷贝到要注册的主机上执行即可。
