import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';

import '../../api.dart';
import 'build_event_tiles.dart';

class Events extends StatefulWidget {
  const Events({super.key});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  @override
  Widget build(BuildContext context) {
    ApiService apiService = ApiService();
    final Box boxLogin = Hive.box("login");
    double latitude = boxLogin.get("latitude");
    double longitude = boxLogin.get("longitude");

    return FutureBuilder<List>(
        future: apiService.getEvents(latitude, longitude),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: CircularProgressIndicator(),
            ));
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            final eventData = snapshot.data as List;
            if (latitude == 0) {
              return Center(
                  child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Text(
                      "Please turn on your location to view events near you.",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 30),
                  Icon(FontAwesomeIcons.circleExclamation,
                      color: Colors.red[800], size: 50)
                ],
              ));
            }

            return SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.77,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount: eventData.length,
                  itemBuilder: (BuildContext context, int index) =>
                      buildEventTiles(context, index, eventData),
                ),
              ),
            );
          } else {
            return const Text('No data available');
          }
        });
  }
}
