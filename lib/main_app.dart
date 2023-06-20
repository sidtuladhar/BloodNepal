import 'package:blood_nepal/ui/loading.dart';
import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: ColorScheme.light(
            primary: Colors.red[700]!, secondary: Colors.deepOrange),
      ),
      home: const Loading(),
    );
  }
}
