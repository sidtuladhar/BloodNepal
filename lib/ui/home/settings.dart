import 'package:blood_nepal/api.dart';
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
  //final GlobalKey<FormState> _formKey = GlobalKey();
  final Box boxLogin = Hive.box("login");
  bool readOnly = true;
  late String blood;

  final TextEditingController controllerFName = TextEditingController();
  final TextEditingController controllerMName = TextEditingController();
  final TextEditingController controllerLName = TextEditingController();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerAddress = TextEditingController();
  final TextEditingController controllerbloodGroup = TextEditingController();
  final TextEditingController controllerBirthDate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    controllerFName.text = boxLogin.get("fname");
    if (boxLogin.get("mname") == null) {
      controllerMName.text = "";
    } else {
      controllerMName.text = boxLogin.get("mname");
    }
    controllerLName.text = boxLogin.get("lname");
    controllerbloodGroup.text = boxLogin.get("bloodGroup");
    controllerEmail.text = boxLogin.get("email");
    controllerAddress.text = boxLogin.get("address");
    controllerBirthDate.text = boxLogin.get("birthDate").substring(0, 10);

    String phoneNumber = boxLogin.get("phoneNumber").toString();

    return Scaffold(
        resizeToAvoidBottomInset: false,
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
                  controller: controllerFName,
                  readOnly: readOnly,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(bottom: 3),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: 'First name',
                      hintText: controllerFName.text,
                      hintStyle: TextStyle(
                        fontFamily: "Rubik",
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: textColor(readOnly),
                      )),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your first name.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: controllerMName,
                  readOnly: readOnly,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(bottom: 3),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: 'Middle name',
                      hintText: controllerMName.text,
                      hintStyle: TextStyle(
                        fontFamily: "Rubik",
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: textColor(readOnly),
                      )),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: controllerLName,
                  readOnly: readOnly,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(bottom: 3),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: 'Last name',
                      hintText: controllerLName.text,
                      hintStyle: TextStyle(
                        fontFamily: "Rubik",
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: textColor(readOnly),
                      )),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your last name.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                    controller: controllerEmail,
                    readOnly: readOnly,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(bottom: 3),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: 'Email address',
                        hintText: controllerEmail.text,
                        hintStyle: TextStyle(
                          fontFamily: "Rubik",
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: textColor(readOnly),
                        )),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter email.";
                      } else if (!(value.contains('@') &&
                          value.contains('.'))) {
                        return "Invalid email.";
                      }
                      return null;
                    }),
                const SizedBox(height: 20),
                TextFormField(
                  controller: controllerAddress,
                  readOnly: readOnly,
                  keyboardType: TextInputType.streetAddress,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(bottom: 3),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: 'Home Address',
                      hintText: controllerLName.text,
                      hintStyle: TextStyle(
                        fontFamily: "Rubik",
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: textColor(readOnly),
                      )),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your address.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  readOnly: true,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(bottom: 3),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: 'Phone number',
                      hintText: phoneNumber,
                      hintStyle: TextStyle(
                        fontFamily: "Rubik",
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      )),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: controllerBirthDate,
                  readOnly: readOnly,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(bottom: 3),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: 'Date of birth (yyyy-mm-dd)',
                      hintText: controllerBirthDate.text,
                      hintStyle: TextStyle(
                        fontFamily: "Rubik",
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: textColor(readOnly),
                      )),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your date of birth.";
                    } else if (!(value.contains('-')) || value.length != 10) {
                      return "Invalid date of birth.";
                    }
                    return null;
                  },
                  onEditingComplete: () {
                    setState(() {
                      boxLogin.put("birthDate", controllerBirthDate.text);
                    });
                  },
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Blood Group",
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
                      value: boxLogin.get("bloodGroup"),
                      onChanged: readOnly
                          ? null
                          : (newValue) {
                              setState(() {
                                boxLogin.put("bloodGroup", newValue!);
                              });
                            },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () async {
                          var logoutApi =
                              ApiService().logout(boxLogin.get("phoneNumber"));
                          if (await logoutApi) {
                            boxLogin.put("loginStatus", false);
                            if (!mounted) return;
                            navigateToLogin(context);
                          } else {
                            if (!mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Something went wrong. Please try again later.",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        child: Row(
                          children: [
                            Icon(Icons.logout_rounded,
                                size: 30,
                                color: Theme.of(context).primaryColor),
                            const SizedBox(width: 5),
                            Text("Logout",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor),
                                textAlign: TextAlign.left)
                          ],
                        )),
                    TextButton(
                        onPressed: () async {
                          if (readOnly == false) {
                            Future<bool> editProfileApi = ApiService()
                                .editProfile(
                                    controllerFName.text,
                                    controllerMName.text,
                                    controllerLName.text,
                                    controllerEmail.text,
                                    controllerAddress.text,
                                    boxLogin.get("phoneNumber"),
                                    controllerBirthDate.text,
                                    boxLogin.get("bloodGroup"));
                            if (await editProfileApi == true) {
                              boxLogin.put("fname", controllerFName.text);
                              boxLogin.put("mname", controllerMName.text);
                              boxLogin.put("lname", controllerLName.text);
                              boxLogin.put("email", controllerEmail.text);
                              boxLogin.put("address", controllerAddress.text);
                              boxLogin.put(
                                  "birthDate", controllerBirthDate.text);
                              boxLogin.put(
                                  "bloodGroup", boxLogin.get("bloodGroup"));
                            } else {
                              if (!mounted) return;

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Something went wrong. Please try again later.",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                          setState(() {
                            readOnly = !readOnly;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          alignment: Alignment.centerRight,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 2, color: Colors.grey)),
                          child: Text(text(readOnly),
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              textAlign: TextAlign.right),
                        )),
                  ],
                ),
              ],
            )));
  }

  void navigateToLogin(BuildContext context) {
    Future.delayed(Duration.zero, () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const Login(),
        ),
      );
    });
  }

  Color textColor(bool readOnly) {
    if (readOnly) {
      return Colors.green;
    } else {
      return Colors.black;
    }
  }

  String text(bool readOnly) {
    if (readOnly) {
      return "Edit Profile";
    } else {
      return "Save Changes";
    }
  }

  @override
  void dispose() {
    controllerEmail.dispose();
    controllerbloodGroup.dispose();
    controllerBirthDate.dispose();
    controllerFName.dispose();
    controllerMName.dispose();
    controllerLName.dispose();
    super.dispose();
  }
}
