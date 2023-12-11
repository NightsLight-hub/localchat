import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:localchat/config.dart';
import 'package:localchat/logger.dart';
import 'package:localchat/models/common.dart';
import 'package:localchat/models/dbmodels_adapter.dart';
import 'package:localchat/state/network_state.dart';
import 'package:localchat/state/users_state.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class NetworkPage extends ConsumerStatefulWidget {
  const NetworkPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return NetworkPageState();
  }
}

class NetworkPageState extends ConsumerState<NetworkPage> {
  final TextEditingController _inputController = TextEditingController();
  final SearchController _searchController = SearchController();
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
    Config().setAddress('http://$ip:8080');
    return "http://${Config().address}/front/";
  }

  Row _buildQrControlPanel() {
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
    return Row(
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SearchAnchor(
            searchController: _searchController,
            builder: (BuildContext context, SearchController controller) {
              return FloatingActionButton(
                onPressed: () {
                  _searchController.openView();
                },
                child: const Icon(Icons.wifi_tethering_sharp),
              );
            },
            suggestionsBuilder:
                (BuildContext context, SearchController controller) {
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
          ),
        )),
        FloatingActionButton(
          onPressed: () {
            logger.i('tap on refresh');
          },
          child: const Icon(Icons.refresh),
        ),
      ],
    );
  }

  PrettyQr _buildQr() {
    return PrettyQr(
      size: 200,
      errorCorrectLevel: QrErrorCorrectLevel.Q,
      // elementColor: Theme.of(context).colorScheme.onSurface,
      data: chatServerUrl,
    );
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
          child: Container(
            padding: const EdgeInsets.all(30),
            child: Column(children: [
              TextField(
                controller: _inputController,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                ),
              ),
              SizedBox.fromSize(size: const Size.fromHeight(30)),
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
            ]),
          ),
        ),
        const VerticalDivider(
          width: 2,
          thickness: 2,
          // color: Colors.blue,
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                _buildQrControlPanel(),
                SizedBox.fromSize(size: const Size.fromHeight(30)),
                _buildQr(),
                SizedBox.fromSize(size: const Size.fromHeight(30)),
                Text(chatServerUrl),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
