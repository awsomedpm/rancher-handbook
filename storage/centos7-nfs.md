# Centos7 搭建 NFS

## 实验环境：

虚拟机：

* 172.16.33.98     NFS 服务器端
* 172.16.33.101    NFS 客户端

操作系统：

```
# cat /etc/centos-release
CentOS Linux release 7.5.1804 (Core)
```

## nfs服务器端安装

### 安装 nfs-utils rpcbind

```
yum -y install nfs-utils rpcbind
```

### 查看rpc服务是否自动启动

rpc监听在111端口，

```
ss -tnulp | grep 111
```

查看rpc服务是否自动启动，如果没有启动，使用以下命令启动

```
systemctl start rpcbind
```

启动rpc服务。

### 查看 nfs-utils 是否安装好

```
rpm -qa nfs-utils
```

### 编辑/etc/exports ，添加以下内容

```
vim /etc/exports

/mynfs    172.16.0.0/16(rw,async)
```

### 添加nfs服务到开机启动服务

```
systemctl enable nfs-server.service
```

### 启动nfs服务

```
systemctl start nfs-server.service
```

### 查看 rpc 服务信息

```
# rpcinfo -p 172.16.33.98
   program vers proto   port  service
    100000    4   tcp    111  portmapper
    100000    3   tcp    111  portmapper
    100000    2   tcp    111  portmapper
    100000    4   udp    111  portmapper
    100000    3   udp    111  portmapper
    100000    2   udp    111  portmapper
    100024    1   udp  38431  status
    100024    1   tcp  40990  status
    100005    1   udp  20048  mountd
    100005    1   tcp  20048  mountd
    100005    2   udp  20048  mountd
    100005    2   tcp  20048  mountd
    100005    3   udp  20048  mountd
    100005    3   tcp  20048  mountd
    100003    3   tcp   2049  nfs
    100003    4   tcp   2049  nfs
    100227    3   tcp   2049  nfs_acl
    100003    3   udp   2049  nfs
    100003    4   udp   2049  nfs
    100227    3   udp   2049  nfs_acl
    100021    1   udp  39869  nlockmgr
    100021    3   udp  39869  nlockmgr
    100021    4   udp  39869  nlockmgr
    100021    1   tcp  35667  nlockmgr
    100021    3   tcp  35667  nlockmgr
    100021    4   tcp  35667  nlockmgr
```

### 创建目录

```
mkdir -p /mynfs
```

### 创建测试文件


```

    touch /mynfs/test.log

    echo "nfs server" >> /mynfs/test.log

    chown -R nfsnobody.nfsnobody /mynfs
```

## nfs 客户端

```
yum -y install nfs-utils rpcbind
```

### 检测rpc是否启动

```
# showmount -e 172.16.33.98
Export list for 172.16.33.98:
/mynfs 172.16.0.0/16
```

### 挂载至本地/mnt/nfs目录

mount -t nfs 172.16.33.98:/mynfs  /mnt/nfs

### 卸载/mnt/nfs目录

```
umount  /mnt/nfs
```
