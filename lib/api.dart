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
      }
    } catch (error) {
      print('Big Error: $error');
    }
    return {'success': false};
  }
}
