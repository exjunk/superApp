/// data : [{"dhanClientId":"1100323569","orderId":"22240807823701","exchangeOrderId":"1600000144664724","correlationId":"NA","orderStatus":"CANCELLED","transactionType":"BUY","exchangeSegment":"NSE_FNO","productType":"INTRADAY","orderType":"LIMIT","validity":"DAY","tradingSymbol":"BANKNIFTY-Aug2024-51300-CE","securityId":"50195","quantity":180,"disclosedQuantity":0,"price":2.5,"triggerPrice":0.0,"afterMarketOrder":false,"boProfitValue":0.0,"boStopLossValue":0.0,"legName":"NA","createTime":"2024-08-07 10:58:35","updateTime":"2024-08-07 10:58:35","exchangeTime":"2024-08-07 10:58:35","drvExpiryDate":"2024-08-07","drvOptionType":"CALL","drvStrikePrice":51300.0,"omsErrorCode":"0","omsErrorDescription":"CONFIRMED","filled_qty":0,"algoId":"0"}]

class OpenOrderResponse {
  OpenOrderResponse({
    List<Data>? data,
  }) {
    _data = data;
  }

  OpenOrderResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }

  List<Data>? _data;

  OpenOrderResponse copyWith({
    List<Data>? data,
  }) =>
      OpenOrderResponse(
        data: data ?? _data,
      );

  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// dhanClientId : "1100323569"
/// orderId : "22240807823701"
/// exchangeOrderId : "1600000144664724"
/// correlationId : "NA"
/// orderStatus : "CANCELLED"
/// transactionType : "BUY"
/// exchangeSegment : "NSE_FNO"
/// productType : "INTRADAY"
/// orderType : "LIMIT"
/// validity : "DAY"
/// tradingSymbol : "BANKNIFTY-Aug2024-51300-CE"
/// securityId : "50195"
/// quantity : 180
/// disclosedQuantity : 0
/// price : 2.5
/// triggerPrice : 0.0
/// afterMarketOrder : false
/// boProfitValue : 0.0
/// boStopLossValue : 0.0
/// legName : "NA"
/// createTime : "2024-08-07 10:58:35"
/// updateTime : "2024-08-07 10:58:35"
/// exchangeTime : "2024-08-07 10:58:35"
/// drvExpiryDate : "2024-08-07"
/// drvOptionType : "CALL"
/// drvStrikePrice : 51300.0
/// omsErrorCode : "0"
/// omsErrorDescription : "CONFIRMED"
/// filled_qty : 0
/// algoId : "0"

class Data {
  Data({
    String? dhanClientId,
    String? orderId,
    String? exchangeOrderId,
    String? correlationId,
    String? orderStatus,
    String? transactionType,
    String? exchangeSegment,
    String? productType,
    String? orderType,
    String? validity,
    String? tradingSymbol,
    String? securityId,
    num? quantity,
    num? disclosedQuantity,
    num? price,
    num? triggerPrice,
    bool? afterMarketOrder,
    num? boProfitValue,
    num? boStopLossValue,
    String? legName,
    String? createTime,
    String? updateTime,
    String? exchangeTime,
    String? drvExpiryDate,
    String? drvOptionType,
    num? drvStrikePrice,
    String? omsErrorCode,
    String? omsErrorDescription,
    num? filledQty,
    String? algoId,
    num? ltp
  }) {
    _dhanClientId = dhanClientId;
    _orderId = orderId;
    _exchangeOrderId = exchangeOrderId;
    _correlationId = correlationId;
    _orderStatus = orderStatus;
    _transactionType = transactionType;
    _exchangeSegment = exchangeSegment;
    _productType = productType;
    _orderType = orderType;
    _validity = validity;
    _tradingSymbol = tradingSymbol;
    _securityId = securityId;
    _quantity = quantity;
    _disclosedQuantity = disclosedQuantity;
    _price = price;
    _triggerPrice = triggerPrice;
    _afterMarketOrder = afterMarketOrder;
    _boProfitValue = boProfitValue;
    _boStopLossValue = boStopLossValue;
    _legName = legName;
    _createTime = createTime;
    _updateTime = updateTime;
    _exchangeTime = exchangeTime;
    _drvExpiryDate = drvExpiryDate;
    _drvOptionType = drvOptionType;
    _drvStrikePrice = drvStrikePrice;
    _omsErrorCode = omsErrorCode;
    _omsErrorDescription = omsErrorDescription;
    _filledQty = filledQty;
    _algoId = algoId;
    _ltp = ltp;
  }

