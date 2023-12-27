// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$messagesNotifierHash() => r'92450e7a2a9a041ef01a2a2bd4211fdfbde6bc3e';

/// See also [MessagesNotifier].
@ProviderFor(MessagesNotifier)
final messagesNotifierProvider =
    AsyncNotifierProvider<MessagesNotifier, List<String>>.internal(
  MessagesNotifier.new,
  name: r'messagesNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$messagesNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MessagesNotifier = AsyncNotifier<List<String>>;
String _$messageSendProgressNotifierHash() =>
    r'56dcfb13471b5b131741c522e2f22a9251c06edc';

/// See also [MessageSendProgressNotifier].
@ProviderFor(MessageSendProgressNotifier)
final messageSendProgressNotifierProvider = AsyncNotifierProvider<
    MessageSendProgressNotifier, Map<String, double?>>.internal(
  MessageSendProgressNotifier.new,
  name: r'messageSendProgressNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$messageSendProgressNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MessageSendProgressNotifier = AsyncNotifier<Map<String, double?>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
