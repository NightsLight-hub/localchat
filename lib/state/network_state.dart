import 'dart:io';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/common.dart';

part 'network_state.g.dart';

@Riverpod(keepAlive: true)
class NetworkCardNotifier extends _$NetworkCardNotifier {
  @override
  Future<List<NetworkCard>> build() async {
    List<NetworkCard> cards = [];
    for (var interface in await NetworkInterface.list()) {
      cards.add(NetworkCard(interface.name, interface.addresses[0].address));
    }
    return cards;
  }
}
