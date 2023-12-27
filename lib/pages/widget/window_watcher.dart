import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:localchat/logger.dart';
import 'package:localchat/pages/widget/tray_helper.dart';
import 'package:localchat/state/settings_state.dart';
import 'package:window_manager/window_manager.dart';

class WindowWatcher extends ConsumerStatefulWidget {
  final Widget child;

  const WindowWatcher({
    required this.child,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _WindowWatcherState();
  }
}

class _WindowWatcherState extends ConsumerState<WindowWatcher>
    with WindowListener {
  static Stopwatch s = Stopwatch();

  @override
  Widget build(BuildContext context) {
    s.start();
    return widget.child;
  }

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        // always handle close actions manually
        await windowManager.setPreventClose(true);
      } catch (e) {
        logger.e('Failed to set prevent close', error: e);
      }
    });
  }

  _storePosition({Offset? offset, Size? size}) async {
    ref
        .read(settingsStateNotifierProvider.notifier)
        .setPosition(offset: offset, size: size);
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  Future<void> onWindowMoved() async {
    final windowOffset = await windowManager.getPosition();
    await _storePosition(offset: windowOffset);
  }

  @override
  Future<void> onWindowResized() async {
    final windowSize = await windowManager.getSize();
    await _storePosition(size: windowSize);
  }

  @override
  Future<void> onWindowClose() async {
    final windowOffset = await windowManager.getPosition();

    final windowSize = await windowManager.getSize();
    await _storePosition(offset: windowOffset, size: windowSize);

    try {
      if (ref.read(settingsStateNotifierProvider).value?.minimizeToTray ??
          false) {
        await hideToTray();
      } else {
        exit(0);
      }
    } catch (e) {
      logger.e('Failed to close window', error: e);
    }
  }

  @override
  void onWindowFocus() {
    // call set state according to window_manager README
    setState(() {});
  }
}
