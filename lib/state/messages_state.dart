import 'package:localchat/models/dbmodels_adapter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'messages_state.g.dart';

Map<String, MessageModelData> _msgMap = {};

MessageModelData? getMsg(String msgId) => _msgMap[msgId];
_addMsg(MessageModelData msg) => _msgMap[msg.msgId!] = msg;

@Riverpod(keepAlive: true)
class MessagesNotifier extends _$MessagesNotifier {
  @override
  Future<List<String>> build() async {
    return [];
  }

  add(MessageModelData msg) async {
    // We can then manually update the local cache. For this, we'll need to
    // obtain the previous state.
    // Caution: The previous state may still be loading or in error state.
    // A graceful way of handling this would be to read `this.future` instead
    // of `this.state`, which would enable awaiting the loading state, and
    // throw an error if the state is in error state.
    final previousState = await future;

    if (getMsg(msg.msgId!) == null) {
      state = AsyncData([...previousState, msg.msgId!]);
    }
    _addMsg(msg);
  }
}
