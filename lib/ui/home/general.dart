import 'package:flutter/material.dart';
import 'package:blood_nepal/ui/home/home.dart';
import 'package:rounded_expansion_tile/rounded_expansion_tile.dart';

class General extends StatefulWidget {
  const General({super.key});

  @override
  State<General> createState() => _GeneralState();
}

class _GeneralState extends State<General> {
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
        ),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(10),
              child: const Text("Frequently Asked Questions:",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900)),
            ),
            card(
                "Can I donate blood?",
                "To be eligible to donate blood, you must meet the following requirements:\n\n"
                    "• Be 18 to 60 years old\n"
                    "• Weight above 45kg \n"
                    "• Have hemoglobin above 12 gm/dl\n"
                    "• Have blood pressure 110-160 / 70-96 mmHg\n"
                    "• Not had a medical surgery for 2 years\n"
                    "• Not be pregnant or breastfeeding\n"
                    "• Have at least 8 days since the start of the recent menstruation\n"
                    "• Not having recent use of drugs or strong medicines"),
            const SizedBox(height: 5),
            card("Can I donate if I have a tattoo or piercing?",
                "Yes, 4 months after the tattoo or piercing completely heals"),
            const SizedBox(height: 5),
            card("How long does it take to donate blood?",
                "The whole process takes about 30 minutes"),
            const SizedBox(height: 5),
            card("How often can I donate blood?",
                "You can donate blood every 3 months"),
            const SizedBox(height: 5),
            card("What should I bring to the donation?",
                "You must bring a valid ID card (Citizenship, Passport, Driving License, etc.)"),
          ]),
        ));
  }

  Widget card(String question, String answer) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.grey[300],
        child: RoundedExpansionTile(
          duration: const Duration(milliseconds: 300),
          horizontalTitleGap: 1,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(question,
              style:
                  const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          trailing: const Icon(Icons.arrow_drop_up_rounded, size: 50),
          children: [
            Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.all(15),
                child: Text(
                  answer,
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      height: 1.2,
                      fontWeight: FontWeight.w500),
                )),
          ],
        ));
  }
}
