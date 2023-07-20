import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget buildList(BuildContext context, int index, List leaderboardData) {
  int ind = index + 1;

  if (leaderboardData[index]['mname'] == null) {
    leaderboardData[index]['mname'] = "";
  }

  Widget crown;

  if (ind == 1) {
    crown = const Padding(
        padding: EdgeInsets.only(right: 0.0),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Center(
                child: Icon(
              FontAwesomeIcons.medal,
              size: 36,
              color: Colors.yellow,
            )),
            Padding(
              padding: EdgeInsets.only(left: 8.0, top: 6),
            )
          ],
        ));
  } else if (ind == 2) {
    crown = Padding(
        padding: const EdgeInsets.only(right: 0.0),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Center(
                child: Icon(
              FontAwesomeIcons.medal,
              size: 36,
              color: Colors.grey[300],
            )),
            const Padding(
              padding: EdgeInsets.only(left: 8.0, top: 6),
            )
          ],
        ));
  } else if (ind == 3) {
    crown = Padding(
        padding: const EdgeInsets.only(right: 0.0),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Center(
                child: Icon(
              FontAwesomeIcons.medal,
              size: 36,
              color: Colors.orange[300],
            )),
            const Padding(
              padding: EdgeInsets.only(left: 8.0, top: 6),
              child: Center(
                  child: Text(
                '3',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              )),
            )
          ],
        ));
  } else {
    crown = CircleAvatar(
        backgroundColor: Colors.grey,
        radius: 13,
        child: Text(
          ind.toString(),
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
        ));
  }

  return Padding(
    padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 10),
    child: Container(
      height: 80,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5.0)]),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(right: 0.0),
                child: Row(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15),
                        child: crown,
                      ),
                    ),
                    Align(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 5),
                          child: Text(
                            leaderboardData[index]['fname'] +
                                " " +
                                leaderboardData[index]['mname'] +
                                "\n" +
                                leaderboardData[index]['lname'],
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Rubik",
                                fontSize: 18),
                          ),
                        ),
                      ],
                    )),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                textAlign: TextAlign.center,
                "${leaderboardData[index]['totalQuantity']}\nml",
                style: const TextStyle(
                    color: Colors.black,
                    //fontWeight: FontWeight.bold,
                    fontFamily: "Rubik",
                    fontSize: 18),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 25, bottom: 8.0, top: 8),
              child: Text(
                textAlign: TextAlign.center,
                "${leaderboardData[index]['count']}",
                style: const TextStyle(
                    color: Colors.black,
                    //fontWeight: FontWeight.bold,
                    fontFamily: "Rubik",
                    fontSize: 22),
              ),
            ),
          )
        ],
      ),
    ),
  );
}
