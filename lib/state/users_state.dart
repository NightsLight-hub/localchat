import 'package:localchat/database/db_controller.dart';
import 'package:localchat/models/dbmodels_adapter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'users_state.g.dart';

@Riverpod(keepAlive: true)
class UsersNotifier extends _$UsersNotifier {
  @override
  Future<List<UserModelData>> build() async {
    var me = await Database().getUser('self');
    return [me!.toData()];
  }

  add(UserModelData userModelData) async {
    // We can then manually update the local cache. For this, we'll need to
    // obtain the previous state.
    // Caution: The previous state may still be loading or in error state.
    // A graceful way of handling this would be to read `this.future` instead
    // of `this.state`, which would enable awaiting the loading state, and
    // throw an error if the state is in error state.
    final previousState = await future;

    for (var u in previousState.indexed) {
      if (u.$2.userId == userModelData.userId) {
        previousState.removeAt(u.$1);
        state = AsyncData([...previousState, userModelData]);
        return;
      }
    }

    // We can then update the state, by creating a new state object.
    // This will notify all listeners.
    state = AsyncData([...previousState, userModelData]);
  }
}
