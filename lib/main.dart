import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:localchat/database/db_controller.dart';
import 'package:localchat/gen/strings.g.dart';
import 'package:localchat/http/router.dart' as router;
import 'package:localchat/pages/widget/tray_helper.dart' as tray_helper;
import 'package:localchat/pages/widget/tray_watcher.dart';
import 'package:localchat/pages/widget/window_watcher.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:window_manager/window_manager.dart';

import 'logger.dart';
import 'pages/homepage.dart';
import 'utils.dart' as utils;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
  await tray_helper.initTray();
  await windowManager.ensureInitialized();
  WindowOptions windowOptions =
      const WindowOptions(size: Size(1280, 800), center: true);
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

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
        child: TrayWatcher(
          child: WindowWatcher(
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
            ),
          ),
        ),
      ),
    );
  }
}
