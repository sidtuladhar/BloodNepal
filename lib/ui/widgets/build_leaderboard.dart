import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget buildList(BuildContext context, int index, List leaderboardData) {
  int ind = index + 1;
  double leftPadding = 38;

  if (leaderboardData[index]['count'].toString().length == 2) {
    leftPadding = 33;
  } else {
    leftPadding = 39;
  }

  if (leaderboardData[index]['mname'] == null) {
    leaderboardData[index]['mname'] = "";
  }

  Widget crown;

  if (ind == 1) {
    crown = const Padding(
        padding: EdgeInsets.only(right: 0.0),
        child: Center(
            child: Icon(
          FontAwesomeIcons.medal,
          size: 36,
          color: Colors.yellow,
        )));
  } else if (ind == 2) {
    crown = Padding(
        padding: const EdgeInsets.only(right: 0.0),
        child: Center(
            child: Icon(
          FontAwesomeIcons.medal,
          size: 36,
          color: Colors.grey[300],
        )));
  } else if (ind == 3) {
    crown = Padding(
        padding: const EdgeInsets.only(right: 0.0),
        child: Center(
            child: Icon(
          FontAwesomeIcons.medal,
          size: 36,
          color: Colors.orange[300],
        )));
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
      height: 60,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xff92bdef), Color(0xffa2d2ff)]),
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
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
            child: Stack(children: [
              const Padding(
                  padding:
                      EdgeInsets.only(left: 20.0, top: 5, bottom: 5, right: 20),
                  child: Icon(
                    FontAwesomeIcons.certificate,
                    size: 50,
                    color: Color(0xfff6e2bd),
                  )),
              Padding(
                padding: EdgeInsets.only(left: leftPadding, top: 17),
                child: Text(
                  "${leaderboardData[index]['count']}",
                  style: const TextStyle(
                      color: Colors.black,
                      //fontWeight: FontWeight.bold,
                      fontFamily: "Rubik",
                      fontSize: 22),
                ),
              ),
            ]),
          )
        ],
      ),
    ),
  );
}
