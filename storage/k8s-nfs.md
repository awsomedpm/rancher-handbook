# k8s 使用 NFS 持久化存储


## 准备工作：

### NFS server 端

#### 修改 /etc/exports 文件增加如下配置

```
vi /etc/exports

/mynfs/pv003    172.16.0.0/16(rw,async)
```

#### 创建共享目录

```
# mkdir -p /mynfs/pv003
```

#### 导出nfs配置

```
# exportfs -arv
```

## k8s 集群部署nginx服务

### 创建静态PV

编辑 pvc003.yaml 文件

```
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv003
spec:
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Recycle
  nfs:
    path: /mynfs/pv003
    server: 172.16.33.98
```

使用kubectl 执行 pv003.yaml

```    
$ kubectl apply -f pv003.yaml
persistentvolume/pv003 created
```

查看创建的PersistentVolume：

```
$ kubectl get pv
NAME    CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM            STORAGECLASS   REASON   AGE                                            133m
pv003   1Gi        RWO            Recycle          Available                                            3m6s
```

### 创建 namespace

创建名为 william 的 namespace

```
kubectl create namespace william

```

查看集群中的 namespace

```
$ kubectl get namespace
NAME               STATUS   AGE
apptrace-demo      Active   3d7h
cattle-logging     Active   3d8h
cattle-pipeline    Active   3d6h
cattle-system      Active   4d3h
default            Active   4d3h
ingress-nginx      Active   4d3h
kube-public        Active   4d3h
kube-system        Active   4d3h
mongodb            Active   4d3h
p-z26s7-pipeline   Active   3d6h
prometheus         Active   4d2h
test39080          Active   3d6h
william            Active   54m
```

### 创建 PersistentVolumeClaim

编辑 pvc003.yaml 文件

```
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc003
  namespace: william
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
```

使用 kubectl 执行 pvc003.yaml 文件

```
$ kubectl apply -f pvc003.yaml
persistentvolumeclaim/pvc003 created
```

查看创建的 PersistentVolume：

```
$ kubectl get pvc -n william
NAME     STATUS   VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
pvc003   Bound    pv002    1Gi        RWO                           59s
```

查看 PersistentVolume 此时的状态已经变为 Bound

```
$ kubectl get pv
NAME    CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM            STORAGECLASS   REASON   AGE
pv003   1Gi        RWO            Recycle          Bound    william/pvc003                           3m7s
```

## 创建 nginx Deployment

编辑 nginx-deployment.yaml 文件

```
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: mynginx-pv
  namespace: william
spec:
  replicas: 1
  template:
    metadata:
     labels:
       name: mynginx-pv
    spec:
     containers:
     - name: mynginx-pv
       image: nginx
       volumeMounts:
       - mountPath: "usr/share/nginx/html"
         name: pv003
       tty: true
       ports:
       - containerPort: 80
     volumes:
     - name: pv003
       persistentVolumeClaim:
         claimName: pvc003
```

使用 kubectl 执行 nginx-deployment.yaml 文件

```
$ kubectl apply -f nginx-deployment.yaml
deployment.extensions/mynginx-pv created
```

查看nginx部署情况

```
$ kubectl get deployment -n william
NAME         READY   UP-TO-DATE   AVAILABLE   AGE
mynginx-pv   1/1     1            1           3m43s
```

##  创建 nginx Service

编辑 nginx-svc.yaml 文件

```
apiVersion: v1
kind: Service
metadata:
  name: mynginx-pv
  namespace: william
spec:
  type: NodePort
  ports:
  - port: 80
    protocol: TCP
    targetPort: 80
    nodePort: 30088

  selector:
    name: mynginx-pv
```

使用kubectl 执行 nginx-svc.yaml 文件

```
$ kubectl apply -f nginx-svc.yaml
```

查看 nginx 服务信息

```
$ kubectl get svc -n william
NAME         TYPE       CLUSTER-IP    EXTERNAL-IP   PORT(S)        AGE
mynginx-pv   NodePort   10.43.77.87   <none>        80:30088/TCP   94s
```

## 部署网页

将 index.html 上传到nfs服务器 /mynfs/pv003目录下

## 访问网站

http://172.16.33.101:30088/
