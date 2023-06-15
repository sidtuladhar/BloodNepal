import 'package:blood_nepal/ui/loading.dart';
import 'package:flutter/material.dart';

import 'ui/start.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFEA0000),
        ),
      ),
      home: const Start(),
    );
  }
}
