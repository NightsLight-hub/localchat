import 'dart:html';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:localchat/gen/strings.g.dart';
import 'package:localchat/web/pages/web_chat_page.dart';
import 'package:localchat/web/services/web_websocket_service.dart';
import 'package:localchat/web/web_common.dart' as common;

main() {
  String currentUrl = window.location.href;
  connectWs(currentUrl);
  runApp(const WebFramework());
}

connectWs(String currentUrl) {
  common.logI('currentUrl: $currentUrl');
  var wsServerUrl = "ws://${Uri.parse(currentUrl).host}:8081";
  common.logI('wsServerUrl: $wsServerUrl');
  WebWsService().init(wsServerUrl);
}

class WebFramework extends ConsumerWidget {
  const WebFramework({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(
        child: TranslationProvider(
            child: MaterialApp(
                title: '本地聊天',
                home: Scaffold(
                    appBar: AppBar(
                      title: const Text("localchat"),
                    ),
                    body: const WebChatPage()))));
  }
}
