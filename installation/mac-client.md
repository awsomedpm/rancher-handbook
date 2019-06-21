# Mac 安装客户工具

## 安装 rke

```
$ brew install rke
```

## 查看 rke 版本

```
$ rke --version
rke version v0.2.0

## 安装kubectl

```
brew install kubernetes-cli

brew upgrade kubernetes-cli

```

## 查看 kubectl 版本

```
$ kubectl version
Client Version: version.Info{Major:"1", Minor:"14", GitVersion:"v1.14.0", GitCommit:"641856db18352033a0d96dbc99153fa3b27298e5", GitTreeState:"clean", BuildDate:"2019-03-26T00:05:06Z", GoVersion:"go1.12.1", Compiler:"gc", Platform:"darwin/amd64"}

```

## 安装 helm

```
brew install kubernetes-helm
```

## 查看 helm 版本

```
helm version
Client: &version.Version{SemVer:"v2.13.1", GitCommit:"618447cbf203d147601b4b9bd7f8c37a5d39fbb4", GitTreeState:"clean"}
```
