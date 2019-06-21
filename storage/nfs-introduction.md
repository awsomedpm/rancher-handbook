# NFS 简介

## 什么是NFS？

NFS 是Network File System的缩写，即网络文件系统。
NFS在文件传送或信息传送过程中依赖于RPC协议。RPC，远程过程调用 (Remote Procedure Call) 是能使客户端执行其他系统中程序的一种机制。
NFS本身就是使用RPC的一个程序。所以只要用到NFS的地方都要启动RPC服务，不论是NFS SERVER或者NFS CLIENT。这样SERVER和CLIENT才能通过RPC来实现PROGRAM PORT的对应。可以这么理解RPC和NFS的关系：NFS是一个文件系统，而RPC是负责负责信息的传输。

## NFS的挂载原理

NFS分为客户端与服务器端，一般设置为一个Server端，多个客户端。 当服务器端设置好共享目录 /mynfs 后，客户端通过相应的访问权限，将共享目录挂载到本地系统的某个目录下，就可以透明的看到共享目录里的文件了，依据服务器制定的相应权限做操作。

## NFS服务器与客户端的通信原理

客户端NFS和服务端NFS通讯过程

1.  首先服务器端启动RPC服务，并开启111端口
2.  启动NFS服务，并向RPC注册端口信息
3.  客户端启动RPC（portmap服务），向服务端的RPC(portmap)服务请求服务端的NFS端口
4.  服务端的RPC(portmap)服务反馈NFS端口信息给客户端。
5.  客户端通过获取的NFS端口来建立和服务端的NFS连接并进行数据的传输。

## NFS系统守护进程

-   nfsd：它是基本的NFS守护进程，主要功能是管理客户端是否能够登录服务器；
-   mountd：它是RPC安装守护进程，主要功能是管理NFS的文件系统。当客户端顺利通过nfsd登录NFS服务器后，在使用NFS服务所提供的文件前，还必须通过文件使用权限的验证。它会读取NFS的配置文件/etc/exports来对比客户端权限。
-   portmap：主要功能是进行端口映射工作。当客户端尝试连接并使用RPC服务器提供的服务（如NFS服务）时，portmap会将所管理的与服务对应的端口提供给客户端，从而使客户可以通过该端口向服务器请求服务。

## NFS的常用目录及常用命

-   /etc/exports NFS服务的主要配置文件
-   /usr/sbin/exportfs NFS服务的管理命令
-   /usr/sbin/showmount 客户端的查看命令
-   /var/lib/nfs/etab 记录NFS分享出来的目录的完整权限设定值
-   /var/lib/nfs/xtab 记录曾经登录过的客户端信息
    NFS服务的配置文件为 /etc/exports，这个文件是NFS的主要配置文件，不过系统并没有默认值，所以这个文件不一定会存在，可能要使用vim手动建立，然后在文件里面写入配置内容。

/etc/exports文件内容格式：

```
<输出目录> [客户端1 选项（访问权限,用户映射,其他）][客户端2 选项（访问权限,用户映射,其他）]
```

-   输出目录：
    输出目录是指NFS系统中需要共享给客户机使用的目录；

-   客户端：
    客户端是指网络中可以访问这个NFS输出目录的计算机

    客户端常用的指定方式：

    -   指定ip地址的主机：172.16.33.101
    -   指定子网中的所有主机：172.16.0.0/16 172.16.0.0/255.255.0.0
    -   指定域名的主机：client.example.cn
    -   指定域中的所有主机：*.example.cn
    -   所有主机：*

-   选项：

    选项用来设置输出目录的访问权限、用户映射等。

    NFS主要有3类选项：

    访问权限选项

    -   设置输出目录只读：ro
    -   设置输出目录读写：rw

    用户映射选项

    -   all_squash：将远程访问的所有普通用户及所属组都映射为匿名用户或用户组（nfsnobody）；
    -   no_all_squash：与all_squash取反（默认设置）；
    -   root_squash：将root用户及所属组都映射为匿名用户或用户组（默认设置）；
    -   no_root_squash：与rootsquash取反；
    -   anonuid=xxx：将远程访问的所有用户都映射为匿名用户，并指定该用户为本地用户（UID=xxx）；
    -   anongid=xxx：将远程访问的所有用户组都映射为匿名用户组账户，并指定该匿名用户组账户为本地用户组账户（GID=xxx）；

    其它选项:

    -   secure：限制客户端只能从小于1024的tcp/ip端口连接nfs服务器（默认设置）；
    -   insecure：允许客户端从大于1024的tcp/ip端口连接服务器；
    -   sync：将数据同步写入内存缓冲区与磁盘中，效率低，但可以保证数据的一致性；
    -   async：将数据先保存在内存缓冲区中，必要时才写入磁盘；
    -   wdelay：检查是否有相关的写操作，如果有则将这些写操作一起执行，这样可以提高效率（默认设置）；
    -   no_wdelay：若有写操作则立即执行，应与sync配合使用；
    -   subtree：若输出目录是一个子目录，则nfs服务器将检查其父目录的权限(默认设置)；
    -   no_subtree：即使输出目录是一个子目录，nfs服务器也不检查其父目录的权限，这样可以提高效率；


