import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final FocusNode _focusNodeEmail = FocusNode();
  final FocusNode _focusNodeFullName = FocusNode();
  final FocusNode _focusNodePassword = FocusNode();
  final FocusNode _focusNodeConfirmPassword = FocusNode();

  String? _selectedBloodGroup;
  String? birthDateInString;
  DateTime? birthDate;
  bool isDateSelected = false;

  final TextEditingController _controllerPhoneNumber = TextEditingController();
  final TextEditingController _controllerFullName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConFirmPassword =
      TextEditingController();

  final Box _boxAccounts = Hive.box("login");
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEFF0FA),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              const SizedBox(height: 70),
              const Text(
                "Create your account",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _controllerPhoneNumber,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  labelStyle: const TextStyle(fontSize: 18),
                  prefixIcon: Icon(Icons.numbers, color: Colors.grey[600]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a valid phone number.";
                  } else if (value.length != 10) {
                    return "Phone number is invalid.";
                  } else if (_boxAccounts.containsKey(value)) {
                    return "Phone number is already registered.";
                  }
                  return null;
                },
                onEditingComplete: () => _focusNodeFullName.requestFocus(),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _controllerFullName,
                focusNode: _focusNodeFullName,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: "Full Name",
                  labelStyle: const TextStyle(fontSize: 18),
                  prefixIcon:
                      Icon(Icons.person_outline, color: Colors.grey[600]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your full name.";
                  } else if (!(value.contains(' '))) {
                    return "Invalid full name.";
                  }
                  return null;
                },
                onEditingComplete: () => _focusNodeEmail.requestFocus(),
              ),
              const SizedBox(height: 10),
              TextFormField(
                  controller: _controllerEmail,
                  focusNode: _focusNodeEmail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: const TextStyle(fontSize: 18),
                    prefixIcon:
                        Icon(Icons.email_outlined, color: Colors.grey[600]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter email.";
                    } else if (!(value.contains('@') && value.contains('.'))) {
                      return "Invalid email.";
                    }
                    return null;
                  }),
              const SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                            child: Row(
                              children: [
                                Icon(Icons.date_range_outlined,
                                    color: Colors.grey[600], size: 25.0),
                                const SizedBox(width: 10.0),
                                SizedBox(
                                  width: 110,
                                  child: Text(
                                      isDateSelected
                                          ? " $birthDateInString "
                                          : "Date of Birth",
                                      style: TextStyle(
                                          fontSize: 17,
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
                              if (datePick != null && datePick != birthDate) {
                                setState(() {
                                  birthDate = datePick;
                                  isDateSelected = true;
                                  birthDateInString =
                                      "${birthDate?.day}/${birthDate?.month}/"
                                      "${birthDate?.year}";
                                });
                              }
                            }),
                      ],
                    )),
                Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    height: 50,
                    width: 155,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 10),
                        Icon(Icons.bloodtype_outlined,
                            color: Colors.grey[600], size: 25.0),
                        const SizedBox(width: 5),
                        SizedBox(
                          width: 110,
                          child: DropdownButtonFormField<String>(
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
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,
                                    style: const TextStyle(fontSize: 17),
                                    textAlign: TextAlign.center),
                              );
                            }).toList(),
                            value: _selectedBloodGroup,
                            hint: const Text(
                              'Blood type',
                              style: TextStyle(fontSize: 17),
                              textAlign: TextAlign.left,
                            ),
                            onChanged: (newValue) {
                              _selectedBloodGroup = newValue!;
                              setState(() {
                                newValue;
                              });
                            },
                          ),
                        ),
                      ],
                    )),
              ]),
              const SizedBox(height: 10),
              TextFormField(
                controller: _controllerPassword,
                obscureText: _obscurePassword,
                focusNode: _focusNodePassword,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: "Password",
                  labelStyle: const TextStyle(fontSize: 18),
                  prefixIcon:
                      Icon(Icons.password_outlined, color: Colors.grey[600]),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      icon: _obscurePassword
                          ? const Icon(Icons.visibility_off_outlined)
                          : const Icon(Icons.visibility_outlined)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
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
              const SizedBox(height: 10),
              TextFormField(
                controller: _controllerConFirmPassword,
                obscureText: _obscurePassword,
                focusNode: _focusNodeConfirmPassword,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  labelStyle: const TextStyle(fontSize: 18),
                  prefixIcon:
                      Icon(Icons.password_outlined, color: Colors.grey[600]),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      icon: _obscurePassword
                          ? const Icon(Icons.visibility_off_outlined)
                          : const Icon(Icons.visibility_outlined)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter password.";
                  } else if (value != _controllerPassword.text) {
                    return "Password doesn't match.";
                  }
                  return null;
                },
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
                        if (_formKey.currentState?.validate() ?? false) {
                          _boxAccounts.put(
                            _controllerPhoneNumber.hashCode,
                            _controllerConFirmPassword.text,
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              width: 200,
                              backgroundColor:
                                  Theme.of(context).colorScheme.secondary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              behavior: SnackBarBehavior.floating,
                              content: const Text("Registered Successfully"),
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
                        child:
                            const Text("Login", style: TextStyle(fontSize: 18)),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    _focusNodeConfirmPassword.dispose();
    _controllerPhoneNumber.dispose();
    _controllerFullName.dispose();
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    _controllerConFirmPassword.dispose();
    super.dispose();
  }
}
