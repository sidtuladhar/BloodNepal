import 'package:flutter/material.dart';
import 'package:blood_nepal/ui/home/home.dart';

class General extends StatefulWidget {
  const General({super.key});

  @override
  State<General> createState() => _GeneralState();
}

class _GeneralState extends State<General> {
  bool isExpanded = false;

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
        body: Column(children: <Widget>[
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(10),
            child: const Text("Frequently Asked Questions:",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900)),
          ),
          const SizedBox(height: 20),
          Container(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 8.0,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              padding: EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFFff9966),
                                    Color(0xFFff5e62),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12.0),
                                  topRight: Radius.circular(12.0),
                                ),
                              ),
                              child: Text(
                                "what is blood donation?",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            AnimatedCrossFade(
                              duration: Duration(milliseconds: 300),
                              crossFadeState: isExpanded
                                  ? CrossFadeState.showSecond
                                  : CrossFadeState.showFirst,
                              firstChild: Container(),
                              secondChild: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  "Blood donation is a voluntary procedure where volunteers provide their blood for a community supply. There are two types of blood donation: 1) whole blood donation and 2) platelet donation. Blood banks often participate in the collection process as well as the procedures that follow it.",
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )))
        ]));
  }

  Widget card(String question, String answer) {
    return ExpansionTile(
        title: Text(question,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.grey[100],
        tilePadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        childrenPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        collapsedBackgroundColor: Colors.white,
        textColor: Colors.black87,
        collapsedTextColor: Colors.black87,
        iconColor: Colors.black54,
        collapsedIconColor: Colors.black54,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10),
            child: Text(answer, style: const TextStyle(fontSize: 15)),
          )
        ]);
  }
}
