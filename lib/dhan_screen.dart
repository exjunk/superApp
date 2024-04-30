import 'package:flutter/material.dart';
import 'package:super_app/api_call_util.dart';
import 'package:super_app/enum.dart';

class DhanPositions extends StatefulWidget {
  @override
  _DhanPositionsState createState() => _DhanPositionsState();
}

class _DhanPositionsState extends State<DhanPositions> {
  var apiUtils = ApiUtils();
  int _selectedOption = 1; // Initially select option 1
  final List<String> _menuItems = ['Option A', 'Option B', 'Option C'];
  final List<String> _positions = ['Position 1', 'Position 2', 'Position 3'];

  void _handlePositionsButtonPress() {
    // Handle button press functionality here (optional)
    apiUtils.makeGetApiCall("https://api.dhan.co/positions");
  }

  void _handleOrdersButtonPress() {
    // Handle button press functionality here (optional)
    apiUtils.makeGetApiCall("https://api.dhan.co//orders");
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
                    return ListTile(
                      title: Text(_positions[index]),
                      // Add functionality for position selection here (optional)
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                    const Text('Bank Nifty'),
                    const SizedBox(width: 20),
                    Radio<int>(
                      value: 2,
                      groupValue: _selectedOption,
                      onChanged: (value) =>
                          setState(() => _selectedOption = value!),
                    ),
                    const Text('Nifty'),
                    const SizedBox(width: 20),
                    Radio<int>(
                      value: 3,
                      groupValue: _selectedOption,
                      onChanged: (value) =>
                          setState(() => _selectedOption = value!),
                    ),
                    const Text('Finnifty'),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          // Handle button 1 press based on _selectedOption
                          // print('Button 1 pressed, selected option: $_selectedOption');

                          var body = <String, String>{
                            'dhanClientId': '1100323569',
                            'correlationId': '987666211',
                            'transactionType': 'BUY',
                            'exchangeSegment': ExchangeSegment.NSE_FNO.name,
                            'productType': ProductType.INTRADAY.name,
                            'orderType': OrderType.MARKET.name,
                            'validity': Validity.DAY.name,
                            'tradingSymbol': '',
                            'securityId': '35001',
                            'quantity': '15',
                            'disclosedQuantity': '',
                            'price': '',
                            'triggerPrice': '',
                            'afterMarketOrder': 'false',
                            'boProfitValue': '',
                            'drvExpiryDate': '2024-05-15 14:30:00',
                            'drvOptionType': 'CALL',
                            'drvStrikePrice': '33500'
                          };
                          apiUtils.makePostApiCall(
                              "https://api.dhan.co//orders",
                              data: body);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.green, // Set green color for Button 1
                        ),
                        child: const Text('Buy',
                            style: TextStyle(color: Colors.white))),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Handle button 2 press based on _selectedOption
                        print(
                            'Button 2 pressed, selected option: $_selectedOption');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.red, // Set green color for Button 1
                      ),
                      child: const Text('Sell',
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

/*  @override
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
                ElevatedButton(
                  onPressed: _handlePositionsButtonPress,
                  child: const Text('Positions'),
                ),
                ListView.builder(
                  itemCount: _menuItems.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_menuItems[index]),
                      // Add functionality for menu item selection here
                    );
                  },
                ),
              ],
            ),
          ),
          // Content on the right side
          const VerticalDivider(thickness: 1),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                    const Text('Bank Nifty'),
                    const SizedBox(width: 20),
                    Radio<int>(
                      value: 2,
                      groupValue: _selectedOption,
                      onChanged: (value) =>
                          setState(() => _selectedOption = value!),
                    ),
                    const Text('Nifty'),
                    const SizedBox(width: 20),
                    Radio<int>(
                      value: 3,
                      groupValue: _selectedOption,
                      onChanged: (value) =>
                          setState(() => _selectedOption = value!),
                    ),
                    const Text('Finnifty'),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          // Handle button 1 press based on _selectedOption
                          // print('Button 1 pressed, selected option: $_selectedOption');

                          var body = <String, String>{
                            'dhanClientId': '1100323569',
                            'correlationId': '987666211',
                            'transactionType': 'BUY',
                            'exchangeSegment': ExchangeSegment.NSE_FNO.name,
                            'productType': ProductType.INTRADAY.name,
                            'orderType': OrderType.MARKET.name,
                            'validity': Validity.DAY.name,
                            'tradingSymbol': '',
                            'securityId': '35001',
                            'quantity': '15',
                            'disclosedQuantity': '',
                            'price': '',
                            'triggerPrice': '',
                            'afterMarketOrder': 'false',
                            'boProfitValue': '',
                            'drvExpiryDate': '2024-05-15 14:30:00',
                            'drvOptionType': 'CALL',
                            'drvStrikePrice': '33500'
                          };
                          ApiUtils().makePostApiCall(
                              "https://api.dhan.co//orders",
                              data: body);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.green, // Set green color for Button 1
                        ),
                        child: const Text('Buy',
                            style: TextStyle(color: Colors.white))),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Handle button 2 press based on _selectedOption
                        print(
                            'Button 2 pressed, selected option: $_selectedOption');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.red, // Set green color for Button 1
                      ),
                      child: const Text('Sell',
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
  }*/
}
