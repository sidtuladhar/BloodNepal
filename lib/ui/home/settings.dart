import 'package:flutter/material.dart';
import 'package:blood_nepal/ui/home/home.dart';
import 'package:settings_ui/settings_ui.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
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
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return Home();
                            },
                          ),
                        );
                      },
                      icon: const Icon(Icons.logout_rounded),
                    ),
                  ],
                )),
          ],
        ));
  }
}
