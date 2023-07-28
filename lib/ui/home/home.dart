import 'package:blood_nepal/ui/home/settings.dart';
import 'package:blood_nepal/ui/home/history.dart';
import 'package:blood_nepal/ui/home/general.dart';
import 'package:blood_nepal/ui/home/leaderboard.dart';
import 'package:blood_nepal/ui/home/requests.dart';
import 'package:blood_nepal/ui/home/locations.dart';
import 'package:blood_nepal/ui/widgets/carousel.dart';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:geolocator/geolocator.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<Position> currentLocation;
  final Box boxLogin = Hive.box("login");

  @override
  void initState() {
    super.initState();
    currentLocation = _determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    String firstName = boxLogin.get("fname");
    int firstNameLength = firstName.length;
    if (firstNameLength > 13) {
      firstName = firstName.substring(0, 13);
    }
    String lastName = boxLogin.get("lname");
    int lastNameLength = lastName.length;
    if (lastNameLength > 13) {
      lastName = lastName.substring(0, 13);
    }
    final String? bloodGroup = boxLogin.get("bloodGroup");
    final int totalDonations = boxLogin.get("totalDonations");

    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          shape: ShapeBorder.lerp(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Theme.of(context).primaryColor)),
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Theme.of(context).primaryColor)),
              10),
          leadingWidth: 0,
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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$firstName\n$lastName',
                      style: const TextStyle(
                          fontSize: 20, letterSpacing: 1.2, height: 1.2),
                      textAlign: TextAlign.left),
                ],
              ),
              const SizedBox(width: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("BLOOD\nGROUP",
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.left),
                  Text("$bloodGroup",
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left)
                ],
              ),
              const SizedBox(width: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("TOTAL\nDONATIONS",
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.left),
                  Text("$totalDonations",
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left)
                ],
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 20),
                  const Text(
                    'Upcoming Events',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  FutureBuilder<Position>(
                      future: currentLocation,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data?.longitude != null &&
                              snapshot.data?.latitude != null) {
                            boxLogin.put("latitude", snapshot.data!.latitude);
                            boxLogin.put("longitude", snapshot.data!.longitude);
                          } else {
                            boxLogin.put("latitude", 0);
                            boxLogin.put("longitude", 0);
                          }
                          return const Carousel();
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        return const Center(
                            child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 57.0),
                          child: CircularProgressIndicator(),
                        ));
                      }),
                  const SizedBox(height: 20),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        homeButton("Blood Bank \n& Events", context,
                            const Locations(), Icons.location_on),
                        homeButton("Donation History", context, const History(),
                            Icons.article),
                      ]),
                  const SizedBox(height: 20),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        homeButton("Leaderboard", context, const Leaderboard(),
                            Icons.leaderboard),
                        homeButton("Request Blood", context, const Requests(),
                            Icons.handshake_rounded),
                      ]),
                  const SizedBox(height: 20),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        homeButton("General Info", context, const General(),
                            Icons.info),
                        homeButton("Settings", context, const Settings(),
                            Icons.settings),
                      ])
                ],
              ),
            ),
            // const SizedBox(height: 10),
          ])),
        ));
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}

homeButton(String text, context, target, IconData icon) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        fixedSize: const Size(140, 130),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return target;
            },
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 30),
          const SizedBox(height: 5),
          Text(
            text,
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ],
      ));
}
