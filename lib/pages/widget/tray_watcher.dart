import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:localchat/pages/widget/tray_helper.dart';
import 'package:tray_manager/tray_manager.dart';

class TrayWatcher extends StatefulWidget {
  final Widget child;

  const TrayWatcher({required this.child, super.key});

  @override
  State<TrayWatcher> createState() => _TrayWatcherState();
}

class _TrayWatcherState extends State<TrayWatcher> with TrayListener {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void initState() {
    super.initState();
    trayManager.addListener(this);
  }

  @override
  void dispose() {
    trayManager.removeListener(this);
    super.dispose();
  }

  @override
  void onTrayIconMouseDown() async {
    if (defaultTargetPlatform == TargetPlatform.macOS) {
      await trayManager.popUpContextMenu();
    } else {
      await showFromTray();
    }
  }

  @override
  void onTrayIconRightMouseDown() async {
    await trayManager.popUpContextMenu();
  }

  @override
  void onTrayMenuItemClick(MenuItem menuItem) async {
    try {
      final entry = TrayEntry.values.firstWhere((e) => e.name == menuItem.key);
      switch (entry) {
        case TrayEntry.open:
          await showFromTray();
          break;
        case TrayEntry.close:
          exit(0);
        default:
      }
    } catch (e) {
      // if no entry is found, do nothing
      return;
    }
  }
}
