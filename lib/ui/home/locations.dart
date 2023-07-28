import 'package:blood_nepal/ui/widgets/bloodbanks.dart';
import 'package:blood_nepal/ui/widgets/events.dart';
import '../widgets/appbar.dart';

import 'package:flutter/material.dart';

class Locations extends StatefulWidget {
  const Locations({super.key});

  @override
  State<Locations> createState() => _LocationsState();
}

class _LocationsState extends State<Locations> {
  var selectedTab = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: appBar(context, "Blood Banks & Events"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 1.2,
              height: MediaQuery.of(context).size.height * .05,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .4,
                    decoration: BoxDecoration(
                      color:
                          selectedTab == 1 ? Colors.red[100] : Colors.red[50],
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
                        "Blood Banks",
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
                            selectedTab == 2 ? Colors.red[100] : Colors.red[50],
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
                        "Upcoming Events",
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
            const BloodBanks(), // Widget to show when the condition is true
          ] else ...[
            const Events(), // Widget to show when the condition is false
          ],
        ],
      ),
    );
  }
}
