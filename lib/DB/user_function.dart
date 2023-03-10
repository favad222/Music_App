import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_application/DB/user_db.dart';

ValueNotifier<List<UserDB>> userNotifier = ValueNotifier([]);

Future<void> addUser(UserDB user) async {
  final UserDataBase = await Hive.openBox<UserDB>('User');
  int id = await UserDataBase.add(user);
  user.key = id;

  userNotifier.value.add(user);
  userNotifier.notifyListeners();
}

Future<void> getUser() async {
  final userDatabase = await Hive.openBox<UserDB>('User');
  userNotifier.value.clear();
  userNotifier.value.addAll(userDatabase.values);
  userNotifier.notifyListeners();
}

Future<void> deleteUser(int index) async {
  final userDatabase = await Hive.openBox<UserDB>('User');
  await userDatabase.deleteAt(index);
  getUser();
}

Future<void> editUser(int key, UserDB user) async {
  final userDatabase = await Hive.openBox<UserDB>('User');
  userDatabase.putAt(key, user);
  getUser();
}
