import 'dart:html';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:localchat/gen/strings.g.dart';
import 'package:localchat/web/pages/web_chat_page.dart';
import 'package:localchat/web/web_common.dart' as common;

main(List<String> args) {
  String currentUrl = window.location.href;
  common.logI('currentUrl: $currentUrl');
  Uri uri = Uri.parse(currentUrl);
  common.address = 'http://${uri.host}:${uri.port}';
  if (const String.fromEnvironment('BUILD_MODE') == 'debug') {
    common.address = 'http://localhost:8080'; // only used when debug
  }
  common.logI('server address: ${common.address}');
  runApp(const WebFramework());
}

class WebFramework extends ConsumerWidget {
  const WebFramework({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(
        child: TranslationProvider(
            child: MaterialApp(
                title: '本地聊天',
                home: Scaffold(
                    appBar: AppBar(
                      title: const Center(child: Text("localchat")),
                    ),
                    body: const WebChatPage()))));
  }
}
