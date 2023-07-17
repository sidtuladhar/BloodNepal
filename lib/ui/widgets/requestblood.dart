import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';

import '../home/home.dart';
import "/api.dart";

class RequestBlood extends StatefulWidget {
  const RequestBlood({super.key});

  @override
  State<RequestBlood> createState() => _RequestBloodState();
}

class _RequestBloodState extends State<RequestBlood> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Box loginBox = Hive.box("login");
  ApiService apiService = ApiService();

  String? _selectedBloodGroup;
  bool isChecked1 = false;
  bool isChecked2 = false;
  String? _selectedBloodType;
  bool isDateSelected = false;
  String needByDateInString = "Need by Date";
  DateTime value = DateTime.now();

  final FocusNode _focusNodeQuantity = FocusNode();
  final FocusNode _focusNodeAddress = FocusNode();
  final FocusNode _focusNodeNeedDate = FocusNode();
  final FocusNode _focusNodeBloodType = FocusNode();
  final FocusNode _focusNodeBloodGroup = FocusNode();

  final TextEditingController _controllerAddress = TextEditingController();
  final TextEditingController _controllerQuantity = TextEditingController();
  final TextEditingController _controllerNeedDate =
      TextEditingController(text: "Need by Date");

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(children: [
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              width: MediaQuery.of(context).size.width * 0.82,
              height: MediaQuery.of(context).size.height * 0.08,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 9.0, vertical: 10.0),
              child: Row(
                children: [
                  Icon(Icons.date_range_outlined,
                      color: Colors.grey[600], size: 25.0),
                  const SizedBox(width: 10.0),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: DateTimeField(
                      controller: _controllerNeedDate,
                      focusNode: _focusNodeNeedDate,
                      format: DateFormat("MMM d, yyyy h:mm a"),
                      validator: (value) {
                        if (value == null) {
                          return 'Please enter a date';
                        }
                        return null;
                      },
                      onShowPicker: (context, currentValue) async {
                        await showCupertinoModalPopup(
                            context: context,
                            builder: (context) {
                              return BottomSheet(
                                builder: (context) => Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      constraints:
                                          const BoxConstraints(maxHeight: 200),
                                      child: CupertinoDatePicker(
                                        onDateTimeChanged: (DateTime date) {
                                          setState(() {
                                            _controllerNeedDate.text =
                                                DateFormat('MMM d, yyyy h:mm a')
                                                    .format(date);
                                            currentValue = date;
                                            value = date;
                                            isDateSelected = true;
                                          });
                                        },
                                      ),
                                    ),
                                    TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Confirm')),
                                  ],
                                ),
                                onClosing: () {},
                              );
                            });
                        return value;
                      },
                      onEditingComplete: () =>
                          _focusNodeQuantity.requestFocus(),
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
                        //height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.width * 0.35,
                        child: TextFormField(
                          controller: _controllerQuantity,
                          focusNode: _focusNodeQuantity,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              prefixIcon: Icon(FontAwesomeIcons.fillDrip,
                                  size: 20, color: Colors.grey[600]),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Quantity",
                              hintStyle: const TextStyle(fontSize: 16)),
                          validator: (String? value) {
                            if (value == null ||
                                value.isEmpty ||
                                int.parse(value) < 1) {
                              return "Quantity required";
                            }
                            return null;
                          },
                          onEditingComplete: () =>
                              _focusNodeBloodGroup.requestFocus(),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: DropdownButtonFormField<String>(
                          focusNode: _focusNodeBloodGroup,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.bloodtype_outlined,
                                  color: Colors.grey[600], size: 25.0),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Blood Group",
                              hintStyle: const TextStyle(fontSize: 16)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select blood group.';
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
                          ].map<DropdownMenuItem<String>>((String value) {
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
                    ])),
            Container(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: TextFormField(
                        controller: _controllerAddress,
                        focusNode: _focusNodeAddress,
                        keyboardType: TextInputType.streetAddress,
                        decoration: InputDecoration(
                            prefixIcon:
                                Icon(Icons.place, color: Colors.grey[600]),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 1),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 1),
                                borderRadius: BorderRadius.circular(10)),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "Address",
                            hintStyle: const TextStyle(fontSize: 16)),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Address required";
                          }
                          return null;
                        },
                        onEditingComplete: () =>
                            _focusNodeBloodType.requestFocus(),
                      )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: DropdownButtonFormField<String>(
                      focusNode: _focusNodeBloodType,
                      decoration: InputDecoration(
                          prefixIcon: Icon(FontAwesomeIcons.fireFlameSimple,
                              color: Colors.grey[600], size: 20),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1),
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1),
                              borderRadius: BorderRadius.circular(10)),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Blood Type",
                          hintStyle: const TextStyle(fontSize: 16)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select blood type.';
                        }
                        return null;
                      },
                      items: <String>[
                        'Whole Blood',
                        'Platelets',
                        'Plasma',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                              style: const TextStyle(fontSize: 16),
                              textAlign: TextAlign.center),
                        );
                      }).toList(),
                      value: _selectedBloodType,
                      onChanged: (newValue) {
                        _selectedBloodType = newValue!;
                        setState(() {
                          newValue;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            CheckboxListTile(
              title: const Text(
                  'I agree that this request will be public for all organizations to see.'),
              dense: true,
              value: isChecked1,
              onChanged: (bool? value) {
                setState(() {
                  isChecked1 = value!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: const Text(
                  'I agree that I will be charged a fee if the blood bag is not returned within 24 hours.'),
              dense: true,
              value: isChecked2,
              onChanged: (bool? value) {
                setState(() {
                  isChecked2 = value!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            const SizedBox(height: 30),
            Column(children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      if (!isChecked1 || !isChecked2) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          width: 200,
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          behavior: SnackBarBehavior.floating,
                          content: const Text(
                              "Please agree to the terms and conditions."),
                        ));
                        return;
                      } else {
                        bool isSuccessful = await ApiService().sendRequest(
                          loginBox.get('phoneNumber'),
                          _selectedBloodGroup!,
                          int.parse(_controllerQuantity.text),
                          _selectedBloodType!,
                          _controllerAddress.text,
                          value,
                        );
                        if (isSuccessful) {
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            width: 200,
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            behavior: SnackBarBehavior.floating,
                            content: const Text(
                                "Registered Successfully! Check the 'My Requests' tab to see your request."),
                          ));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return Home();
                              },
                            ),
                          );
                        } else {
                          if (!mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              width: 200,
                              backgroundColor:
                                  Theme.of(context).colorScheme.secondary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              behavior: SnackBarBehavior.floating,
                              content: const Text(
                                  "Something went wrong. Please try again.")));
                        }
                      }
                    }
                  },
                  child: const Text("Send Blood Request",
                      style: TextStyle(fontSize: 20))),
            ]),
          ])),
    );
  }

  @override
  void dispose() {
    _controllerQuantity.dispose();
    _controllerAddress.dispose();
    _focusNodeQuantity.dispose();
    _focusNodeAddress.dispose();
    _focusNodeBloodType.dispose();
    super.dispose();
  }
}
