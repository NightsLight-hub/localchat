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

# 感谢
受到 [localsend](https://github.com/localsend/localsend) 的启发
