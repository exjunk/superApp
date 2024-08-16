import 'dart:convert';
import 'package:session_storage/session_storage.dart';
import 'package:flutter/material.dart';
import 'package:super_app/api_call_util.dart';
import 'package:super_app/my_const.dart';
import 'package:super_app/response/FundLimitResponse.dart' as fund_limit;
import 'package:super_app/response/GetPositionsResponse.dart' as get_position;
import 'package:super_app/response/OrderPlacementResponse.dart'
    as order_placement;
import 'package:super_app/response/GetOrderFromIdResponse.dart' as get_order;
import 'package:super_app/response/OpenOrderResponse.dart' as open_order;
import 'package:super_app/socket_io_connection.dart' as socket_io;
import 'package:super_app/utils.dart';
import 'package:super_app/utils/Logger.dart';
import 'package:super_app/level_trigger_screen.dart';
import 'package:super_app/enum.dart' as enum_value;
import 'package:super_app/app_config.dart';

class DhanPositions extends StatefulWidget {
  @override
  _DhanPositionsState createState() => _DhanPositionsState();
}

class _DhanPositionsState extends State<DhanPositions> {
  final socket_io.SocketService socketService = socket_io.SocketService();
  var apiUtils = ApiUtils();
  int _selectedOption = 1; // Initially select option 1
  final List<get_position.Data> _positions = [];
  final List<open_order.Data> _openOrders = [];
  int _editingIndex = -1;
  double startLimit = 0;
  double availableLimit = 0;
  final sessionStroage = SessionStorage();
  final Set<String> _trackSecurityID = {};
  bool _initialDataLoaded = false;

  Map<String, double> _pnlData = {
    'total_pnl': 0.0,
    'realized_pnl': 0.0,
    'unrealized_pnl': 0.0,
  };

