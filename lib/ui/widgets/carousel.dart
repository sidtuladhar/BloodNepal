import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:blood_nepal/api.dart';

class Carousel extends StatefulWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  final Box boxLogin = Hive.box("login");
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    final double latitude = boxLogin.get("latitude");
    final double longitude = boxLogin.get("longitude");

    if (latitude == 0) {
      return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).dividerColor,
                    Theme.of(context).disabledColor,
                  ])),
          child: Container(
            padding: const EdgeInsets.all(15),
            height: 150,
            child: Center(
                child: Column(
              children: [
                const Text("Turn on location to view upcoming events.",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Icon(FontAwesomeIcons.circleExclamation,
                    color: Colors.red[800], size: 50)
              ],
            )),
          ));
    } else {
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
              final events = snapshot.data as List;
              List<Image> imgList = [];
              for (int i = 0; i < events.length; i++) {
                String base64Image = events[i]["pictures"];
                Uint8List bytes = base64Decode(base64Image.replaceAll(
                    RegExp(r'data:image/\w+;base64,'), ''));
                ImageProvider imageProvider = MemoryImage(bytes);
                imgList.add(Image(
                  image: imageProvider,
                  fit: BoxFit.fill,
                ));
              }

              return carousel(context, imgList);
            } else {
              return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Theme.of(context).dividerColor,
                            Theme.of(context).disabledColor,
                          ])),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    height: 150,
                    child: const Center(
                        child: Column(
                      children: [
                        Text("There are no upcoming events.",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold))
                      ],
                    )),
                  ));
            }
          });
    }
  }

  Container carousel(context, List<Image> imgList) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).dividerColor,
                  Theme.of(context).disabledColor,
                ])),
        margin: const EdgeInsets.only(top: 5),
        child: CarouselSlider(
            options: CarouselOptions(
                height: 150,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 5),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                pauseAutoPlayOnTouch: true,
                aspectRatio: 16 / 9,
                viewportFraction: 1.0,
                onPageChanged: (index, reason) {}),
            items: imgList));
  }
}
