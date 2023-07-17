import 'package:blood_nepal/ui/widgets/bloodpressure.dart';
import 'package:blood_nepal/ui/widgets/pastdonations.dart';
import 'package:flutter/material.dart';
import 'package:blood_nepal/ui/home/home.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  var selectedTab = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        title: const Text("Donation History",
            style: TextStyle(
                fontSize: 28,
                letterSpacing: 1.2,
                height: 1.2,
                fontFamily: "Rubik"),
            textAlign: TextAlign.left),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 1.2,
              height: MediaQuery.of(context).size.height * .05,
              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .4,
                    decoration: BoxDecoration(
                      color: selectedTab == 1 ? Colors.red[100] : Colors.white,
                      borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(20),
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          selectedTab = 1;
                        });
                      },
                      child: Text(
                        "Past Donations",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: selectedTab == 1
                                ? FontWeight.bold
                                : FontWeight.normal),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .4,
                    decoration: BoxDecoration(
                        color:
                            selectedTab == 2 ? Colors.red[100] : Colors.white,
                        borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(20),
                        )),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          selectedTab = 2;
                        });
                      },
                      child: Text(
                        "Blood Pressure",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: selectedTab == 2
                                ? FontWeight.bold
                                : FontWeight.normal),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .01),
          if (selectedTab == 1) ...[
            const PastDonations(), // Widget to show when the condition is true
          ] else ...[
            const BloodPressure(),
            // Widget to show when the condition is false
          ],
        ],
      ),
    );
  }
}
