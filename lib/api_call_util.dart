import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiUtils {
  var headers = {
   // 'Access-Control-Allow-Origin': '*',
   // 'Access-Control-Allow-Methods': 'POST',
   // 'Access-Control-Allow-Headers': 'X-Requested-With',
    'Content-Type': 'application/json',
    'Accept':'application/json',
    'access-token': 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJkaGFuIiwicGFydG5lcklkIjoiIiwiZXhwIjoxNzE2NzU3NTI5LCJ0b2tlbkNvbnN1bWVyVHlwZSI6IlNFTEYiLCJ3ZWJob29rVXJsIjoiIiwiZGhhbkNsaWVudElkIjoiMTEwMDMyMzU2OSJ9.vFZDPb5I7BOHnKfg88lw8DvRUuXxO0Lc2JAbs7cuyXX5BKA-9fgBns8Zo2iwdO2jfi0f8-4ocNdlfX9O-Kq7-Q'
  };
  Future<void> makePostApiCall(String url, {Map<String, String>? data}) async {
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      // Handle successful response (e.g., print data)
      print('API call successful! Response: ${response.body}');
    } else {
      // Handle error
      print('API call error: Status code - ${response.statusCode}');
    }
  }

  Future<void> makeGetApiCall(String url, {Map<String, String>? data}) async {
    String queryString = Uri(queryParameters: data).query;

    final response = await http.get(
        Uri.parse(url+queryString),
      headers: headers
    );

    if (response.statusCode == 200) {
      // Handle successful response (e.g., print data)
      print('API call successful! Response: ${response.body}');
    } else {
      // Handle error
      print('API call error: Status code - ${response.statusCode}');
    }
  }
}