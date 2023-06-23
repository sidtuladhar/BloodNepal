import 'package:http/http.dart';
import 'dart:convert';

class ApiService {
  Future<Map> checkLogin(String phoneNumber, String password) async {
    final url = Uri.parse("http://10.0.2.2:8000/api/login");

    try {
      final response = await post(
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
      final response = await post(url, body: {"phoneNumber": phoneNumber});
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
