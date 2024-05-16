import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:super_app/api_call_util.dart';
import 'package:super_app/my_const.dart';
import 'package:super_app/response/FundLimitResponse.dart' as fund_limit;
import 'package:super_app/response/GetPositionsResponse.dart' as get_position;

class DhanPositions extends StatefulWidget {
  @override
  _DhanPositionsState createState() => _DhanPositionsState();
}

class _DhanPositionsState extends State<DhanPositions> {
  var apiUtils = ApiUtils();
  int _selectedOption = 1; // Initially select option 1
  final List<get_position.Data> _positions = [];
  double startLimit = 0;
  double availableLimit = 0;

  @override
  void initState() {
    super.initState();
    _getFundLimits();
  }

  void addItemToList(List<get_position.Data> data) {
    setState(() {
      _positions.clear();
      _positions.addAll(data);
    });
  }

  void _getFundLimits() async{
    final response = await apiUtils.makeGetApiCall("${apiBaseUrl}fundLimits");
    if (response != null) {
      final Map parsed = jsonDecode(response.body);
      final fundLimitResponse = fund_limit.FundLimitResponse.fromJson(parsed);
      setState(() {
        if(fundLimitResponse.data != null) {
          startLimit = fundLimitResponse.data!.sodLimit!.toDouble();
          availableLimit = fundLimitResponse.data!.availabelBalance!.toDouble();
        }
      });
    }
  }

  void _handlePositionsButtonPress() async {
    final response = await apiUtils.makeGetApiCall("${apiBaseUrl}openPosition");

    if (response != null) {
      final Map parsed = jsonDecode(response.body);
      final getPositionResponse = get_position.GetPositionsResponse.fromJson(parsed);
      if (getPositionResponse.data != null) {
        var filterOpenPosition = getPositionResponse.data!.where((element) => element.positionType != "CLOSED").toList();
        addItemToList(filterOpenPosition);
      }
    }
  }

  void _onClosePositionClick(get_position.Data getPositionsData) {
    var exchange = getPositionsData.exchangeSegment;
    var securityId = getPositionsData.securityId;
    var transactionType = "";
    num? quantity = -1;
    if (getPositionsData.positionType == "LONG") {
      // to close position we need to take reverse position
      transactionType = "SELL";
      quantity = getPositionsData.buyQty;
    } else if (getPositionsData.positionType == "SHORT") {
      transactionType = "BUY";
      quantity = getPositionsData.sellQty;
    }
    var productType = getPositionsData.productType;

    apiUtils.makeGetApiCall(
        "${apiBaseUrl}closePosition?security_id=$securityId&exchange_segment=$exchange&transaction_type=$transactionType&quantity=$quantity&product_type=$productType");
  }

  void _handleOrdersButtonPress() {
    apiUtils.makeGetApiCall("${apiBaseUrl}orders");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Positions'),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Menu on the left side
          Expanded(
            child: Column(
              children: [
                Row(children: [
                  ElevatedButton(
                    onPressed: _handlePositionsButtonPress,
                    child: const Text('Positions'),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: _handleOrdersButtonPress,
                    child: const Text('Orders'),
                  )
                ]),
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: _positions.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _positions[index].tradingSymbol!,
                            // style: Theme.of(context).textTheme.headline6,
                          ),
                          const Divider(height: 10.0, thickness: 10.0),
                          Text(
                            _positions[index].costPrice.toString(),
                            //  style: Theme.of(context).textTheme.subtitle1,
                          ),
                          const Divider(height: 10.0, thickness: 10.0),
                          Text(
                            _positions[index].buyQty.toString(),
                            //  style: Theme.of(context).textTheme.bodyText2,
                          ),
                          const Divider(height: 10.0, thickness: 10.0),
                          ElevatedButton(
                            onPressed: () {
                              // Handle button press
                              _onClosePositionClick(_positions[index]);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.teal, // Set green color for Button 1
                            ),
                            child: const Text('Close Position',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          // Vertical Divider
          const VerticalDivider(thickness: 1),
          // Content on the right side
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                fundLimit(startLimit, availableLimit),
                const Text('Select Index to trade :'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio<int>(
                      value: 1,
                      groupValue: _selectedOption,
                      onChanged: (value) =>
                          setState(() => _selectedOption = value!),
                    ),
                    const Text('BANKNIFTY'),
                    const SizedBox(width: 20),
                    Radio<int>(
                      value: 2,
                      groupValue: _selectedOption,
                      onChanged: (value) =>
                          setState(() => _selectedOption = value!),
                    ),
                    const Text('NIFTY'),
                    const SizedBox(width: 20),
                    Radio<int>(
                      value: 3,
                      groupValue: _selectedOption,
                      onChanged: (value) =>
                          setState(() => _selectedOption = value!),
                    ),
                    const Text('FINNIFTY'),
                    const SizedBox(width: 20),
                    Radio<int>(
                      value: 4,
                      groupValue: _selectedOption,
                      onChanged: (value) =>
                          setState(() => _selectedOption = value!),
                    ),
                    const Text('SENSEX'),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          var selectedIndex =
                              fetchSelectedIndex(_selectedOption);
                          apiUtils.makeGetApiCall(
                              "${apiBaseUrl}placeOrder?index=$selectedIndex&option_type=CE&transaction_type=BUY");
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.green, // Set green color for Button 1
                        ),
                        child: const Text('CE',
                            style: TextStyle(color: Colors.white))),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        var selectedIndex = fetchSelectedIndex(_selectedOption);
                        apiUtils.makeGetApiCall(
                            "${apiBaseUrl}placeOrder?index=$selectedIndex&option_type=PE&transaction_type=BUY");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.red, // Set green color for Button 1
                      ),
                      child: const Text('PE',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Row listHeader() {
  return const Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    // crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Name',
        // style: Theme.of(context).textTheme.headline6,
      ),
      Divider(height: 10.0, thickness: 10.0),
      Text(
        'Buy Price',
        //  style: Theme.of(context).textTheme.subtitle1,
      ),
      Divider(height: 10.0, thickness: 10.0),
      Text(
        'LTP',
        //  style: Theme.of(context).textTheme.bodyText2,
      ),
      Divider(height: 10.0, thickness: 10.0),
      Text(
        'P&L',
        //  style: Theme.of(context).textTheme.bodyText2,
      ),
    ],
  );
}

Row fundLimit(double startLimit, double availableBalance) {
  var pnl = availableBalance - startLimit;
  var color = Colors.red;
  if (pnl < 0) {
    color = Colors.red;
  } else {
    color = Colors.teal;
  }

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
   // crossAxisAlignment: CrossAxisAlignment.start,
   // mainAxisSize: MainAxisSize.min,
    // crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Start Of Day Limit: $startLimit",
        // style: Theme.of(context).textTheme.headline6,
      ),
      const Divider(height: 10.0, thickness: 10.0),
      Text(
        'Available Balance: $availableBalance',
        //  style: Theme.of(context).textTheme.subtitle1,
      ),
      const Divider(height: 10.0, thickness: 10.0),
      Text(
        'P&L: $pnl',
        style: TextStyle(color: color),
      ),
    ],
  );
}

String fetchSelectedIndex(int options) {
  var selected = "";
  switch (options) {
    case 1:
      selected = bankNifty;
    case 2:
      selected = nifty;
    case 3:
      selected = finNifty;
    case 4:
      selected = sensex;
  }

  return selected;
}
