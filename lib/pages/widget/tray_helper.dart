import 'package:flutter/foundation.dart';
import 'package:localchat/logger.dart';
import 'package:tray_manager/tray_manager.dart' as tm;
import 'package:window_manager/window_manager.dart';

enum TrayEntry {
  open,
  close,
}

Future<void> initTray() async {
  try {
    if (defaultTargetPlatform == TargetPlatform.macOS) {
      await tm.trayManager.setIcon('assets/img/logo-32.png');
    } else {
      await tm.trayManager.setIcon('assets/img/logo-32.ico');
    }

    final items = [
      tm.MenuItem(
        key: TrayEntry.open.name,
        label: 'open',
      ),
      tm.MenuItem(
        key: TrayEntry.close.name,
        label: 'quit',
      ),
    ];
    await tm.trayManager.setContextMenu(tm.Menu(items: items));
    await tm.trayManager.setToolTip('localchat');
  } catch (e) {
    logger.e('Failed to init tray', error: e);
  }
}

Future<void> hideToTray() async {
  await windowManager.hide();
  if (defaultTargetPlatform == TargetPlatform.macOS) {
    // This will crash on Windows
    await windowManager.setSkipTaskbar(true);
  }
}

Future<void> showFromTray() async {
  await windowManager.show();
  await windowManager.focus();
  if (defaultTargetPlatform == TargetPlatform.macOS) {
    await windowManager.setSkipTaskbar(false);
  }
}
