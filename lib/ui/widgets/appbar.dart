import 'package:flutter/material.dart';

import '../home/home.dart';

PreferredSizeWidget appBar(context, String text) {
  return AppBar(
    leading: IconButton(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const Home();
            },
          ),
        );
      },
      icon: const Icon(Icons.arrow_back_ios_new_outlined, size: 30),
    ),
    toolbarHeight: 85,
    title: Text(text,
        style: const TextStyle(
            fontSize: 26, letterSpacing: 1.2, height: 1.2, fontFamily: "Rubik"),
        textAlign: TextAlign.left),
  );
}
