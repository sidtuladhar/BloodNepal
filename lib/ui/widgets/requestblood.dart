import 'package:flutter/material.dart';

class RequestBlood extends StatefulWidget {
  const RequestBlood({super.key});

  @override
  State<RequestBlood> createState() => _RequestBloodState();
}

class _RequestBloodState extends State<RequestBlood> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(children: [
        Container(
          padding: const EdgeInsets.all(5),
          child: TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: "Phone Number",
                labelStyle: const TextStyle(fontSize: 16),
                prefixIcon: Icon(Icons.numbers, color: Colors.grey[600]),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Color(0xffE8ECF4), width: 1),
                    borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Color(0xffE8ECF4), width: 1),
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
          ),
        ),
      ]),
    );
  }
}
