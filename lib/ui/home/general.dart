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
            title: Container(
              child: const Text("General Information",
                  style: TextStyle(
                      fontSize: 28,
                      letterSpacing: 1.2,
                      height: 1.2,
                      fontFamily: "Rubik"),
                  textAlign: TextAlign.left),
            )),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(children: <Widget>[
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Text("Frequently Asked Questions:",
                      style: TextStyle(
                          fontFamily: "Rubik",
                          fontSize: 28,
                          fontWeight: FontWeight.w500)),
                ),
                Divider(
                    thickness: 3,
                    indent: 10,
                    endIndent: 100,
                    color: Theme.of(context).colorScheme.secondary),
                const SizedBox(height: 20),
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
                    "Yes, 4 months after the tattoo or piercing completely heals."),
                const SizedBox(height: 5),
                card("How long does it take to donate blood?",
                    "The whole process takes about 30 minutes."),
                const SizedBox(height: 5),
                card("How often can I donate blood?",
                    "You can donate blood every 3 months."),
                const SizedBox(height: 5),
                card("What should I bring to the donation?",
                    "You must bring a valid ID card (Citizenship, Passport, Driving License, etc.)"),
              ]),
            ),
          ]),
        ));
  }

  Widget card(String question, String answer) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: RoundedExpansionTile(
          minVerticalPadding: 10,
          duration: const Duration(milliseconds: 200),
          horizontalTitleGap: 1,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          tileColor: Theme.of(context).primaryColor,
          title: Text(question,
              style: const TextStyle(
                  letterSpacing: 1.2,
                  fontSize: 22,
                  color: Colors.white,
                  fontFamily: "Rubik")),
          trailing: const Icon(Icons.arrow_drop_up_rounded, size: 50),
          children: [
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[400]),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  answer,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[900],
                      height: 1.2,
                      fontFamily: "Rubik",
                      fontWeight: FontWeight.w500),
                )),
          ],
        ));
  }
}
