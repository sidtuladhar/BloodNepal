import 'package:flutter/material.dart';

import 'package:blood_nepal/ui/widgets/appbar.dart';
import 'package:blood_nepal/api.dart';
import 'package:blood_nepal/ui/widgets/build_leaderboard.dart';

class Leaderboard extends StatefulWidget {
  const Leaderboard({super.key});

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.red[50],
        appBar: appBar(context, "Leaderboard"),
        body: FutureBuilder<List>(
            future: apiService.getLeaderboard(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
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
