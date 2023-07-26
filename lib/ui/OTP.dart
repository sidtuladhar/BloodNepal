import 'package:blood_nepal/ui/signup.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:hive/hive.dart';
import 'package:blood_nepal/api.dart';
import 'package:blood_nepal/ui/widgets/generate_otp.dart';
import 'dart:async';

import 'home/home.dart';

class OTP extends StatefulWidget {
  const OTP({super.key});

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  final Box boxLogin = Hive.box("login");
  ApiService apiService = ApiService();
  int _start = 60; // Countdown duration in seconds
  Timer? _timer;
  bool _isTimerRunning = true; // Flag to check if the timer is r
  double screenHeight = 0;
  double screenWidth = 0;
  double bottom = 0;

  String otpPin = " ";
  TextEditingController pinController = TextEditingController();

  Color blue = const Color(0xff22a1ff);

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    bottom = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
        backgroundColor: blue,
        body: SizedBox(
          height: screenHeight,
          width: screenWidth,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top: screenHeight / 10),
                  child: Column(
                    children: [
                      Text(
                        "Almost Done!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Rubik",
                            color: Colors.white,
                            fontSize: screenWidth / 8),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: circle(5),
              ),
              Transform.translate(
                offset: const Offset(30, -30),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: circle(4.5),
                ),
              ),
              Center(
                child: circle(3),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedContainer(
                  height: bottom > 0 ? screenHeight : screenHeight / 2,
                  width: screenWidth,
                  color: Colors.white,
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.fastLinearToSlowEaseIn,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: screenWidth / 12,
                      right: screenWidth / 12,
                      top: bottom > 0 ? screenHeight / 12 : 0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        stateOTP(),
                        GestureDetector(
                          onTap: () async {
                            if (otpPin.length == 6) {
                              bool verified =
                                  await apiService.verifyPhoneNumber(
                                      boxLogin.get("phoneNumber").toString(),
                                      otpPin);

                              if (verified == true) {
                                Map register = await ApiService().register(
                                    boxLogin.get("fname"),
                                    boxLogin.get("mname"),
                                    boxLogin.get("lname"),
                                    boxLogin.get("email"),
                                    boxLogin.get("address"),
                                    boxLogin.get("phoneNumber").toString(),
                                    boxLogin.get("password"),
                                    boxLogin.get("birthDate"),
                                    boxLogin.get("bloodGroup"),
                                    boxLogin.get("gender"),
                                    0);
                                boxLogin.put("totalDonations", 0);
                                if (register["success"] == true) {
                                  if (!mounted) return;
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const Home();
                                      },
                                    ),
                                  );
                                } else if (register["success"] == false &&
                                    register["error"] ==
                                        "User already exists") {
                                  showSnackBarText(
                                      "Donor already exists. Please use a different phone number to register.");
                                }
                              } else {
                                showSnackBarText("Invalid OTP");
                              }
                            } else {
                              showSnackBarText("Invalid OTP");
                            }
                          },
                          child: Container(
                            height: 50,
                            width: screenWidth,
                            margin: EdgeInsets.only(bottom: screenHeight / 12),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Center(
                              child: Text(
                                "Continue",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const Signup();
                        },
                      ),
                    );
                  },
                  child: Container(
                    height: 50,
                    width: screenWidth / 3,
                    margin: EdgeInsets.only(bottom: screenHeight / 14),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Center(
                      child: Text(
                        "Go Back",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  void showSnackBarText(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  Widget stateOTP() {
    String phoneNumber = boxLogin.get("phoneNumber");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              const TextSpan(
                text: "We just sent a code to \n",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
                ),
              ),
              TextSpan(
                text: phoneNumber,
                style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const TextSpan(
                text: "\nEnter the code here and we can continue!",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        PinCodeTextField(
          controller: pinController,
          appContext: context,
          length: 6,
          onChanged: (value) {
            setState(() {
              otpPin = value;
            });
          },
          pinTheme: PinTheme(
            activeColor: blue,
            selectedColor: blue,
            inactiveColor: Colors.black26,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Didn't receive the code? ",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 14,
              ),
            ),
            if (_isTimerRunning)
              Text(
                '$_start', // Display the countdown value
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            if (!_isTimerRunning) // Show "Resend" button when timer is done
              TextButton(
                onPressed: resendOTP,
                child: const Text(
                  "Resend",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget circle(double size) {
    return Container(
      height: screenHeight / size,
      width: screenHeight / size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
    );
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            _isTimerRunning = false;
          });
          timer.cancel();
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  void resendOTP() {
    String phoneNumber = boxLogin.get("phoneNumber");
    _start = 60;
    setState(() {
      _isTimerRunning = true;
    });
    startTimer();
    ApiService().sendSms(phoneNumber, generateOTP());
  }

  @override
  void dispose() {
    _timer?.cancel();
    pinController.dispose();
    super.dispose();
  }
}
