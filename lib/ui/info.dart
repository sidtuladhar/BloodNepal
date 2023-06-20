import 'package:flutter/material.dart';

import 'login.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Info(),
  ));
}

class Info extends StatefulWidget {
  const Info({super.key});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  late PageController _pageController;
  int currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20, top: 5),
              child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    );
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
            )
          ],
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            PageView(
                onPageChanged: (int page) {
                  setState(() {
                    currentIndex = page;
                  });
                },
                controller: _pageController,
                children: <Widget>[
                  makePage(
                      image: 'assets/images/donate.jpg',
                      title: 'Welcome to \n Blood Nepal',
                      content:
                          'We are here to help you track your blood donations.',
                      context: context),
                  makePage(
                      reverse: true,
                      image: 'assets/images/patient.jpg',
                      title: 'Donate blood and save lives',
                      content: 'One blood donation can potentially '
                          'save up to three lives.',
                      context: context),
                  makePage(
                      image: 'assets/images/doctor.jpg',
                      title: 'Blood donation \nhas many benefits',
                      content:
                          'Donating blood reduces the risk of heart disease, '
                          'lowers the risk of cancer, burns calories, '
                          'and improves liver health.',
                      context: context),
                ]),
            Container(
              margin: const EdgeInsets.only(bottom: 60),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildIndicator(currentIndex, context)),
            )
          ],
        ));
  }
}

Widget makePage({image, title, content, reverse = false, context}) {
  return Container(
    padding: const EdgeInsets.only(left: 50, right: 50, bottom: 60),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        !reverse
            ? Column(
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Image.asset(image,
                          width: MediaQuery.of(context).size.width * 0.8)),
                  const SizedBox(height: 30),
                ],
              )
            : const SizedBox(),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Text(
          content,
          textAlign: TextAlign.start,
          style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w400,
              height: 1.2),
        ),
        reverse
            ? Column(
                children: <Widget>[
                  const SizedBox(height: 30),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Image.asset(image,
                          width: MediaQuery.of(context).size.width * 0.8)),
                ],
              )
            : const SizedBox(),
      ],
    ),
  );
}

Widget _indicator(bool isActive, context) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    height: 6,
    width: isActive ? 30 : 6,
    margin: const EdgeInsets.only(right: 5),
    decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(5)),
  );
}

List<Widget> _buildIndicator(currentIndex, context) {
  List<Widget> indicators = [];
  for (int i = 0; i < 3; i++) {
    if (currentIndex == i) {
      indicators.add(_indicator(true, context));
    } else {
      indicators.add(_indicator(false, context));
    }
  }
  return indicators;
}
