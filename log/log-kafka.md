# 使用kafka采集容器日志

[Configuring Kafka Logging](https://www.cnrancher.com/docs/rancher/v2.x/en/tools/logging/kafka)
https://www.cnrancher.com/docs/rancher/v2.x/en/tools/logging/kafka

## 在 kafka 中创建采集日志的 topic

```
# bin/kafka-topics.sh --create --zookeeper 172.16.35.30:12181 --replication-factor 1 --partitions 3 --topic shop-log
```

## 在 rancher 中日志采集配置

### 选择要配置日志采集的项目

1. 点击 tool 菜单下的 Logging 子菜单
2. 选择 kafka 图标
3. 输入如下配置信息：
    * Endpoint Type： zookeeper
    * Endpoint: http://172.16.35.30:12181
    * Topic: shop-log
4. 点击 Save

## 访问应用生成日志

## 查看 kafka 日志 topic 中日志数据

### 方法1: 命令行

```
$ bin/kafka-console-consumer.sh --zookeeper 172.16.35.30:12181 --topic shop-log
Using the ConsoleConsumer with old consumer is deprecated and will be removed in a future major release. Consider using the new consumer by passing [bootstrap-server] instead of [zookeeper].





{"log":"2019-06-14 03:55:22,440 WARN  [net.sf.ehcache.config.CacheConfiguration] - Cache 'ShopCategory' is set to eternal but also has TTI/TTL set.  To avoid this warning, clean up the config removing conflicting values of eternal, TTI and TTL. Effective configuration for Cache 'ShopCategory' will be eternal='true', timeToIdleSeconds='0', timeToLiveSeconds='0'.\n","stream":"stdout","docker":{"container_id":"3c20ae1265f50f9ffc577a7e579e3283a3ed8feccbe2f6231ae687f707863337"},"kubernetes":{"container_name":"shop","namespace_name":"apptrace-demo","pod_name":"shop-7cdf7cc89f-nrvmg","pod_id":"94246b4f-8e4d-11e9-862b-005056b3849a","labels":{"name":"shop","pod-template-hash":"7cdf7cc89f"},"host":"centos75","master_url":"https://10.43.0.1:443/api","namespace_id":"fa659d52-8e4b-11e9-862b-005056b3849a","namespace_labels":{"field_cattle_io/projectId":"p-h4n46"}},"tag":"c-jlr25:p-h4n46.var.log.containers.shop-7cdf7cc89f-nrvmg_apptrace-demo_shop-3c20ae1265f50f9ffc577a7e579e3283a3ed8feccbe2f6231ae687f707863337.log","log_type":"k8s_normal_container","projectID":"c-jlr25:p-h4n46","time":1560484522}
```

### 方法2：使用 Kafka Tool

下载 [Kafka Tool](http://www.kafkatool.com/download.html)
