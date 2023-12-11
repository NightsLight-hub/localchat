import 'dart:html';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:localchat/gen/strings.g.dart';
import 'package:localchat/web/pages/web_chat_page.dart';
import 'package:localchat/web/services/web_websocket_service.dart';
import 'package:localchat/web/web_common.dart' as common;

main(List<String> args) {
  String currentUrl = window.location.href;
  common.logI('currentUrl: $currentUrl');
  Uri uri = Uri.parse(currentUrl);
  // common.address = 'http://${uri.host}:${uri.port}';
  common.address = 'http://localhost:8080';
  common.logI('server address: ${common.address}');
  connectWs(uri);
  runApp(const WebFramework());
}

connectWs(Uri uri) {
  var wsServerUrl = "ws://${uri.host}:8081";
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
