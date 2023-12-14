# 文件消息

## 服务端

### 发送文件
文件在本地机器上，MessageModelData.content   存储 文件本地路径，
shelf 提供一个router， 只能允许下载这个文件

本地文件点击时候，可以直接打开文件路径，无需下载

### 接收文件
客户端 直接用 post /api/v1/file 推送文件，并发送MessageModelData 给服务端
MessageModelData.content 只有 filename 而已。

服务端使用FileMessage 组件渲染 fileMessage，并定时查询 fileTransferNotifier 来询问 某个msgID的上传进度，当进度完成后， FileMessage组件更新
消息为可打开状态。
然后将这个文件信息改写并走发送文件流程。
