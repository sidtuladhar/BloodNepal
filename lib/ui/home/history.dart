import 'package:flutter/material.dart';
import 'package:blood_nepal/ui/home/home.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
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
