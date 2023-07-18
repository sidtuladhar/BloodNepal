import 'package:http/http.dart';
import 'dart:convert';

class ApiService {
  Future<Map> checkLogin(String phoneNumber, String password) async {
    final url = Uri.parse("http://10.0.2.2:8000/api/login");

    try {
      final response = await put(
        url,
        body: {
          "phoneNumber": phoneNumber,
          "password": password,
        },
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return responseData;
      } else {
        print('Request failed with status: ${response.statusCode}');
        return {'success': false};
      }
    } catch (error) {
      print('The error is $error');
      return {'success': false};
    }
  }

  Future<bool> logout(String phoneNumber) async {
    final url = Uri.parse("http://10.0.2.2:8000/api/logout");

    try {
      final response = await put(url, body: {"phoneNumber": phoneNumber});
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return responseData['success'];
      } else {
        print('Request failed with status: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      print('The error is $error');
      return false;
    }
  }

  Future<bool> editProfile(
      String fname,
      String mname,
      String lname,
      String email,
      String address,
      String phoneNumber,
      String birthDate,
      String bloodGroup) async {
    final url = Uri.parse("http://10.0.2.2:8000/api/editProfile");

    try {
      final response = await put(url, body: {
        "phoneNumber": phoneNumber,
        "fname": fname,
        "mname": mname,
        "address": address,
        "lname": lname,
        "birthDate": birthDate,
        "email": email,
        "bloodGroup": bloodGroup,
      });
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print("The edit profile response is $responseData");
        return responseData['success'];
      } else {
        print('Request failed with status: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      print('The error is $error');
      return false;
    }
  }

  Future<List> getLeaderboard() async {
    final url = Uri.parse("http://10.0.2.2:8000/api/leaderboard");

    try {
      final response = await get(url);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print(responseData);
        return responseData;
      } else {
        print('Request failed with status: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      print('The error is $error');
      return [];
    }
  }

  Future<List> getRequests(String phoneNumber) async {
    final url = Uri.parse(
        "http://10.0.2.2:8000/api/getRequests?phoneNumber=$phoneNumber");
    try {
      var response = await get(url);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return responseData;
      } else {
        print('Request failed with status: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      print('The error is $error');
      return [];
    }
  }

  getDonations(String phoneNumber, String field) async {
    final url = Uri.parse(
        "http://10.0.2.2:8000/api/getDonations?phoneNumber=$phoneNumber");
    try {
      var response = await get(url);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final donationData = responseData['donations'];
        final totalDonationsData = responseData['totalDonations'];

        if (field == 'donations') {
          return donationData;
        } else if (field == 'totalDonations') {
          return totalDonationsData;
        } else {
          return responseData;
        }
      } else {
        print('Request failed with status: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      print('The error is $error');
      return [];
    }
  }

  Future<bool> sendRequest(String phoneNumber, String bloodGroup, int quantity,
      String bloodType, String address, DateTime needByDate) async {
    final url = Uri.parse("http://10.0.2.2:8000/api/sendRequest");
    try {
      var response = await post(url, body: {
        "phoneNumber": phoneNumber,
        "bloodGroup": bloodGroup,
        "quantity": quantity.toString(),
        "bloodType": bloodType,
        "address": address,
        "needByDate": needByDate.toString(),
      });
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return responseData['success'];
      } else {
        print('Request failed with status: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      print('The error is $error');
      return false;
    }
  }
}
