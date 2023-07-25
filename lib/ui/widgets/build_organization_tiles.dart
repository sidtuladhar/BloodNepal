import 'package:flutter/material.dart';
import 'package:rounded_expansion_tile/rounded_expansion_tile.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Widget buildOrganizationTiles(
    BuildContext context, int index, List organizationData) {
  double latitude = double.parse(organizationData[index]['latitude']);
  double longitude = double.parse(organizationData[index]['longitude']);

  Widget logo;
  if (organizationData[index]['logo'] != null) {
    logo = CircleAvatar(
        backgroundColor: Colors.grey,
        radius: 25,
        backgroundImage: NetworkImage(organizationData[index]['logo']));
  } else {
    logo = const CircleAvatar(
        backgroundColor: Colors.grey,
        radius: 25,
        child: Icon(Icons.home_work, color: Colors.white));
  }

  return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: RoundedExpansionTile(
            minVerticalPadding: 10,
            duration: const Duration(milliseconds: 200),
            horizontalTitleGap: 1,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            tileColor: const Color(0xffff6f6f),
            title: Row(
              children: [
                logo,
                const SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(organizationData[index]['name'],
                        style: const TextStyle(
                            letterSpacing: 1.2,
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: "Rubik")),
                    Text(
                      "${organizationData[index]['distance'].toStringAsFixed(2)} km away",
                      style: const TextStyle(
                          color: Colors.white,
                          //fontWeight: FontWeight.bold,
                          fontFamily: "Rubik",
                          fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
            trailing: const Icon(Icons.arrow_drop_up_rounded, size: 50),
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.cyan[100]),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(children: <Widget>[
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 5),
                                child: Row(
                                  children: [
                                    const Text(
                                      "Mobile Number: ",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Rubik",
                                          fontSize: 18),
                                    ),
                                    Text(
                                      " ${organizationData[index]['phoneNumber']}",
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontFamily: "Rubik",
                                          fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 5),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Address: ",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Rubik",
                                        fontSize: 18,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        " ${organizationData[index]['address']}",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontFamily: "Rubik",
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 5),
                                child: Row(
                                  children: [
                                    const Text(
                                      "Email: ",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Rubik",
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      " ${organizationData[index]['email']}",
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Rubik",
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (organizationData[index]['website'] != null)
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8.0, top: 5),
                                  child: Row(
                                    children: [
                                      const Text(
                                        "Website: ",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Rubik",
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        " ${organizationData[index]['website']}",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontFamily: "Rubik",
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: GoogleMap(
                                    initialCameraPosition: CameraPosition(
                                      target: LatLng(latitude, longitude),
                                      zoom: 12,
                                    ),
                                    markers: {
                                      Marker(
                                        markerId: const MarkerId("marker_1"),
                                        position: LatLng(latitude, longitude),
                                      )
                                    },
                                  ))
                            ],
                          )),
                    ),
                  ]),
                ),
              ),
            ]),
      ));
}
