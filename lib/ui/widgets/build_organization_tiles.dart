import 'package:flutter/material.dart';
import 'package:rounded_expansion_tile/rounded_expansion_tile.dart';

Widget buildOrganizationTiles(
    BuildContext context, int index, List leaderboardData) {
  int ind = index + 1;
  double leftPadding = 38;

  Widget crown;

  crown = CircleAvatar(
      backgroundColor: Colors.grey,
      radius: 13,
      child: Text(
        ind.toString(),
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
      ));

  return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: RoundedExpansionTile(
            minVerticalPadding: 10,
            duration: const Duration(milliseconds: 200),
            horizontalTitleGap: 1,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            tileColor: Theme.of(context).primaryColor,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(leaderboardData[index]['name'],
                    style: const TextStyle(
                        letterSpacing: 1.2,
                        fontSize: 20,
                        color: Colors.white,
                        fontFamily: "Rubik")),
                Text(
                  "${leaderboardData[index]['distance'].toStringAsFixed(2)} km",
                  style: const TextStyle(
                      color: Colors.white,
                      //fontWeight: FontWeight.bold,
                      fontFamily: "Rubik",
                      fontSize: 16),
                ),
              ],
            ),
            trailing: const Icon(Icons.arrow_drop_up_rounded, size: 50),
            children: [
              Row(children: <Widget>[
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
                              padding:
                                  const EdgeInsets.only(left: 15.0, right: 15),
                              child: crown,
                            ),
                          ),
                          const Align(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 8.0, top: 5),
                                child: Text(
                                  "text",
                                  style: TextStyle(
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
                Padding(
                  padding: EdgeInsets.only(left: leftPadding, top: 17),
                  child: Text(
                    "${leaderboardData[index]['distance'].toStringAsFixed(1)} km",
                    style: const TextStyle(
                        color: Colors.black,
                        //fontWeight: FontWeight.bold,
                        fontFamily: "Rubik",
                        fontSize: 22),
                  ),
                ),
              ]),
            ]),
      ));
}