  Data.fromJson(dynamic json) {
    _dhanClientId = json['dhanClientId'];
    _orderId = json['orderId'];
    _exchangeOrderId = json['exchangeOrderId'];
    _correlationId = json['correlationId'];
    _orderStatus = json['orderStatus'];
    _transactionType = json['transactionType'];
    _exchangeSegment = json['exchangeSegment'];
    _productType = json['productType'];
    _orderType = json['orderType'];
    _validity = json['validity'];
    _tradingSymbol = json['tradingSymbol'];
    _securityId = json['securityId'];
    _quantity = json['quantity'];
    _disclosedQuantity = json['disclosedQuantity'];
    _price = json['price'];
    _triggerPrice = json['triggerPrice'];
    _afterMarketOrder = json['afterMarketOrder'];
    _boProfitValue = json['boProfitValue'];
    _boStopLossValue = json['boStopLossValue'];
    _legName = json['legName'];
    _createTime = json['createTime'];
    _updateTime = json['updateTime'];
    _exchangeTime = json['exchangeTime'];
    _drvExpiryDate = json['drvExpiryDate'];
    _drvOptionType = json['drvOptionType'];
    _drvStrikePrice = json['drvStrikePrice'];
    _omsErrorCode = json['omsErrorCode'];
    _omsErrorDescription = json['omsErrorDescription'];
    _filledQty = json['filled_qty'];
    _algoId = json['algoId'];
  }

  String? _dhanClientId;
  String? _orderId;
  String? _exchangeOrderId;
  String? _correlationId;
  String? _orderStatus;
  String? _transactionType;
  String? _exchangeSegment;
  String? _productType;
  String? _orderType;
  String? _validity;
  String? _tradingSymbol;
  String? _securityId;
  num? _quantity;
  num? _disclosedQuantity;
  num? _price;
  num? _triggerPrice;
  bool? _afterMarketOrder;
  num? _boProfitValue;
  num? _boStopLossValue;
  String? _legName;
  String? _createTime;
  String? _updateTime;
  String? _exchangeTime;
  String? _drvExpiryDate;
  String? _drvOptionType;
  num? _drvStrikePrice;
  String? _omsErrorCode;
  String? _omsErrorDescription;
  num? _filledQty;
  String? _algoId;
  num? _ltp;

  Data copyWith({
    String? dhanClientId,
    String? orderId,
    String? exchangeOrderId,
    String? correlationId,
    String? orderStatus,
    String? transactionType,
    String? exchangeSegment,
    String? productType,
    String? orderType,
    String? validity,
    String? tradingSymbol,
    String? securityId,
    num? quantity,
    num? disclosedQuantity,
    num? price,
    num? triggerPrice,
    bool? afterMarketOrder,
    num? boProfitValue,
    num? boStopLossValue,
    String? legName,
    String? createTime,
    String? updateTime,
    String? exchangeTime,
    String? drvExpiryDate,
    String? drvOptionType,
    num? drvStrikePrice,
    String? omsErrorCode,
    String? omsErrorDescription,
    num? filledQty,
    String? algoId,
    num? ltp
  }) =>
      Data(
        dhanClientId: dhanClientId ?? _dhanClientId,
        orderId: orderId ?? _orderId,
        exchangeOrderId: exchangeOrderId ?? _exchangeOrderId,
        correlationId: correlationId ?? _correlationId,
        orderStatus: orderStatus ?? _orderStatus,
        transactionType: transactionType ?? _transactionType,
        exchangeSegment: exchangeSegment ?? _exchangeSegment,
        productType: productType ?? _productType,
        orderType: orderType ?? _orderType,
        validity: validity ?? _validity,
        tradingSymbol: tradingSymbol ?? _tradingSymbol,
        securityId: securityId ?? _securityId,
        quantity: quantity ?? _quantity,
        disclosedQuantity: disclosedQuantity ?? _disclosedQuantity,
        price: price ?? _price,
        triggerPrice: triggerPrice ?? _triggerPrice,
        afterMarketOrder: afterMarketOrder ?? _afterMarketOrder,
        boProfitValue: boProfitValue ?? _boProfitValue,
        boStopLossValue: boStopLossValue ?? _boStopLossValue,
        legName: legName ?? _legName,
        createTime: createTime ?? _createTime,
        updateTime: updateTime ?? _updateTime,
        exchangeTime: exchangeTime ?? _exchangeTime,
        drvExpiryDate: drvExpiryDate ?? _drvExpiryDate,
        drvOptionType: drvOptionType ?? _drvOptionType,
        drvStrikePrice: drvStrikePrice ?? _drvStrikePrice,
        omsErrorCode: omsErrorCode ?? _omsErrorCode,
        omsErrorDescription: omsErrorDescription ?? _omsErrorDescription,
        filledQty: filledQty ?? _filledQty,
        algoId: algoId ?? _algoId,
        ltp: ltp??_ltp
      );

