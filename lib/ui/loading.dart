import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'info.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();
    loadAssets(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: loadAssets(context),
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // While assets are loading
                return const Center(
                  child: Center(
                    child: SpinKitFadingCube(
                      color: Colors.red,
                      size: 50.0,
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                // If there's an error loading assets
                return const Center(
                  child: Text('Error loading assets'),
                );
              } else {
                return const Info(); // When assets are loaded, navigate to the main content
              }
            }));
  }
}

Future<void> loadAssets(context) async {
  // Load images
  const image1 = AssetImage('assets/images/doctor.jpg');
  const image2 = AssetImage('assets/images/donate.jpg');
  const image3 = AssetImage('assets/images/patient.jpg');

  // Pre-cache images
  await precacheImage(image1, context);
  await precacheImage(image2, context);
  await precacheImage(image3, context);
}
