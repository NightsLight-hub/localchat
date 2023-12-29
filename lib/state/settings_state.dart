import 'dart:ui';

import 'package:localchat/gen/strings.g.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_state.g.dart';

@Riverpod(keepAlive: true)
class SettingsStateNotifier extends _$SettingsStateNotifier {
  @override
  Future<Settings> build() async {
    return Settings();
  }

  setMinimizeToTray(bool value) async {
    final previousState = await future;

    previousState.minimizeToTray = value;
    state = AsyncData(previousState);
  }

  setPosition({Offset? offset, Size? size}) async {
    final previousState = await future;
    if (offset != null) {
      previousState.offset = offset;
    }
    if (size != null) {
      previousState.size = size;
    }
    state = AsyncData(previousState);
  }

  setLanguage(AppLocale? language) async {
    final previousState = await future;
    previousState.language = language;
    state = AsyncData(previousState);
  }
}

class Settings {
  bool minimizeToTray = true;
  Offset offset = const Offset(100, 100);
  Size size = const Size(1000, 800);
  AppLocale? language;
}
