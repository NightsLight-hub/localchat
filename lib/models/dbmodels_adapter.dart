import 'dart:convert';

import 'package:localchat/models/common.dart';
import 'package:localchat/utils.dart' as utils;
import 'package:localchat/utils.dart';

class MessageModelData {
  MessageModelData({
    this.msgID,
    this.createTime,
    this.senderID,
    this.contentType,
    this.senderPlatformID,
    this.senderNickname,
    this.content,
  });

  MessageModelData.text(
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

  MessageModelData.file(
    String filePath, {
    required this.senderNickname,
    required this.senderPlatformID,
    required this.senderID,
  }) {
    content = utf8.encode(filePath);
    createTime = utils.getCurrentTimestampByMill();
    contentType = ContentType.file.value;
    msgID = utils.uuid();
  }

  String? msgID;
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

  MessageModelData.fromJson(Map<String, dynamic> body) {
    if (body['msgID'] == null) {
      throw Exception('msgID is null');
    }
    if (body['createTime'] == null) {
      throw Exception('createTime is null');
    }
    if (body['senderID'] == null) {
      throw Exception('senderID is null');
    }
    if (body['contentType'] == null) {
      throw Exception('contentType is null');
    }
    if (body['senderPlatformID'] == null) {
      throw Exception('senderPlatformID is null');
    }
    if (body['senderNickname'] == null) {
      throw Exception('senderNickname is null');
    }
    if (body['content'] == null) {
      throw Exception('content is null');
    }
    msgID = body['msgID'];
    createTime = double.parse(body['createTime'].toString());
    senderID = body['senderID'];
    contentType = body['contentType'];
    senderPlatformID = body['senderPlatformID'];
    senderNickname = body['senderNickname'];
    content = body['content'].cast<int>();
  }
}

class UserModelData {
  UserModelData({
    required this.userId,
    required this.nickName,
    this.me = 0,
  });

  String userId = '';
  String nickName = '';
  int me = 0;

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'nickName': nickName,
      'me': me,
    };
  }

  UserModelData.fromJson(Map<String, dynamic> body) {
    if (body['nickName'] == null) {
      throw Exception('nickName is null');
    }
    userId = body['userId'] ?? uuid();
    nickName = body['nickName'];
    me = body['me'] ?? 0;
  }
}
