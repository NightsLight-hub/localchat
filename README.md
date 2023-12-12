# localchat

localchat

## Getting Started

构建一个用于局域网内发送文字和文件的工具，以聊天的方式。。。

## 构建方法

* web静态资源构建 
```shell
fvm flutter build web  --base-href /front/ --release -t lib/web/web_main.dart
```

* ide 用windows 设备启动main.dart

## 一些命令
### code generate
```shell
fvm dart pub run build_runner build
```

### build web
```shell
fvm flutter build web  --base-href /front/ --release -t lib/web/web_main.dart
```

### 短期规划
* [ ] 增加eventBus，做事件管理
* [ ] 断线重连，用户重新注册逻辑，得和事件管理一起做。
* [ ] 手机端页面，键盘会盖住下面的消息
    * https://blog.csdn.net/ww897532167/article/details/125633146
* [x] desktop发送文件
* [x] 文件消息下载、打开（desktop和web都已完成）
* [ ] web端文件上传
* [ ] 消息广播


# 感谢
受到 [localsend](https://github.com/localsend/localsend) 的启发
