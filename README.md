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

## 调试开发
web_main 读取 环境变量 `BUILD_MODE=debug` 从而能使用 localhost:8080 作为localChat服务器地址

```shell
flutter run -t lib/web/web_main.dart --dart-define=BUILD_MODE=debug
```

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
* [ ] 断线重连，用户重新注册逻辑。
* [x] desktop发送文件
* [x] 文件消息下载、打开（desktop和web都已完成）
* [x] web端文件上传
* [ ] 消息广播 -- 研发中
* [x] 分段上传
* [ ] 上传失败的消息展示
* [ ] 发布包构建脚本
* [ ] 体验性问题
  * [ ] 消息双击不能全选， 期待是 双击全选+复制
  * [x] 点击空白处，选择的消息不能取消选择
  * [ ] 图片粘贴发送 及 渲染
  * [ ] 手机端页面，键盘会盖住下面的消息
  


# 感谢
受到 [localsend](https://github.com/localsend/localsend) 的启发
