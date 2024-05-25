import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:super_app/enum.dart';
import 'package:super_app/response/GetOrderFromIdResponse.dart';
import 'package:super_app/response/OrderPlacementResponse.dart';
import 'package:super_app/utils/Logger.dart' as logger;

import 'my_const.dart';

class ApiUtils {
  bool orderStatusChanged = false;
  String? currentOrderStatus = "";
  var headers = {
    'Content-Type': 'application/json',
    //  'Accept': 'application/json',
    'access-token':
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpc3MiOiJkaGFuIiwicGFydG5lcklkIjoiIiwiZXhwIjoxNzE5MTE1MjQ1LCJ0b2tlbkNvbnN1bWVyVHlwZSI6IlNFTEYiLCJ3ZWJob29rVXJsIjoiIiwiZGhhbkNsaWVudElkIjoiMTEwMDMyMzU2OSJ9.YzOdkJF6JpE04wCAWJMNRIAXFEfm6MVmRJffQgcGhshVvfI8WGUDS4bLl9YvA0Wy2CU3hXDJ9H4WySbEPXDAoQ'
  };

  Future<void> makePostApiCall(String url, {Map<String, String>? data}) async {
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      // Handle successful response (e.g., print data)
      logger.Logger.printLogs('API call successful! Response: ${response.body}');
    } else {
      // Handle error
      logger.Logger.printLogs('API call error: Status code - ${response.statusCode}');
    }
  }

  Future<http.Response?> makeGetApiCall(String url, {Map<String, String>? data}) async {
    String queryString = Uri(queryParameters: data).query;

    final response = await http.get(Uri.parse(url + queryString));

    if (response.statusCode == 200) {
      if (response.headers.containsKey('x-request-type')) {
        handleWithHeaderStatus(response);
      }
      // Handle successful response (e.g., print data)
      logger.Logger.printLogs('API call successful! Response: ${response.body} ${response.headers} -- ${response.request?.headers}');
      return response;
    } else {
      // Handle error
      logger.Logger.printLogs('API call error: Status code - ${response.statusCode}');
    }
    return null;
  }

  handleWithHeaderStatus(http.Response response) {
    if (response.headers['x-request-type'] == 'placeOrder' || response.headers['x-request-type'] == 'closePosition') {
      final Map parsed  = jsonDecode(response.body) ;
      final  orderPlacementResponse = OrderPlacementResponse.fromJson(parsed);
      afterOrderPlacementFlow(orderPlacementResponse);
    } else if (response.headers['x-request-type'] == 'orderstatus') {
      final Map parsed  = jsonDecode(response.body) ;
      final  orderStatusResponse = GetOrderFromIdResponse.fromJson(parsed);

      if (orderStatusResponse.data != null &&
          (orderStatusResponse.data?.orderStatus ==
                  OrderStatus.CANCELLED.name ||
              orderStatusResponse.data?.orderStatus ==
                  OrderStatus.EXPIRED.name ||
              orderStatusResponse.data?.orderStatus ==
                  OrderStatus.REJECTED.name ||
              orderStatusResponse.data?.orderStatus ==
                  OrderStatus.TRADED.name)) {
        orderStatusChanged = true;
        if (orderStatusResponse.data?.orderStatus == OrderStatus.TRADED.name) {
          makeGetApiCall("${apiBaseUrl}openPosition");
        }
      }
    }
  }

  afterOrderPlacementFlow(OrderPlacementResponse response) {
    var apiCount = 0;
    if ("success" == response.status?.toLowerCase()) {
      Timer.periodic(const Duration(seconds: 1), (timer) async {

        if (!orderStatusChanged && apiCount <5) {
          apiCount++;
          if (response.data != null && response.data?.orderId != null) {
            await makeGetApiCall(
                "${apiBaseUrl}orderstatus?&order_id=${response.data?.orderId}");
          }
        } else {
          orderStatusChanged = false;
          timer.cancel();
        }
      });
    }
  }
}