  String? get dhanClientId => _dhanClientId;

  String? get orderId => _orderId;

  String? get exchangeOrderId => _exchangeOrderId;

  String? get correlationId => _correlationId;

  String? get orderStatus => _orderStatus;

  String? get transactionType => _transactionType;

  String? get exchangeSegment => _exchangeSegment;

  String? get productType => _productType;

  String? get orderType => _orderType;

  String? get validity => _validity;

  String? get tradingSymbol => _tradingSymbol;

  String? get securityId => _securityId;

  num? get quantity => _quantity;

  num? get disclosedQuantity => _disclosedQuantity;

  num? get price => _price;

  num? get triggerPrice => _triggerPrice;

  bool? get afterMarketOrder => _afterMarketOrder;

  num? get boProfitValue => _boProfitValue;

  num? get boStopLossValue => _boStopLossValue;

  String? get legName => _legName;

  String? get createTime => _createTime;

  String? get updateTime => _updateTime;

  String? get exchangeTime => _exchangeTime;

  String? get drvExpiryDate => _drvExpiryDate;

  String? get drvOptionType => _drvOptionType;

  num? get drvStrikePrice => _drvStrikePrice;

  String? get omsErrorCode => _omsErrorCode;

  String? get omsErrorDescription => _omsErrorDescription;

  num? get filledQty => _filledQty;

  String? get algoId => _algoId;
  num? get ltp => _ltp;

  // Add this setter for price
  set price(num? value) {
    _price = value;
  }

  // Add this setter for price
  set quantity(num? value) {
    _quantity = value;
  }

  // Add this setter for price
  set ltp(num? value) {
    _ltp = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dhanClientId'] = _dhanClientId;
    map['orderId'] = _orderId;
    map['exchangeOrderId'] = _exchangeOrderId;
    map['correlationId'] = _correlationId;
    map['orderStatus'] = _orderStatus;
    map['transactionType'] = _transactionType;
    map['exchangeSegment'] = _exchangeSegment;
    map['productType'] = _productType;
    map['orderType'] = _orderType;
    map['validity'] = _validity;
    map['tradingSymbol'] = _tradingSymbol;
    map['securityId'] = _securityId;
    map['quantity'] = _quantity;
    map['disclosedQuantity'] = _disclosedQuantity;
    map['price'] = _price;
    map['triggerPrice'] = _triggerPrice;
    map['afterMarketOrder'] = _afterMarketOrder;
    map['boProfitValue'] = _boProfitValue;
    map['boStopLossValue'] = _boStopLossValue;
    map['legName'] = _legName;
    map['createTime'] = _createTime;
    map['updateTime'] = _updateTime;
    map['exchangeTime'] = _exchangeTime;
    map['drvExpiryDate'] = _drvExpiryDate;
    map['drvOptionType'] = _drvOptionType;
    map['drvStrikePrice'] = _drvStrikePrice;
    map['omsErrorCode'] = _omsErrorCode;
    map['omsErrorDescription'] = _omsErrorDescription;
    map['filled_qty'] = _filledQty;
    map['algoId'] = _algoId;
    map['ltp'] = _ltp;
    return map;
  }
}
