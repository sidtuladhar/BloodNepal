import 'package:blood_nepal/ui/home/settings.dart';
import 'package:blood_nepal/ui/home/history.dart';
import 'package:blood_nepal/ui/home/general.dart';
import 'package:blood_nepal/ui/home/leaderboard.dart';
import 'package:blood_nepal/ui/home/requests.dart';
import 'package:blood_nepal/ui/home/locations.dart';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:geolocator/geolocator.dart';

class Home extends StatelessWidget {
  final Box boxLogin = Hive.box("login");

  Home({super.key});

  @override
  Widget build(BuildContext context) {
    String firstName = boxLogin.get("fname");
    String lastName = boxLogin.get("lname");
    final String? bloodGroup = boxLogin.get("bloodGroup");
    final int totalDonations = boxLogin.get("totalDonations");

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          shape: ShapeBorder.lerp(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Theme.of(context).primaryColor)),
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Theme.of(context).primaryColor)),
              10),
          leadingWidth: 0,
          leading: BackButton(color: Theme.of(context).primaryColor),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColor,
                      Theme.of(context).colorScheme.secondary,
                    ])),
          ),
          toolbarHeight: 85,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$firstName\n$lastName',
                      style: const TextStyle(
                          fontSize: 20, letterSpacing: 1.2, height: 1.2),
                      textAlign: TextAlign.left),
                ],
              ),
              const SizedBox(width: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("BLOOD\nGROUP",
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.left),
                  Text("$bloodGroup",
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left)
                ],
              ),
              const SizedBox(width: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("TOTAL\nDONATIONS",
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.left),
                  Text("$totalDonations",
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left)
                ],
              ),
            ],
          ),
        ),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20),
                const Text(
                  'Upcoming Events',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                getAppointment(),
                const SizedBox(height: 20),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      homeButton("Blood Bank Locations", context,
                          const Locations(), Icons.location_on),
                      homeButton("Donation History", context, const History(),
                          Icons.article),
                    ]),
                const SizedBox(height: 20),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      homeButton("Leaderboard", context, const Leaderboard(),
                          Icons.leaderboard),
                      homeButton("Request Blood", context, const Requests(),
                          Icons.handshake_rounded),
                    ]),
                const SizedBox(height: 20),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      homeButton(
                          "General Info", context, const General(), Icons.info),
                      homeButton("Settings", context, const Settings(),
                          Icons.settings),
                    ])
              ],
            ),
          ),
          // const SizedBox(height: 10),
        ])));
  }
}

homeButton(String text, context, target, IconData icon) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        fixedSize: const Size(140, 130),
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
          Icon(icon, color: Colors.white, size: 30),
          const SizedBox(height: 5),
          Text(
            text,
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ],
      ));
}

Widget getAppointment() {
  return Container(
    width: double.infinity,
    height: 150,
    decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey, width: .1)),
    padding: const EdgeInsets.all(18),
    child: const Text("There are no events scheduled at the moment.",
        style: TextStyle(fontSize: 20)),
  );
}
