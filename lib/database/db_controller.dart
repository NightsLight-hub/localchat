import 'dart:io';

import 'package:isar/isar.dart';
import 'package:localchat/config.dart';
import 'package:localchat/logger.dart';
import 'package:localchat/models/dbmodels.dart';
import 'package:localchat/gen/strings.g.dart';

class Database {
  static final Database _inst = Database._internal();

  factory Database() {
    return _inst;
  }

  late Isar isar;

  Database._internal();

  static Database get instance => _inst;

  bool inited = false;

  init(String cachePath) async {
    if (inited) {
      logger.w('database reinit');
      return;
    }
    try {
      await Directory(cachePath).create(recursive: true);
      isar = Isar.openSync([
        MessageModelSchema,
        UsersModelSchema,
        SettingsModelSchema,
      ], directory: cachePath);
      _initSelf();
      inited = true;
    } catch (e) {
      if (e.toString().contains('Instance has already been opened')) {
        logger.w('database reinit');
      } else {
        rethrow;
      }
    }
  }

  close() {
    if (inited) {
      logger.i('isar close');
      inited = false;
      isar.close();
    }
  }

  _initSelf() async {
    if (await getUser(Config().selfId) != null) {
      return;
    }
    var self = UsersModel()
      ..nickName = t.constants.hostNickName
      ..userId = Config().selfId
      ..me = 1;
    isar.writeTxn(() => isar.usersModels.put(self));
  }

  Future<UsersModel?> getUser(String id) async {
    return await isar.usersModels.getByUserId(id);
  }
}
