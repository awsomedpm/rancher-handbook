# Harbor 介绍

Harbor 是开源的企业级容器镜像管理平台

Harbor是一个用于存储和分发Docker镜像的企业级Registry服务器，通过添加一些企业必需的功能特性，例如安全、标识和管理等，扩展了开源Docker Distribution。作为一个企业级私有Registry服务器，Harbor提供了更好的性能和安全。提升用户使用Registry构建和运行环境传输镜像的效率。另外，Harbor支持多个Registry节点的镜像复制。

Harbor创始人兼VMware中国研发中心技术总监张海宁

[Harbor 官网](https://goharbor.io/)
https://goharbor.io/

[Harbor GitHub](https://github.com/goharbor/harbor)
https://github.com/goharbor/harbor

## 为什么要建企业级私有仓库

* 效率
    * 局域网比广域网速度快
* 安全
    * 知识产权保护
    * 便于访问控制

## Harbor 发展历史

* 2014年：VMware中国研发中心内部立项和使用
* 2016年：对社区开源
* 2018年：7月加入CNCF组织成为沙箱级托管项目，并在同年11月晋升为CNCF孵化级（Incubating）项目

# Harbor 特性

* 云原生镜像库：支持容器镜像和 Helm charts，Harbor 可以用作云原生环境例如容器运行和编排平台的镜像仓库。
* 基于角色的访问控制 ：用户与镜像仓库通过“项目”进行组织管理，一个用户可以对同一个project里的镜像有不同的权限。
* 基于策略的镜像复制 ： 镜像可以在多个 Registry 实例中基于策略进行复制（同步）。策略可以使用多种过滤器（仓库，tag和标签）。特别适合负载均衡，高可用，多数据中心，混合云和多云的场景。
* 漏洞扫描： Harbor 定期扫描镜像，并告知用户发现的漏洞。
* AD/LDAP 支持 ： Harbor 可以集成企业内部已有的 AD/LDAP，用于鉴权认证管理。
* 镜像删除和垃圾回收 ： 可以删除镜像，并回收空间。
* Notary ： 验证镜像的安全性。
* 图形化用户界面 ： 用户可以通过浏览器来浏览，检索当前 Docker 镜像仓库，管理项目和命名空间。
* 审计管理 ： 所有针对镜像仓库的操作都被记录追溯。
* RESTful API ： 提供管理操作的 RESTful API, 使得与其它管理软件集成变得更容易。
* 部署简单 ： 提供在线和离线两种安装工具。
* 国际化 ： 已拥有英文、中文、德文、日文和俄文的本地化版本。更多的语言将会添加进来。
