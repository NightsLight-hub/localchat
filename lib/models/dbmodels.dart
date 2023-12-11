import 'dart:convert';

import 'package:isar/isar.dart';
import 'package:localchat/models/common.dart';
import 'package:localchat/models/dbmodels_adapter.dart';
import 'package:localchat/utils.dart' as utils;

part 'dbmodels.g.dart';

@collection
class MessageModel {
  MessageModel();

  MessageModel.text(
    String text, {
    required this.senderNickname,
    required this.senderPlatformID,
    required this.senderID,
  }) {
    content = utf8.encode(text);
    createTime = utils.getCurrentTimestampByMill();
    contentType = ContentType.text.value;
    msgID = utils.uuid();
  }

  Id? id;

  @Index(unique: true, replace: true)
  String? msgID;

  @Index()
  double? createTime;

  String? senderID;

  int? contentType;
  int? senderPlatformID;
  String? senderNickname;

  // String? senderFaceURL;
  List<int>? content;

  Map<String, dynamic> toJson() {
    return {
      'msgID': msgID,
      'createTime': createTime,
      'senderID': senderID,
      'contentType': contentType,
      'senderPlatformID': senderPlatformID,
      'senderNickname': senderNickname,
      'content': content,
    };
  }

  MessageModelData toData() {
    return MessageModelData(
      msgID: msgID,
      createTime: createTime,
      senderID: senderID,
      contentType: contentType,
      senderPlatformID: senderPlatformID,
      senderNickname: senderNickname,
      content: content,
    );
  }
}

@collection
class UsersModel {
  Id? id;

  @Index(unique: true, replace: true)
  String? userId;
  String? nickName;
  int me = 0;

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'nickName': nickName,
      'me': me,
    };
  }

  UserModelData toData() {
    return UserModelData(
      userId: userId!,
      nickName: nickName!,
      me: me,
    );
  }
}
