import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodeFirstName = FocusNode();
  final FocusNode _focusNodeMiddleName = FocusNode();
  final FocusNode _focusNodeLastName = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();
  final FocusNode _focusNodeConfirmPassword = FocusNode();

  String? _selectedBloodGroup;
  String? _selectedGender;
  String? birthDateInString;
  DateTime? birthDate;
  bool isDateSelected = false;

  final TextEditingController _controllerPhoneNumber = TextEditingController();
  final TextEditingController _controllerFirstName = TextEditingController();
  final TextEditingController _controllerMiddleName = TextEditingController();
  final TextEditingController _controllerLastName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConFirmPassword =
      TextEditingController();

  final Box _boxAccounts = Hive.box("login");
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: const Color(0xffEFF0FA),
            body: Form(
                key: _formKey,
                child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(children: [
                      const Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          "Create your account",
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        child: TextFormField(
                          controller: _controllerPhoneNumber,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: "Phone Number",
                              labelStyle: const TextStyle(fontSize: 16),
                              prefixIcon:
                                  Icon(Icons.numbers, color: Colors.grey[600]),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xffE8ECF4), width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xffE8ECF4), width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              fillColor: const Color(0xffE8ECF4),
                              filled: true,
                              hintText: "Phone Number",
                              hintStyle: const TextStyle(fontSize: 16)),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter a valid phone number.";
                            } else if (value.length != 10) {
                              return "Phone number is invalid.";
                            }
                            return null;
                          },
                          onEditingComplete: () =>
                              _focusNodeFirstName.requestFocus(),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: TextFormField(
                                controller: _controllerFirstName,
                                focusNode: _focusNodeFirstName,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.person_outline,
                                        color: Colors.grey[600]),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xffE8ECF4), width: 1),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xffE8ECF4), width: 1),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    fillColor: const Color(0xffE8ECF4),
                                    filled: true,
                                    hintText: "First Name",
                                    hintStyle: const TextStyle(fontSize: 16)),
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return "Enter your first name.";
                                  }
                                  return null;
                                },
                                onEditingComplete: () =>
                                    _focusNodeMiddleName.requestFocus(),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: TextFormField(
                                controller: _controllerMiddleName,
                                focusNode: _focusNodeMiddleName,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.person_outline,
                                        color: Colors.grey[600]),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xffE8ECF4), width: 1),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xffE8ECF4), width: 1),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    fillColor: const Color(0xffE8ECF4),
                                    filled: true,
                                    hintText: "Middle Name",
                                    hintStyle: const TextStyle(fontSize: 16)),
                                onEditingComplete: () =>
                                    _focusNodeLastName.requestFocus(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: TextFormField(
                                    controller: _controllerLastName,
                                    focusNode: _focusNodeLastName,
                                    keyboardType: TextInputType.name,
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.person_outline,
                                            color: Colors.grey[600]),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Color(0xffE8ECF4),
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Color(0xffE8ECF4),
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        fillColor: const Color(0xffE8ECF4),
                                        filled: true,
                                        hintText: "Surname",
                                        hintStyle:
                                            const TextStyle(fontSize: 16)),
                                    validator: (String? value) {
                                      if (value == null || value.isEmpty) {
                                        return "Enter your surname.";
                                      }
                                      return null;
                                    },
                                    onEditingComplete: () =>
                                        _focusNodeMiddleName.requestFocus(),
                                  ),
                                ),
                                SizedBox(
                                  width: 160,
                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                            FontAwesomeIcons.venusMars,
                                            color: Colors.grey[600],
                                            size: 20.0),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Color(0xffE8ECF4),
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Color(0xffE8ECF4),
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        fillColor: const Color(0xffE8ECF4),
                                        filled: true,
                                        hintText: "Gender",
                                        hintStyle:
                                            const TextStyle(fontSize: 14)),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please select';
                                      }
                                      return null;
                                    },
                                    items: <String>[
                                      'Male',
                                      'Female',
                                      'Other',
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value,
                                            style:
                                                const TextStyle(fontSize: 16),
                                            textAlign: TextAlign.center),
                                      );
                                    }).toList(),
                                    value: _selectedGender,
                                    onChanged: (newValue) {
                                      _selectedGender = newValue!;
                                      setState(() {
                                        newValue;
                                      });
                                    },
                                  ),
                                ),
                              ])),
                      Container(
                        padding: const EdgeInsets.all(5.0),
                        child: TextFormField(
                            controller: _controllerEmail,
                            focusNode: _focusNodeEmail,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email_outlined,
                                    color: Colors.grey[600]),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0xffE8ECF4), width: 1),
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0xffE8ECF4), width: 1),
                                    borderRadius: BorderRadius.circular(10)),
                                fillColor: const Color(0xffE8ECF4),
                                filled: true,
                                hintText: "Email"),
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter email.";
                              } else if (!(value.contains('@') &&
                                  value.contains('.'))) {
                                return "Invalid email.";
                              }
                              return null;
                            }),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 63,
                                decoration: BoxDecoration(
                                  color: const Color(0xffE8ECF4),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 12.0),
                                child: GestureDetector(
                                    child: Row(
                                      children: [
                                        Icon(Icons.date_range_outlined,
                                            color: Colors.grey[600],
                                            size: 25.0),
                                        const SizedBox(width: 10.0),
                                        SizedBox(
                                          width: 100,
                                          child: Text(
                                              isDateSelected
                                                  ? " $birthDateInString "
                                                  : "Date of Birth",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey[700])),
                                        )
                                      ],
                                    ),
                                    onTap: () async {
                                      final datePick = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime.now());
                                      if (datePick != null &&
                                          datePick != birthDate) {
                                        setState(() {
                                          birthDate = datePick;
                                          isDateSelected = true;
                                          birthDateInString =
                                              "${birthDate?.day}/${birthDate?.month}/"
                                              "${birthDate?.year}";
                                        });
                                      }
                                    }),
                              ),
                              SizedBox(
                                width: 160,
                                child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.bloodtype_outlined,
                                          color: Colors.grey[600], size: 25.0),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Color(0xffE8ECF4),
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Color(0xffE8ECF4),
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      fillColor: const Color(0xffE8ECF4),
                                      filled: true,
                                      hintText: "Blood Group",
                                      hintStyle: const TextStyle(fontSize: 14)),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please select';
                                    }
                                    return null;
                                  },
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
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value,
                                          style: const TextStyle(fontSize: 16),
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
                              ),
                            ]),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5.0),
                        child: TextFormField(
                          controller: _controllerPassword,
                          obscureText: _obscurePassword,
                          focusNode: _focusNodePassword,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.password_outlined,
                                  color: Colors.grey[600]),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                  icon: _obscurePassword
                                      ? const Icon(
                                          Icons.visibility_off_outlined)
                                      : const Icon(Icons.visibility_outlined)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xffE8ECF4), width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xffE8ECF4), width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              fillColor: const Color(0xffE8ECF4),
                              filled: true,
                              hintText: "Password",
                              hintStyle: const TextStyle(fontSize: 16)),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter password.";
                            } else if (value.length < 8) {
                              return "Password must be at least 8 character.";
                            }
                            return null;
                          },
                          onEditingComplete: () =>
                              _focusNodeConfirmPassword.requestFocus(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextFormField(
                          controller: _controllerConFirmPassword,
                          obscureText: _obscurePassword,
                          focusNode: _focusNodeConfirmPassword,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.password_outlined,
                                  color: Colors.grey[600]),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                  icon: _obscurePassword
                                      ? const Icon(
                                          Icons.visibility_off_outlined)
                                      : const Icon(Icons.visibility_outlined)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xffE8ECF4), width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xffE8ECF4), width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              fillColor: const Color(0xffE8ECF4),
                              filled: true,
                              hintText: "Confirm Password",
                              hintStyle: const TextStyle(fontSize: 16)),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Please confirm your password.";
                            } else if (value != _controllerPassword.text) {
                              return "Password doesn't match.";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  _boxAccounts.put(
                                    _controllerPhoneNumber.hashCode,
                                    _controllerConFirmPassword.text,
                                  );

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      width: 200,
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                      content:
                                          const Text("Registered Successfully"),
                                    ),
                                  );

                                  _formKey.currentState?.reset();

                                  Navigator.pop(context);
                                }
                              },
                              child: const Text("Register",
                                  style: TextStyle(fontSize: 20))),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Already have an account?",
                                style: TextStyle(fontSize: 15),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Login",
                                    style: TextStyle(fontSize: 18)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ])))));
  }

  @override
  void dispose() {
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    _focusNodeConfirmPassword.dispose();
    _controllerPhoneNumber.dispose();
    _controllerFirstName.dispose();
    _controllerMiddleName.dispose();
    _controllerLastName.dispose();
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    _controllerConFirmPassword.dispose();
    super.dispose();
  }
}
