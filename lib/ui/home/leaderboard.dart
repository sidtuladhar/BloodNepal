import 'package:flutter/material.dart';
import 'package:blood_nepal/ui/home/home.dart';
import 'package:blood_nepal/api.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Leaderboard extends StatefulWidget {
  const Leaderboard({super.key});

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  final Box boxLogin = Hive.box("login");
  ApiService apiService = ApiService();

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
          title: const Text("Leaderboard",
              style: TextStyle(
                  fontSize: 28,
                  letterSpacing: 1.2,
                  height: 1.2,
                  fontFamily: "Rubik"),
              textAlign: TextAlign.left),
        ),
        body: FutureBuilder<List>(
            future: apiService.getLeaderboard(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                final leaderboardData = snapshot.data as List;

                return ListView.builder(
                  itemCount: leaderboardData.length,
                  itemBuilder: (BuildContext context, int index) =>
                      buildList(context, index, leaderboardData),
                );
              } else {
                return const Text('No data available');
              }
            }));
  }
}

Widget buildList(BuildContext context, int index, List leaderboardData) {
  int ind = index + 1;

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
