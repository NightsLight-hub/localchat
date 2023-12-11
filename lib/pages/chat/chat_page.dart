import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'conversation_message_box.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return ChatPageState();
  }
}

class ChatPageState extends ConsumerState<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSessionName("聊天"),
            buildSessionMessage(),
          ],
        ));
  }

  SizedBox buildSessionName(String showName) {
    return SizedBox(
      height: 64,
      child: SelectionArea(
          child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              showName,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 30),
            ),
          ],
        ),
      )),
    );
  }

  Expanded buildSessionMessage() {
    // todo 如何更新user
    return Expanded(
        child: Container(
            padding: const EdgeInsets.all(5.0),
            decoration: const BoxDecoration(color: Colors.white),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ConversationMessageBox(),
              ],
            )));
  }
}
