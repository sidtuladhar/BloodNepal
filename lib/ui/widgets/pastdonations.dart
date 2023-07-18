import 'package:flutter/material.dart';
import 'package:blood_nepal/api.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class PastDonations extends StatefulWidget {
  const PastDonations({super.key});

  @override
  State<PastDonations> createState() => _PastDonationsState();
}

class _PastDonationsState extends State<PastDonations> {
  ApiService apiService = ApiService();
  final Box _boxLogin = Hive.box("login");

  @override
  Widget build(BuildContext context) {
    String phoneNumber = _boxLogin.get("phoneNumber").toString();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
          child: FutureBuilder(
        future: apiService.getDonations(phoneNumber, ""),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            final jsonData = snapshot.data as Map<String, dynamic>;

            // Extract the donations list from the JSON data
            final donationData = jsonData['donations'] as List;
            // Extract the totalDonations count from the JSON data
            final totalDonations = jsonData['totalDonations'] as int;
            _boxLogin.put("totalDonations", totalDonations);
            return DataTable(
              sortColumnIndex: 0,
              sortAscending: true,
              columnSpacing: 15,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
              ),
              // creative heading row decoration

              headingRowColor: MaterialStateColor.resolveWith(
                  (states) => const Color(0xFFFDC3C9)),
              headingRowHeight: 50,
              headingTextStyle: const TextStyle(
                  fontSize: 14, fontFamily: "Rubik", color: Colors.black),
              columns: const <DataColumn>[
                DataColumn(label: Text('Donation\nDate')),
                DataColumn(label: Text('Blood\nType')),
                DataColumn(label: Text('Blood\nBank')),
                DataColumn(label: Text('Blood\nPressure'), numeric: true),
                DataColumn(label: Text('Quantity'), numeric: true),
              ],
              rows: donationData
                  .map(
                    (data) => DataRow(
                      cells: [
                        DataCell(Text(DateFormat('MMM d, yyyy')
                            .format(DateTime.parse(data['donationDate'])))),
                        DataCell(Text(data['bloodType'])),
                        DataCell(Text(data['organizationId'])),
                        DataCell(Text("${data['upperBP']}/${data['lowerBP']}")),
                        DataCell(Text(data['quantity'].toString())),
                      ],
                    ),
                  )
                  .toList(),
            );
          } else {
            return const Text('No data available');
          }
        },
      )),
    );
  }
}
