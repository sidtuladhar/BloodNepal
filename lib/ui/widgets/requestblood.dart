import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  String? needByDateInString;
  DateTime? needByDate;
  bool isDateSelected = false;

  final FocusNode _focusNodeQuantity = FocusNode();

  final TextEditingController _controllerAddress = TextEditingController();
  final TextEditingController _controllerQuantity = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                    height: 63,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 12.0),
                    child: GestureDetector(
                        child: Row(
                          children: [
                            Icon(Icons.date_range_outlined,
                                color: Colors.grey[600], size: 25.0),
                            const SizedBox(width: 10.0),
                            SizedBox(
                              width: 83,
                              child: Text(
                                  isDateSelected
                                      ? " $needByDateInString "
                                      : "Need Date",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey[700])),
                            )
                          ],
                        ),
                        onTap: () async {
                          final datePick = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2100));
                          if (datePick != null && datePick != needByDate) {
                            setState(() {
                              needByDate = datePick;
                              isDateSelected = true;
                              needByDateInString =
                                  "${needByDate?.day}/${needByDate?.month}/"
                                  "${needByDate?.year}";
                            });
                          }
                        }),
                  ),
                  SizedBox(
                    width: 174,
                    child: DropdownButtonFormField<String>(
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
                      width: 175,
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
              child: TextFormField(
                controller: _controllerAddress,
                keyboardType: TextInputType.streetAddress,
                decoration: InputDecoration(
                    labelText: "Address",
                    labelStyle: const TextStyle(fontSize: 16),
                    prefixIcon: Icon(Icons.place, color: Colors.grey[600]),
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
                    hintText: "Address",
                    hintStyle: const TextStyle(fontSize: 16)),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a valid address.";
                  }
                  return null;
                },
              )),
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
                        content: const Text("Registered Successfully"),
                      ),
                    );

                    _formKey.currentState?.reset();

                    Navigator.pop(context);
                  }
                },
                child: const Text("Send Blood Request",
                    style: TextStyle(fontSize: 20))),
          ]),
        ]));
  }
}
