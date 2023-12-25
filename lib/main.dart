import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:localchat/database/db_controller.dart';
import 'package:localchat/gen/strings.g.dart';
import 'package:localchat/http/router.dart' as router;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'utils.dart' as utils;
import 'logger.dart';
import 'pages/homepage.dart';

void main() async {
  var add = (await getApplicationDocumentsDirectory()).path;
  // 不同用户的hive数据库 文件放在不同目录，避免单机多实例报错
  String cachePath = p.join(add, 'localchat', "database");
  logger.i('cachePath: $cachePath');
  Database().init(cachePath);
  HttpServer server, wsServer;
  if (Platform.isWindows) {
    server = await shelf_io.serve(router.routes(), '0.0.0.0', 8080);
    logger.i('Rest Server running on ${server.address}:${server.port}');
    wsServer = await shelf_io.serve(router.websocketHandler, '0.0.0.0', 8081);
    logger
        .i('Websocket Server running on ${wsServer.address}:${wsServer.port}');
  }
  runApp(const MainFramework());
}

class MainFramework extends ConsumerStatefulWidget {
  const MainFramework({super.key});

  @override
  ConsumerState<MainFramework> createState() {
    return MainFrameworkState();
  }
}

class MainFrameworkState extends ConsumerState<MainFramework> {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
        child: TranslationProvider(
            child: AdaptiveTheme(
      light: utils.lightTheme(),
      dark: utils.darkTheme(),
      initial: AdaptiveThemeMode.dark,
      builder: (theme, darkTheme) => MaterialApp(
        title: 'LocalChat',
        theme: theme,
        darkTheme: darkTheme,
        home: const HomePage(),
      ),
    )));
  }
}
