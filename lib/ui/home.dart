import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'login.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final Box _boxLogin = Hive.box("login");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.red[900]),
        backgroundColor: Colors.red[900],
        toolbarHeight: 85,
        elevation: 10,
        actions: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Siddhartha\nTuladhar",
                          style: TextStyle(fontSize: 20, letterSpacing: 1.2),
                          textAlign: TextAlign.left),
                    ],
                  ),
                  const SizedBox(width: 35),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("BLOOD\nTYPE",
                          style: TextStyle(fontSize: 15),
                          textAlign: TextAlign.left),
                      Text("O+",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left)
                    ],
                  ),
                  const SizedBox(width: 30),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("TOTAL\nDONATIONS",
                          style: TextStyle(fontSize: 15),
                          textAlign: TextAlign.left),
                      Text("5",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left)
                    ],
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: () {
                      _boxLogin.clear();
                      _boxLogin.put("loginStatus", false);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const Login();
                          },
                        ),
                      );
                    },
                    icon: const Icon(Icons.logout_rounded),
                  ),
                ],
              )),
        ],
      ),
      backgroundColor: Colors.blueGrey[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome 🎉",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              _boxLogin.get("phoneNumber"),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
