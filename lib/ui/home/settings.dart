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
  String _selectedBloodGroup = 'O+';
  final Box _boxLogin = Hive.box("login");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const Home();
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
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: 'Full name',
                    hintText: "Siddhartha Tuladhar",
                    hintStyle: TextStyle(
                      fontFamily: "Rubik",
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    )),
              ),
              const SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: 'Email address',
                    hintText: "siddhartha.tuladhar@yahoo.com",
                    hintStyle: TextStyle(
                      fontFamily: "Rubik",
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    )),
              ),
              const SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: 'Phone number',
                    hintText: "1234567890",
                    hintStyle: TextStyle(
                      fontFamily: "Rubik",
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    )),
              ),
              const SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.datetime,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 3),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: 'Date of birth (dd/mm/yyyy)',
                    hintText: "23/12/2002",
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
                    value: _selectedBloodGroup,
                    onChanged: (newValue) {
                      _selectedBloodGroup = newValue!;
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
                  _boxLogin.put("loginStatus", false);
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
            ],
          ),
        ));
  }
}