## 相关命令

### 1、exportfs

exportfs命令用来管理当前NFS共享的文件系统列表。

如果我们在启动了NFS之后又修改了/etc/exports，是不是还要重新启动nfs呢？这个时候我们就可以用exportfs 命令来使改动立刻生效，该命令格式如下：

```
    # exportfs -h
    usage: exportfs [-adfhioruvs] [host:/path]

    　　-a 全部挂载或卸载 /etc/exports中的内容
    　　-r 重新读取/etc/exports 中的信息 ，并同步更新/etc/exports、/var/lib/nfs/xtab
    　　-u 卸载单一目录（和-a一起使用为卸载所有/etc/exports文件中的目录）
    　　-v 显示共享目录 在export的时候，将详细的信息输出到屏幕上。
```

具体例子：

```
    # exportfs -au 卸载所有共享目录
    # exportfs -arv 服务端更改配置文件后，不重启服务，直接执行该命令就可以使更改后的配置文件生效。
```

注意： 在重启nfs服务之前需要先将所有挂载点卸载，否则将发生程序错误，严重者会拖垮系统。

示例：

```
# exportfs -arv
exporting 172.16.0.0/16:/mynfs/pv002
exporting 172.16.0.0/16:/mynfs
```

### 2、nfsstat

查看NFS的运行状态，对于调整NFS的运行有很大帮助。

示例：

```
# nfsstat
Server rpc stats:
calls      badcalls   badclnt    badauth    xdrcall
635        0          0          0          0

Server nfs v4:
null         compound
3         0% 632      99%

Server nfs v4 operations:
op0-unused   op1-unused   op2-future   access       close        commit
0         0% 0         0% 0         0% 52        3% 12        0% 0         0%
create       delegpurge   delegreturn  getattr      getfh        link
2         0% 0         0% 7         0% 395      23% 53        3% 0         0%
lock         lockt        locku        lookup       lookup_root  nverify
0         0% 0         0% 0         0% 36        2% 0         0% 0         0%
open         openattr     open_conf    open_dgrd    putfh        putpubfh
15        0% 0         0% 0         0% 0         0% 408      24% 0         0%
putrootfh    read         readdir      readlink     remove       rename
30        1% 3         0% 7         0% 0         0% 3         0% 0         0%
renew        restorefh    savefh       secinfo      setattr      setcltid
0         0% 0         0% 0         0% 0         0% 7         0% 0         0%
setcltidconf verify       write        rellockowner bc_ctl       bind_conn
0         0% 0         0% 2         0% 0         0% 0         0% 0         0%
exchange_id  create_ses   destroy_ses  free_stateid getdirdeleg  getdevinfo
3         0% 3         0% 2         0% 0         0% 0         0% 0         0%
getdevlist   layoutcommit layoutget    layoutreturn secinfononam sequence
0         0% 0         0% 0         0% 0         0% 15        0% 622      36%
set_ssv      test_stateid want_deleg   destroy_clid reclaim_comp
0         0% 0         0% 0         0% 2         0% 3         0%
```

### 3、rpcinfo

查看rpc执行信息，可以用于检测rpc运行情况的工具，利用rpcinfo -p 可以查看出RPC开启的端口所提供的程序有哪些。

示例：

```
# rpcinfo -p
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
    100021    1   udp  48207  nlockmgr
    100021    3   udp  48207  nlockmgr
    100021    4   udp  48207  nlockmgr
    100021    1   tcp  45400  nlockmgr
    100021    3   tcp  45400  nlockmgr
    100021    4   tcp  45400  nlockmgr
```

### 4、showmount

```
# showmount -h
Usage: showmount [-adehv]
       [--all] [--directories] [--exports]
       [--no-headers] [--help] [--version] [host]
```

```
　　-a 显示已经于客户端连接上的目录信息
　　-e IP或者hostname 显示此IP地址分享出来的目录
```

示例：

```
$ showmount -e 172.16.33.98
Exports list on 172.16.33.98:
/mynfs/pv002                        172.16.0.0/16
/mynfs                              172.16.0.0/16
```

### 5、netstat

```
netstat -ntulp

```

portmap 开启的是111

最后注意两点，虽然通过权限设置可以让普通用户访问，但是挂载的时候默认情况下只有root可以去挂载，普通用户可以执行sudo。

## 注意事项

NFS server 关机的时候一点要确保NFS服务关闭，没有客户端处于连接状态！通过 showmount -a 可以查看，如果有的话用kill killall pkill 来结束，（-9 强制结束）

## 参考信息

[NFS搭建、配置及故障排除详解](https://blog.csdn.net/qq_30256711/article/details/78463940)
