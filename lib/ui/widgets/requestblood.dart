import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../home/home.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';

class RequestBlood extends StatefulWidget {
  const RequestBlood({super.key});

  @override
  State<RequestBlood> createState() => _RequestBloodState();
}

class _RequestBloodState extends State<RequestBlood> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  String? _selectedBloodGroup;
  bool isChecked1 = false;
  bool isChecked2 = false;
  String? _selectedBloodType;
  bool isDateSelected = false;
  String? needByDateInString;
  DateTime value = DateTime.now();

  final FocusNode _focusNodeQuantity = FocusNode();

  final TextEditingController _controllerAddress = TextEditingController();
  final TextEditingController _controllerQuantity = TextEditingController();
  final TextEditingController _controllerNeedDate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _controllerNeedDate.text = "Select Need By Date";
    return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(children: [
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(5.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: Row(
                      children: [
                        Icon(Icons.date_range_outlined,
                            color: Colors.grey[600], size: 25.0),
                        const SizedBox(width: 10.0),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.68,
                          child: DateTimeField(
                            controller: _controllerNeedDate,
                            format: DateFormat("MMM d, yyyy h:mm a"),
                            onShowPicker: (context, currentValue) async {
                              await showCupertinoModalPopup(
                                  context: context,
                                  builder: (context) {
                                    return BottomSheet(
                                      builder: (context) => Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            constraints: const BoxConstraints(
                                                maxHeight: 200),
                                            child: CupertinoDatePicker(
                                              onDateTimeChanged:
                                                  (DateTime date) {
                                                setState(() {
                                                  _controllerNeedDate
                                                      .text = DateFormat(
                                                          'MMM d, yyyy h:mm a')
                                                      .format(date);
                                                });
                                              },
                                            ),
                                          ),
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: const Text('Confirm')),
                                        ],
                                      ),
                                      onClosing: () {},
                                    );
                                  });
                              return value;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
          ),
          const SizedBox(height: 10),
          Container(
              padding: const EdgeInsets.all(5),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
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
                          if (value == null || value.isEmpty) {
                            return "Enter a valid quantity.";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: DropdownButtonFormField<String>(
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
                            return 'Please select';
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
                  ])),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: TextFormField(
                      controller: _controllerAddress,
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
                          return "Please enter a valid address.";
                        }
                        return null;
                      },
                    )),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.bloodtype_outlined,
                            color: Colors.grey[600], size: 25.0),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Blood Group",
                        hintStyle: const TextStyle(fontSize: 16)),
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
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Checkbox(
                value: isChecked1,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked1 = value!;
                  });
                },
              ),
              const Text(
                "I understand that this request will be posted \non the app for all the organizations to see.",
                style: TextStyle(fontSize: 14),
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Checkbox(
                value: isChecked2,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked2 = value!;
                  });
                },
              ),
              const Text(
                "I understand that I will be charged a fee if \nI do not return the blood bag within 24 hours.",
                style: TextStyle(fontSize: 14),
              )
            ],
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
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        width: 200,
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        behavior: SnackBarBehavior.floating,
                        content: const Text(
                            "Registered Successfully! Check the 'My Requests' tab to see your request."),
                      ),
                    );

                    _formKey.currentState?.reset();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Home();
                        },
                      ),
                    );
                  }
                },
                child: const Text("Send Blood Request",
                    style: TextStyle(fontSize: 20))),
          ]),
        ]));
  }
}
