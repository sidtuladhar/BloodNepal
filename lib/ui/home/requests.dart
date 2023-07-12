import 'package:flutter/material.dart';
import 'package:blood_nepal/ui/home/home.dart';

class Requests extends StatefulWidget {
  const Requests({super.key});

  @override
  State<Requests> createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  var selectedTab = 1;
  var selectedText = "First Tab";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[50],
      appBar: AppBar(
        leading: IconButton(
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
          icon: const Icon(Icons.arrow_back_ios_new_outlined, size: 30),
        ),
        toolbarHeight: 85,
        title: const Text("Blood Requests",
            style: TextStyle(
                fontSize: 28,
                letterSpacing: 1.2,
                height: 1.2,
                fontFamily: "Rubik"),
            textAlign: TextAlign.left),
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 5),
          Container(
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * .4,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: selectedTab == 1 ? Colors.red[50] : Colors.white,
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(20),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        selectedTab = 1;
                        selectedText = "First Tab";
                      });
                    },
                    child: Center(
                      child: Text(
                        "Request Blood",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: selectedTab == 1
                                ? FontWeight.bold
                                : FontWeight.normal),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      selectedTab = 2;
                      selectedText = "Second Tab";
                    });
                  },
                  child: Text(
                    "My Requests",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: selectedTab == 2
                            ? FontWeight.bold
                            : FontWeight.normal),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.6,
            child: Align(
              alignment: Alignment.center,
              child: Text(selectedText),
            ),
          )
        ],
      ),
    );
  }
}
