import 'package:flutter/material.dart';
import 'package:blood_nepal/ui/home/home.dart';
import 'package:blood_nepal/ui/login.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final Box boxLogin = Hive.box("login");

  @override
  Widget build(BuildContext context) {
    String name = boxLogin.get("name");
    String email = boxLogin.get("email");
    String bloodType = boxLogin.get("bloodType");
    String phoneNumber = boxLogin.get("phoneNumber").toString();
    String birthDate = boxLogin.get("birthDate");

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Home();
                  },
                ),
              );
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined, size: 30),
          ),
          toolbarHeight: 85,
          title: const Text("Settings",
              style: TextStyle(
                  fontSize: 28,
                  letterSpacing: 1.2,
                  height: 1.2,
                  fontFamily: "Rubik"),
              textAlign: TextAlign.left),
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(bottom: 3),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: 'Full name',
                    hintText: name,
                    hintStyle: const TextStyle(
                      fontFamily: "Rubik",
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    )),
              ),
              const SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(bottom: 3),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: 'Email address',
                    hintText: email,
                    hintStyle: const TextStyle(
                      fontFamily: "Rubik",
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    )),
              ),
              const SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(bottom: 3),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: 'Phone number',
                    hintText: phoneNumber,
                    hintStyle: const TextStyle(
                      fontFamily: "Rubik",
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    )),
              ),
              const SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: 'Date of birth (dd/mm/yyyy)',
                    hintText: birthDate,
                    hintStyle: TextStyle(
                      fontFamily: "Rubik",
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    )),
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Blood type",
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      textAlign: TextAlign.left),
                  DropdownButtonFormField<String>(
                    style: const TextStyle(
                        fontSize: 18,
                        fontFamily: "Rubik",
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                    isDense: true,
                    items: <String>[
                      'A+',
                      'B+',
                      'O+',
                      'AB+',
                      'A-',
                      'B-',
                      'O-',
                      'AB-',
                      'N/A'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,
                            style: const TextStyle(fontSize: 17),
                            textAlign: TextAlign.center),
                      );
                    }).toList(),
                    value: bloodType,
                    onChanged: (newValue) {
                      bloodType = newValue!;
                      setState(() {
                        newValue;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  boxLogin.put("loginStatus", false);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const Login();
                      },
                    ),
                  );
                },
                child: Row(
                  children: [
                    Icon(Icons.logout_rounded,
                        size: 30, color: Theme.of(context).primaryColor),
                    const SizedBox(width: 10),
                    Text("Logout",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                        textAlign: TextAlign.left),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              const Center(
                  child:
                      Text("Version 0.5", style: TextStyle(color: Colors.grey)))
            ],
          ),
        ));
  }
}
