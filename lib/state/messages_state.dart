import 'package:localchat/models/dbmodels_adapter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'messages_state.g.dart';

@Riverpod(keepAlive: true)
class MessagesNotifier extends _$MessagesNotifier {
  @override
  Future<List<MessageModelData>> build() async {
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

    // We can then update the state, by creating a new state object.
    // This will notify all listeners.
    state = AsyncData([...previousState, msg]);
  }
}
