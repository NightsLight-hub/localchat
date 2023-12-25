import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:localchat/utils.dart' as utils;

class TextMessage extends ConsumerStatefulWidget {
  const TextMessage(
      {required this.senderName,
      required this.content,
      required this.isSelf,
      this.maxLength = 600,
      this.fontSize = 16,
      super.key});

  final String senderName;
  final String content;
  final bool isSelf;
  final double maxLength;
  final double fontSize;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return TextMessageState();
  }
}

class TextMessageState extends ConsumerState<TextMessage> {
  @override
  Widget build(BuildContext context) {
    String name = widget.senderName;
    String fellowAvtar = 'assets/images/avatarMan.jpg';
    var align = widget.isSelf ? MainAxisAlignment.end : MainAxisAlignment.start;
    var senderAvatar = Container(
      margin: const EdgeInsets.all(10),
      child: Image(
          width: 50,
          height: 50,
          image: AssetImage(
              widget.isSelf ? 'assets/images/avatarMan.jpg' : fellowAvtar)),
    );
    var senderName = Text.rich(TextSpan(children: [
      TextSpan(
        text: widget.isSelf ? '  $name    ' : '$name  ',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    ]));
    var copyButton = Container(
      constraints: const BoxConstraints(maxWidth: 30),
      margin: const EdgeInsets.only(right: 8),
      child: IconButton(
        icon: const Icon(Icons.copy),
        tooltip: '复制',
        onPressed: () {
          Clipboard.setData(ClipboardData(text: widget.content)).then((_) {
            utils.showSnackBar(
                context,
                Center(
                    child: Text(
                  "已复制聊天内容",
                  style: TextStyle(
                      fontSize: widget.fontSize, fontWeight: FontWeight.normal),
                )));
          });
        },
      ),
    );
    Color selfMsgColor, fellowMsgColor;
    if (Theme.of(context).brightness == Brightness.dark) {
      selfMsgColor = Colors.white24;
      fellowMsgColor = Colors.blueGrey;
    } else {
      selfMsgColor = const Color.fromARGB(255, 153, 231, 169);
      fellowMsgColor = const Color.fromARGB(255, 164, 208, 238);
    }
    Color msgColor = widget.isSelf ? selfMsgColor : fellowMsgColor;
    var messageText = Container(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      margin: const EdgeInsetsDirectional.only(top: 3),
      constraints: BoxConstraints(maxWidth: widget.maxLength),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: msgColor, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        ),
        shadows: [
          BoxShadow(
            color: msgColor,
            // blurRadius: 2.0,
          ),
        ],
      ),
      child: Text(
        widget.content,
        style: TextStyle(fontSize: widget.fontSize),
      ),
    );
    return Row(
      mainAxisAlignment: align,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: widget.isSelf
          ? [copyButton, messageText, senderAvatar]
          : [senderAvatar, messageText, copyButton],
    );
  }
}
