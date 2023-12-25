import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:localchat/config.dart';
import 'package:localchat/logger.dart';
import 'package:localchat/models/common.dart';
import 'package:localchat/models/dbmodels_adapter.dart';
import 'package:localchat/state/network_state.dart';
import 'package:localchat/state/users_state.dart';
import 'package:localchat/utils.dart' as utils;
import 'package:pretty_qr_code/pretty_qr_code.dart';

import 'conversation_message_box.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return ChatPageState();
  }
}

class ChatPageState extends ConsumerState<ChatPage> {
  final TextEditingController _inputController = TextEditingController();
  final SearchController _searchController = SearchController();
  String currentIp = '';
  String chatServerUrl = "";

  @override
  void initState() {
    super.initState();
  }

  NetworkCard _preferedNetwork(List<NetworkCard> cards) {
    var cpCards = [...cards];
    cpCards
        .removeWhere((element) => element.name.toLowerCase().contains("wsl"));
    cpCards.removeWhere(
        (element) => element.name.toLowerCase().contains("switch"));
    cpCards.removeWhere(
        (element) => element.name.toLowerCase().contains("virtual"));
    if (cpCards.isEmpty) {
      return cards[0];
    } else {
      return cpCards[0];
    }
  }

  String _generateChatServerUrl(String ip) {
    currentIp = ip;
    Config().setAddress('http://$ip:8080');
    return "${Config().address}/front/";
  }

  @override
  Widget build(BuildContext context) {
    var users = ref.watch(usersNotifierProvider);
    List<UserModelData> participants;
    if (users.isLoading) {
      participants = [];
    } else {
      participants = users.value!;
    }
    return Row(
      children: [
        Expanded(
            flex: 8,
            child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // buildSessionName("聊天"),
                    buildSessionMessage(),
                  ],
                ))),
        Expanded(
            flex: 2,
            child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListView.builder(
                          padding: const EdgeInsets.all(10),
                          itemCount: participants.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: const Icon(Icons.person),
                              title: Text(participants[index].nickName),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              onTap: () {
                                logger.i('tap on ${participants[index]}');
                              },
                            );
                          }),
                    ),
                    SizedBox(
                      height: 240,
                      child: _buildQr(),
                    ),
                    SizedBox(
                      height: 20,
                      child: Center(child: SelectableText(currentIp)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ))),
      ],
    );
  }

  SearchAnchor _buildQr() {
    var networkCardList = ref.watch(networkCardNotifierProvider);
    List<NetworkCard> cards;
    if (networkCardList.isLoading) {
      cards = [];
    } else {
      cards = networkCardList.value!;
      if (chatServerUrl == "") {
        setState(() {
          chatServerUrl = _generateChatServerUrl(_preferedNetwork(cards).ip);
        });
      }
    }
    Color qrColor;
    if (Theme.of(context).brightness == Brightness.dark) {
      qrColor = Colors.white54;
    } else {
      qrColor = Colors.black87;
    }
    return SearchAnchor(
      searchController: _searchController,
      builder: (BuildContext context, SearchController controller) {
        return GestureDetector(
          child: Tooltip(
              message: "左键单击切换网络，右键单击复制聊天室地址",
              child: Center(
                child: PrettyQr(
                  size: 180,
                  elementColor: qrColor,
                  errorCorrectLevel: QrErrorCorrectLevel.Q,
                  // elementColor: Theme.of(context).colorScheme.onSurface,
                  data: chatServerUrl,
                  roundEdges: true,
                ),
              )),
          onTap: () {
            _searchController.openView();
          },
          onSecondaryTap: () {
            Clipboard.setData(ClipboardData(text: chatServerUrl)).then((_) {
              utils.showSnackBar(
                  context,
                  const Center(
                      child: Text(
                    "已复制聊天室地址",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                  )));
            });
          },
        );
      },
      suggestionsBuilder: (BuildContext context, SearchController controller) {
        return cards.map((e) {
          return ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(e.name),
                Text(e.ip),
              ],
            ),
            onTap: () {
              setState(() {
                controller.closeView(e.ip);
                chatServerUrl = _generateChatServerUrl(e.ip);
              });
            },
          );
        });
      },
    );
  }

  SizedBox buildSessionName(String showName) {
    return SizedBox(
      height: 64,
      child: SelectionArea(
          child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              showName,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 30),
            ),
          ],
        ),
      )),
    );
  }

  Expanded buildSessionMessage() {
    // todo 如何更新user
    return Expanded(
        child: Container(
            padding: const EdgeInsets.all(5.0),
            // decoration: const BoxDecoration(color: Colors.white),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ConversationMessageBox(),
              ],
            )));
  }
}
