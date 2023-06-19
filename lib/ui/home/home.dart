import 'package:blood_nepal/ui/home/settings.dart';
import 'package:blood_nepal/ui/home/history.dart';
import 'package:blood_nepal/ui/home/general.dart';
import 'package:blood_nepal/ui/home/leaderboard.dart';
import 'package:blood_nepal/ui/home/pressure.dart';
import 'package:blood_nepal/ui/home/locations.dart';
import 'package:blood_nepal/ui/signup.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../login.dart';

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
                          style: TextStyle(
                              fontSize: 20, letterSpacing: 1.2, height: 1.2),
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
                  const SizedBox(width: 15),
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  homeButton(
                      "General Info", context, const General(), Icons.info),
                  homeButton("Donation History", context, const History(),
                      Icons.article),
                ]),
            const SizedBox(height: 50),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  homeButton("Leaderboard", context, const Leaderboard(),
                      Icons.leaderboard),
                  homeButton("Blood Pressure", context, const Pressure(),
                      Icons.health_and_safety),
                ]),
            const SizedBox(height: 50),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  homeButton("Blood Bank Locations", context, const Locations(),
                      Icons.location_on),
                  homeButton(
                      "Settings", context, const Settings(), Icons.settings),
                ])
          ],
        ),
      ),
    );
  }
}

homeButton(String text, context, target, IconData icon) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red[900],
        elevation: 10,
        fixedSize: const Size.fromRadius(75),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return target;
            },
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 50),
          const SizedBox(height: 10),
          Text(
            text,
            style: const TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ],
      ));
}
