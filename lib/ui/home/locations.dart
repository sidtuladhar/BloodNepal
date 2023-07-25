import 'package:blood_nepal/ui/widgets/build_organization_tiles.dart';
import 'package:blood_nepal/ui/home/home.dart';
import 'package:blood_nepal/api.dart';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Locations extends StatefulWidget {
  const Locations({super.key});

  @override
  State<Locations> createState() => _LocationsState();
}

class _LocationsState extends State<Locations> {
  ApiService apiService = ApiService();
  final Box boxLogin = Hive.box("login");

  @override
  Widget build(BuildContext context) {
    double latitude = boxLogin.get("latitude");
    double longitude = boxLogin.get("longitude");
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const Home();
                  },
                ),
              );
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined, size: 30),
          ),
          toolbarHeight: 85,
          title: const Text("Blood Bank Locations",
              style: TextStyle(
                  fontSize: 25,
                  letterSpacing: 1.2,
                  height: 1.2,
                  fontFamily: "Rubik"),
              textAlign: TextAlign.left),
        ),
        body: FutureBuilder<List>(
            future: apiService.getOrganizations(latitude, longitude),
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
                      buildOrganizationTiles(context, index, leaderboardData),
                );
              } else {
                return const Text('No data available');
              }
            }));
  }
}
