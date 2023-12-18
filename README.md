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
* [ ] 断线重连，用户重新注册逻辑。
* [x] desktop发送文件
* [x] 文件消息下载、打开（desktop和web都已完成）
* [x] web端文件上传
* [ ] 消息广播 -- 研发中
* [ ] 分段上传：目前上传不支持分段，可能会导致内存占用过多等问题。
* [ ] 发布包构建脚本
* [ ] 体验性问题
  * [ ] 消息双击不能全选， 期待是 双击全选+复制
  * [ ] 点击空白处，选择的消息不能取消选择
  * [ ] 图片粘贴发送 及 渲染
  * [ ] 手机端页面，键盘会盖住下面的消息
  


# 感谢
受到 [localsend](https://github.com/localsend/localsend) 的启发