  @override
  void initState() {
    super.initState();
    socketService.connect();
    _initializeSocketListeners();
    _loadInitialData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialDataLoaded) {
      _loadInitialData();
    }
  }

  Future<void> _loadInitialData() async {
    await _getFundLimits();
    await _handleOpenOrderButtonPress();
    await _handlePositionsButtonPress();
    setState(() {
      _initialDataLoaded = true;
    });
  }

  void _initializeSocketListeners() {
    socketService.socket.on('order_status', _handleOrderStatus);
    socketService.socket.on('market_feed', _handleMarketFeed);
    socketService.socket.on('pnl', _handlePnlFeed);
  }

  void _handleOrderStatus(data) {
    final Map parsed = jsonDecode(data);
    final getOrderFromIdResponse =
        get_order.GetOrderFromIdResponse.fromJson(parsed);
    Logger.printLogs("socket_on--${getOrderFromIdResponse.status}");
    if (getOrderFromIdResponse.data != null &&
        getOrderFromIdResponse.data!.securityId != null) {
      _trackSecurityID.add(getOrderFromIdResponse.data!.securityId!);
      Logger.printLogs(getOrderFromIdResponse.data!.tradingSymbol);
      _handlePositionsButtonPress();
    }
  }

  void _handlePnlFeed(dynamic data) {
    //Logger.printLogs(data);
    setState(() {
      _pnlData = {
        'total_pnl': data['total_pnl'].toDouble(),
        'realized_pnl': data['realized_pnl'].toDouble(),
        'unrealized_pnl': data['unrealized_pnl'].toDouble(),
      };
    });
  }

  void _handleMarketFeed(dynamic data) {
    if (data is Map<String, dynamic> && data['type'] == 'Ticker Data') {
      String securityId = data['security_id'].toString();
      num ltp = double.parse(data['LTP']);

      bool updated = false;

      // Update open orders
      for (var order in _openOrders) {
        if (order.securityId == securityId) {
          order.ltp = ltp;
          updated = true;
        }
      }

      // Update positions
      for (var position in _positions) {
        if (position.securityId == securityId) {
          position.ltp = ltp.toDouble();
          updated = true;
        }
      }

      // Only rebuild if an order or position was actually updated
      if (updated) {
        setState(() {});
      }
    }
  }

  Future<void> _getFundLimits() async {
    final response = await apiUtils.makeGetApiCall("${apiBaseUrl}fundLimits");
    if (response != null) {
      final Map parsed = jsonDecode(response.body);
      final fundLimitResponse = fund_limit.FundLimitResponse.fromJson(parsed);
      setState(() {
        if (fundLimitResponse.data != null) {
          startLimit = fundLimitResponse.data!.sodLimit!.toDouble();
          availableLimit = fundLimitResponse.data!.availabelBalance!.toDouble();
        }
      });
    }
  }

  Future<void> _handlePositionsButtonPress() async {
    final response = await apiUtils.makeGetApiCall("${apiBaseUrl}openPosition");
    if (response != null) {
      final Map parsed = jsonDecode(response.body);
      final getPositionResponse = get_position.GetPositionsResponse.fromJson(parsed);
      if (getPositionResponse.data != null) {
        var filterOpenPosition = getPositionResponse.data!
            .where((element) => element.positionType != "CLOSED")
            .toList();
        setState(() {
          _positions.clear();
          _positions.addAll(filterOpenPosition);

          // Add security IDs to _trackSecurityID set
          for (var position in _positions) {
            if (position.securityId != null) {
              _trackSecurityID.add(position.securityId!);
            }
          }
        });
      }
    }
  }

  Future<void> _handleOpenOrderButtonPress() async {
    final response = await apiUtils.makeGetApiCall("${apiBaseUrl}openOrders");

    if (response != null) {
      final Map parsed = jsonDecode(response.body);
      final getOpenOrderResponse =
          open_order.OpenOrderResponse.fromJson(parsed);
      if (getOpenOrderResponse.data != null) {
        var filterOpenPosition = getOpenOrderResponse.data;
        setState(() {
          _openOrders.clear();
          if (filterOpenPosition != null && filterOpenPosition.isNotEmpty) {
            _openOrders.addAll(filterOpenPosition);
          }
        });
      }
    }
  }

  void _onClosePositionClick(get_position.Data getPositionsData) {
    var exchange = getPositionsData.exchangeSegment;
    var securityId = getPositionsData.securityId;
    var transactionType =
        getPositionsData.positionType == "LONG" ? "SELL" : "BUY";
    var quantity = getPositionsData.netQty;
    var productType = getPositionsData.productType;

    apiUtils.makeGetApiCall(
        "${apiBaseUrl}closePosition?security_id=$securityId&exchange_segment=$exchange&transaction_type=$transactionType&quantity=$quantity&product_type=$productType");
  }

  Future<void> _onOpenOrderCancel(open_order.Data openOrder) async{
    var orderId = openOrder.orderId;
    apiUtils.makeGetApiCall(
        "${apiBaseUrl}cancelOpenOrders?order_id=$orderId");
    _handleOpenOrderButtonPress();
  }

  Future<void> _onOpenOrderModification(open_order.Data openOrder) async{
    var orderId = openOrder.orderId;
    var quantity = openOrder.quantity;
    var price = openOrder.price;
    var leg = openOrder.legName;
    var validity = openOrder.validity;
    var orderType = openOrder.orderType;
    var disclosed = openOrder.disclosedQuantity;
    var trigger = openOrder.triggerPrice;

    apiUtils.makeGetApiCall(
        "${apiBaseUrl}modifyOpenOrders?order_id=$orderId&quantity=$quantity&price=$price&leg=$leg&validity=$validity&order_type=$orderType&disclosed=$disclosed&trigger=$trigger");
    _handleOpenOrderButtonPress();
  }


  Future<void> _onOrderPlacement(String selectedIndex, String clientOrderId,
      String? socketClientId, String optionType) async {
    String productType = enum_value.ProductType.INTRADAY.name;
    final response = await apiUtils.makeGetApiCall(
        "${apiBaseUrl}placeOrder?index=$selectedIndex&option_type=$optionType&transaction_type=BUY&socket_client_id=$socketClientId&client_order_id=$clientOrderId&dhan_client_id=$dhanClientId&product_type=$productType");

    if (response != null) {
      try {
        final Map parsed = jsonDecode(response.body);
        final orderPlacementResponse =
            order_placement.OrderPlacementResponse.fromJson(parsed);
        setState(() {
          if (orderPlacementResponse.data != null) {
            var security_id = orderPlacementResponse.securityID;
          }
        });
      } on Exception catch (e) {
        Logger.printLogs(e);
      }
    }
  }

  void _handleOrdersButtonPress() {
    //_navigateToTriggerLevelScreen();
  }

  void _navigateToTriggerLevelScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              (LevelMarkerScreen())), // Replace with your new screen widget
    );
  }

  void sendSocketIoMessage() {
    socketService.sendMessage("PIng1");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Super App Trader'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AppConfigScreen()),
              );
            },
          ),
        ],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _handlePositionsButtonPress();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.greenAccent,
                        ),
                        child: const Text('Open Positions',
                            style: TextStyle(color: Colors.black)),
                      ),
                      _buildPositionsList(),
                    ],
                  ),
                ),
                const Divider(thickness: 1, color: Colors.black),
                Expanded(
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _handleOpenOrderButtonPress();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.greenAccent,
                        ),
                        child: const Text('Open Orders',
                            style: TextStyle(color: Colors.black)),
                      ),
                      _buildOpenOrderList(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const VerticalDivider(thickness: 1),
          Expanded(
            child: _buildRightSide(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _navigateToTriggerLevelScreen();
        },
        child: const Icon(Icons.add),
      ),
    );
  }


  Widget _buildPositionsList() {
    return Expanded(
      child: ListView.builder(
        itemCount: _positions.length,
        itemBuilder: (context, index) {
          final position = _positions[index];
          return Container(
            height: 72,
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            position.tradingSymbol!,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'LTP: ${position.ltp?.toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Cost: ${position.costPrice?.toStringAsFixed(2) ?? "N/A"}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Qty: ${position.buyQty}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => _onClosePositionClick(position),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      ),
                      child: const Text('Close', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }



  Widget _buildOpenOrderList() {
    return Expanded(
      child: ListView.builder(
        itemCount: _openOrders.length,
        itemBuilder: (context, index) {
          bool isEditing = index == _editingIndex;
          return SizedBox(
            height: 72,
            child: Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _openOrders[index].tradingSymbol!,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'LTP: ${_openOrders[index].ltp?.toStringAsFixed(2) ?? "0.0"}',
                            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: _buildEditableField(
                        isEditing: isEditing,
                        value: _openOrders[index].price.toString(),
                        label: 'Price', // Add this label
                        onChanged: (value) {
                          setState(() {
                            _openOrders[index].price = double.tryParse(value) ?? _openOrders[index].price;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: _buildEditableField(
                        isEditing: isEditing,
                        value: _openOrders[index].quantity.toString(),
                        label: 'Quantity', // Add this label
                        onChanged: (value) {
                          setState(() {
                            _openOrders[index].quantity = int.tryParse(value) ?? _openOrders[index].quantity;
                          });
                        },
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        isEditing ? Icons.save : Icons.edit,
                        color: Colors.blue,
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          if (isEditing) {
                            // Save logic here
                            _onOpenOrderModification(_openOrders[index]);
                            _editingIndex = -1; // Exit edit mode
                          } else {
                            _editingIndex = index; // Enter edit mode
                          }
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.cancel, color: Colors.red, size: 20),
                      onPressed: () {
                        // Handle cancel order
                        _onOpenOrderCancel(_openOrders[index]);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEditableField({
    required bool isEditing,
    required String value,
    required Function(String) onChanged,
    required String label, // Add this parameter for the heading
  }) {
    return isEditing
        ? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.blue,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4), // Add some space between label and textfield
        SizedBox(
          height: 36, // Reduced height to accommodate the label
          child: TextFormField(
            initialValue: value,
            keyboardType: TextInputType.number,
            onChanged: onChanged,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            ),
          ),
        ),
      ],
    )
        : Text(
      value,
      style: const TextStyle(fontSize: 14),
    );
  }

  Widget _buildRightSide() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            fundLimit(startLimit, availableLimit),
            const SizedBox(height: 20),
            const Text(
              'Select Index to trade :',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            _buildRadioButtons(),
            const SizedBox(height: 20),
            _buildTradeButtons(),
          ],
        ),
      ),
    );
  }

  Widget fundLimit(double startLimit, double availableBalance) {
    var pnl = _pnlData['total_pnl'] ?? 0.0;
    var color = pnl < 0 ? Colors.red : Colors.green;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Account Summary',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfoItem('Start of Day Limit', startLimit.toStringAsFixed(2)),
              _buildInfoItem('Available Balance', availableBalance.toStringAsFixed(2)),
              _buildInfoItem('P&L', pnl.toStringAsFixed(2), color: color),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfoItem('Realized P&L', _pnlData['realized_pnl']?.toStringAsFixed(2) ?? '0.00'),
              _buildInfoItem('Unrealized P&L', _pnlData['unrealized_pnl']?.toStringAsFixed(2) ?? '0.00'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, {Color? color}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color ?? Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildRadioButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Radio<int>(
          value: 1,
          groupValue: _selectedOption,
          onChanged: (value) => setState(() => _selectedOption = value!),
        ),
        const Text('BANKNIFTY'),
        const SizedBox(width: 20),
        Radio<int>(
          value: 2,
          groupValue: _selectedOption,
          onChanged: (value) => setState(() => _selectedOption = value!),
        ),
        const Text('NIFTY'),
        const SizedBox(width: 20),
        Radio<int>(
          value: 3,
          groupValue: _selectedOption,
          onChanged: (value) => setState(() => _selectedOption = value!),
        ),
        const Text('FINNIFTY'),
        const SizedBox(width: 20),
        Radio<int>(
          value: 4,
          groupValue: _selectedOption,
          onChanged: (value) => setState(() => _selectedOption = value!),
        ),
        const Text('SENSEX'),
      ],
    );
  }

  Widget _buildTradeButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            var selectedIndex = fetchSelectedIndex(_selectedOption);
            var clientOrderId = Utils().generateCode(10);
            var socketClientId = sessionStroage['socket_client_id'];
            _onOrderPlacement(
                selectedIndex, clientOrderId, socketClientId, "CE");
            // subscribeOrderStatus(socketService,clientOrderId);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
          ),
          child: const Text('CE', style: TextStyle(color: Colors.white)),
        ),
        const SizedBox(width: 20),
        ElevatedButton(
          onPressed: () {
            var selectedIndex = fetchSelectedIndex(_selectedOption);
            var clientOrderId = Utils().generateCode(10);
            var socketClientId = sessionStroage['socket_client_id'];
            _onOrderPlacement(
                selectedIndex, clientOrderId, socketClientId, "PE");
            // subscribeOrderStatus(socketService,clientOrderId);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: const Text('PE', style: TextStyle(color: Colors.white)),
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
}
