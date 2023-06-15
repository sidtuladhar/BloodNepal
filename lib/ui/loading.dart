import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  void initState() {
    super.initState();
    Navigator.pushReplacementNamed(context, "/home", arguments: {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitFadingCube(
        color: Colors.red[900],
        size: 50.0,
      ),
    );
  }
}
