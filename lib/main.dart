import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'main_app.dart';

void main() async {
  await _initHive();
  runApp(const MainApp());
}

Future<void> _initHive() async {
  Box boxLogin;
  await Hive.initFlutter();
  boxLogin = await Hive.openBox("login");
  boxLogin.clear(); // Clear the "login" box
}
