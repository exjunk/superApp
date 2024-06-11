/*
import 'package:dio/dio.dart';

class ApiClient {
  final Dio dio;
  static const baseUrl = "";
  ApiClient(this.dio);

  Future<dynamic> placeOrder() async {
    const url = 'https://api.example.com/data1';

    try {
      final response = await dio.get(url);
      return response.data; // Return the data from response
    } on DioException catch (error) {
      throw Exception('Error fetching data1: ${error.message}'); // Re-throw as a generic Exception
    }
  }

  Future<dynamic> getOrderById(String orderId) async {


    try {
      final response = await dio.get(url);
      return response.data;
    } on DioException catch (error) {
      throw Exception('Error fetching data2: ${error.message}');
    }
  }

// You can add more methods for additional API calls here
}
*/
