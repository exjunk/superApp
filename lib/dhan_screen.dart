import 'package:flutter/material.dart';
import 'package:super_app/api_call_util.dart';
import 'package:super_app/my_const.dart';

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
    apiUtils.makeGetApiCall(
        "${apiBaseUrl}placeOrder?index=NIFTY&option_type=CE&transaction_type=BUY");
  }

  void _handleOrdersButtonPress() {
    // Handle button press functionality here (optional)
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
