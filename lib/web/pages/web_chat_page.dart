import 'dart:convert';

import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:localchat/http/websocket_message.dart';
import 'package:localchat/models/dbmodels_adapter.dart';
import 'package:localchat/utils.dart' as utils;
import 'package:localchat/web/pages/web_conversation_msgbox.dart';
import 'package:localchat/web/services/web_websocket_service.dart';
import 'package:localchat/web/web_common.dart' as common;
import 'package:shared_preferences/shared_preferences.dart';

class WebChatPage extends ConsumerStatefulWidget {
  const WebChatPage({Key? key}) : super(key: key);

  @override
  ConsumerState<WebChatPage> createState() {
    return WebChatPageState();
  }
}

class WebChatPageState extends ConsumerState<WebChatPage> {
  @override
  initState() {
    super.initState();
    utils.setMainRef(ref);
  }

  @override
  Widget build(BuildContext context) {
    prepare(context);
    return DropTarget(
        onDragDone: (detail) {
          setState(() {
            // _list.addAll(detail.files);
          });
        },
        child: Container(
            padding: const EdgeInsets.all(5.0),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WebConversationMsgBox(),
              ],
            )));
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

  _connectWs(String host) {
    var wsServerUrl = "ws://$host:8081";
    common.logI('wsServerUrl: $wsServerUrl');
    WebWsService().init(wsServerUrl);
  }

  prepare(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 50));
    final prefs = await SharedPreferences.getInstance();
    const key = 'userModel';
    String value = prefs.getString(key) ?? "";

    if (value.isNotEmpty) {
      UserModelData user = UserModelData.fromJson(jsonDecode(value));
      common.setUserModelData(user);
      _connectWs(common.host);
      return;
    }

    if (context.mounted) {
      String nickName = '';
      showDialog<bool>(
          context: context,
          builder: (context) {
            return Dialog(
                alignment: Alignment.center,
                // insetPadding:
                // EdgeInsets.only(left: localOffset.dx, top: localOffset.dy),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                          width: 400,
                          child: TextField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: '请输入用户名',
                            ),
                            onChanged: (text) {
                              nickName = text;
                            },
                          )),
                      TextButton(
                        onPressed: () {
                          if (nickName.isNotEmpty) {
                            UserModelData user = UserModelData(
                                userId: utils.uuid(), nickName: nickName);
                            prefs.setString(key, jsonEncode(user));
                            common.setUserModelData(user);
                            _connectWs(common.host);
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('确定'),
                      ),
                    ],
                  ),
                ));
          });
    }
  }
}
