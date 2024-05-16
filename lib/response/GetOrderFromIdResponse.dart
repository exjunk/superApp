/// data : {"afterMarketOrder":false,"algoId":"0","boProfitValue":0,"boStopLossValue":0,"correlationId":"1100323569-1715746157018","createTime":"2024-05-15 09:39:17","dhanClientId":"1100323569","disclosedQuantity":0,"drvExpiryDate":"2024-05-15","drvOptionType":"CALL","drvStrikePrice":47700,"exchangeOrderId":"0","exchangeSegment":"NSE_FNO","exchangeTime":"0001-01-01 00:00:00","filled_qty":0,"legName":"NA","omsErrorCode":"0","omsErrorDescription":"RMS:42240515152001:Fund Limit Insufficient By 2872.08 & Available Amount 92. Order Amount Is 2943.75","orderId":"42240515152001","orderStatus":"REJECTED","orderType":"MARKET","price":0,"productType":"INTRADAY","quantity":15,"securityId":"44160","tradingSymbol":"BANKNIFTY-May2024-47700-CE","transactionType":"BUY","triggerPrice":0,"updateTime":"2024-05-15 09:39:17","validity":"DAY"}
/// remarks : ""
/// status : "success"

class GetOrderFromIdResponse {
  GetOrderFromIdResponse({
      Data? data, 
      String? remarks, 
      String? status,}){
    _data = data;
    _remarks = remarks;
    _status = status;
}

  GetOrderFromIdResponse.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _remarks = json['remarks'];
    _status = json['status'];
  }
  Data? _data;
  String? _remarks;
  String? _status;
GetOrderFromIdResponse copyWith({  Data? data,
  String? remarks,
  String? status,
}) => GetOrderFromIdResponse(  data: data ?? _data,
  remarks: remarks ?? _remarks,
  status: status ?? _status,
);
  Data? get data => _data;
  String? get remarks => _remarks;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['remarks'] = _remarks;
    map['status'] = _status;
    return map;
  }

}

/// afterMarketOrder : false
/// algoId : "0"
/// boProfitValue : 0
/// boStopLossValue : 0
/// correlationId : "1100323569-1715746157018"
/// createTime : "2024-05-15 09:39:17"
/// dhanClientId : "1100323569"
/// disclosedQuantity : 0
/// drvExpiryDate : "2024-05-15"
/// drvOptionType : "CALL"
/// drvStrikePrice : 47700
/// exchangeOrderId : "0"
/// exchangeSegment : "NSE_FNO"
/// exchangeTime : "0001-01-01 00:00:00"
/// filled_qty : 0
/// legName : "NA"
/// omsErrorCode : "0"
/// omsErrorDescription : "RMS:42240515152001:Fund Limit Insufficient By 2872.08 & Available Amount 92. Order Amount Is 2943.75"
/// orderId : "42240515152001"
/// orderStatus : "REJECTED"
/// orderType : "MARKET"
/// price : 0
/// productType : "INTRADAY"
/// quantity : 15
/// securityId : "44160"
/// tradingSymbol : "BANKNIFTY-May2024-47700-CE"
/// transactionType : "BUY"
/// triggerPrice : 0
/// updateTime : "2024-05-15 09:39:17"
/// validity : "DAY"

class Data {
  Data({
      bool? afterMarketOrder, 
      String? algoId, 
      num? boProfitValue, 
      num? boStopLossValue, 
      String? correlationId, 
      String? createTime, 
      String? dhanClientId, 
      num? disclosedQuantity, 
      String? drvExpiryDate, 
      String? drvOptionType, 
      num? drvStrikePrice, 
      String? exchangeOrderId, 
      String? exchangeSegment, 
      String? exchangeTime, 
      num? filledQty, 
      String? legName, 
      String? omsErrorCode, 
      String? omsErrorDescription, 
      String? orderId, 
      String? orderStatus, 
      String? orderType, 
      num? price, 
      String? productType, 
      num? quantity, 
      String? securityId, 
      String? tradingSymbol, 
      String? transactionType, 
      num? triggerPrice, 
      String? updateTime, 
      String? validity,}){
    _afterMarketOrder = afterMarketOrder;
    _algoId = algoId;
    _boProfitValue = boProfitValue;
    _boStopLossValue = boStopLossValue;
    _correlationId = correlationId;
    _createTime = createTime;
    _dhanClientId = dhanClientId;
    _disclosedQuantity = disclosedQuantity;
    _drvExpiryDate = drvExpiryDate;
    _drvOptionType = drvOptionType;
    _drvStrikePrice = drvStrikePrice;
    _exchangeOrderId = exchangeOrderId;
    _exchangeSegment = exchangeSegment;
    _exchangeTime = exchangeTime;
    _filledQty = filledQty;
    _legName = legName;
    _omsErrorCode = omsErrorCode;
    _omsErrorDescription = omsErrorDescription;
    _orderId = orderId;
    _orderStatus = orderStatus;
    _orderType = orderType;
    _price = price;
    _productType = productType;
    _quantity = quantity;
    _securityId = securityId;
    _tradingSymbol = tradingSymbol;
    _transactionType = transactionType;
    _triggerPrice = triggerPrice;
    _updateTime = updateTime;
    _validity = validity;
}

  Data.fromJson(dynamic json) {
    _afterMarketOrder = json['afterMarketOrder'];
    _algoId = json['algoId'];
    _boProfitValue = json['boProfitValue'];
    _boStopLossValue = json['boStopLossValue'];
    _correlationId = json['correlationId'];
    _createTime = json['createTime'];
    _dhanClientId = json['dhanClientId'];
    _disclosedQuantity = json['disclosedQuantity'];
    _drvExpiryDate = json['drvExpiryDate'];
    _drvOptionType = json['drvOptionType'];
    _drvStrikePrice = json['drvStrikePrice'];
    _exchangeOrderId = json['exchangeOrderId'];
    _exchangeSegment = json['exchangeSegment'];
    _exchangeTime = json['exchangeTime'];
    _filledQty = json['filled_qty'];
    _legName = json['legName'];
    _omsErrorCode = json['omsErrorCode'];
    _omsErrorDescription = json['omsErrorDescription'];
    _orderId = json['orderId'];
    _orderStatus = json['orderStatus'];
    _orderType = json['orderType'];
    _price = json['price'];
    _productType = json['productType'];
    _quantity = json['quantity'];
    _securityId = json['securityId'];
    _tradingSymbol = json['tradingSymbol'];
    _transactionType = json['transactionType'];
    _triggerPrice = json['triggerPrice'];
    _updateTime = json['updateTime'];
    _validity = json['validity'];
  }
  bool? _afterMarketOrder;
  String? _algoId;
  num? _boProfitValue;
  num? _boStopLossValue;
  String? _correlationId;
  String? _createTime;
  String? _dhanClientId;
  num? _disclosedQuantity;
  String? _drvExpiryDate;
  String? _drvOptionType;
  num? _drvStrikePrice;
  String? _exchangeOrderId;
  String? _exchangeSegment;
  String? _exchangeTime;
  num? _filledQty;
  String? _legName;
  String? _omsErrorCode;
  String? _omsErrorDescription;
  String? _orderId;
  String? _orderStatus;
  String? _orderType;
  num? _price;
  String? _productType;
  num? _quantity;
  String? _securityId;
  String? _tradingSymbol;
  String? _transactionType;
  num? _triggerPrice;
  String? _updateTime;
  String? _validity;
Data copyWith({  bool? afterMarketOrder,
  String? algoId,
  num? boProfitValue,
  num? boStopLossValue,
  String? correlationId,
  String? createTime,
  String? dhanClientId,
  num? disclosedQuantity,
  String? drvExpiryDate,
  String? drvOptionType,
  num? drvStrikePrice,
  String? exchangeOrderId,
  String? exchangeSegment,
  String? exchangeTime,
  num? filledQty,
  String? legName,
  String? omsErrorCode,
  String? omsErrorDescription,
  String? orderId,
  String? orderStatus,
  String? orderType,
  num? price,
  String? productType,
  num? quantity,
  String? securityId,
  String? tradingSymbol,
  String? transactionType,
  num? triggerPrice,
  String? updateTime,
  String? validity,
}) => Data(  afterMarketOrder: afterMarketOrder ?? _afterMarketOrder,
  algoId: algoId ?? _algoId,
  boProfitValue: boProfitValue ?? _boProfitValue,
  boStopLossValue: boStopLossValue ?? _boStopLossValue,
  correlationId: correlationId ?? _correlationId,
  createTime: createTime ?? _createTime,
  dhanClientId: dhanClientId ?? _dhanClientId,
  disclosedQuantity: disclosedQuantity ?? _disclosedQuantity,
  drvExpiryDate: drvExpiryDate ?? _drvExpiryDate,
  drvOptionType: drvOptionType ?? _drvOptionType,
  drvStrikePrice: drvStrikePrice ?? _drvStrikePrice,
  exchangeOrderId: exchangeOrderId ?? _exchangeOrderId,
  exchangeSegment: exchangeSegment ?? _exchangeSegment,
  exchangeTime: exchangeTime ?? _exchangeTime,
  filledQty: filledQty ?? _filledQty,
  legName: legName ?? _legName,
  omsErrorCode: omsErrorCode ?? _omsErrorCode,
  omsErrorDescription: omsErrorDescription ?? _omsErrorDescription,
  orderId: orderId ?? _orderId,
  orderStatus: orderStatus ?? _orderStatus,
  orderType: orderType ?? _orderType,
  price: price ?? _price,
  productType: productType ?? _productType,
  quantity: quantity ?? _quantity,
  securityId: securityId ?? _securityId,
  tradingSymbol: tradingSymbol ?? _tradingSymbol,
  transactionType: transactionType ?? _transactionType,
  triggerPrice: triggerPrice ?? _triggerPrice,
  updateTime: updateTime ?? _updateTime,
  validity: validity ?? _validity,
);
  bool? get afterMarketOrder => _afterMarketOrder;
  String? get algoId => _algoId;
  num? get boProfitValue => _boProfitValue;
  num? get boStopLossValue => _boStopLossValue;
  String? get correlationId => _correlationId;
  String? get createTime => _createTime;
  String? get dhanClientId => _dhanClientId;
  num? get disclosedQuantity => _disclosedQuantity;
  String? get drvExpiryDate => _drvExpiryDate;
  String? get drvOptionType => _drvOptionType;
  num? get drvStrikePrice => _drvStrikePrice;
  String? get exchangeOrderId => _exchangeOrderId;
  String? get exchangeSegment => _exchangeSegment;
  String? get exchangeTime => _exchangeTime;
  num? get filledQty => _filledQty;
  String? get legName => _legName;
  String? get omsErrorCode => _omsErrorCode;
  String? get omsErrorDescription => _omsErrorDescription;
  String? get orderId => _orderId;
  String? get orderStatus => _orderStatus;
  String? get orderType => _orderType;
  num? get price => _price;
  String? get productType => _productType;
  num? get quantity => _quantity;
  String? get securityId => _securityId;
  String? get tradingSymbol => _tradingSymbol;
  String? get transactionType => _transactionType;
  num? get triggerPrice => _triggerPrice;
  String? get updateTime => _updateTime;
  String? get validity => _validity;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['afterMarketOrder'] = _afterMarketOrder;
    map['algoId'] = _algoId;
    map['boProfitValue'] = _boProfitValue;
    map['boStopLossValue'] = _boStopLossValue;
    map['correlationId'] = _correlationId;
    map['createTime'] = _createTime;
    map['dhanClientId'] = _dhanClientId;
    map['disclosedQuantity'] = _disclosedQuantity;
    map['drvExpiryDate'] = _drvExpiryDate;
    map['drvOptionType'] = _drvOptionType;
    map['drvStrikePrice'] = _drvStrikePrice;
    map['exchangeOrderId'] = _exchangeOrderId;
    map['exchangeSegment'] = _exchangeSegment;
    map['exchangeTime'] = _exchangeTime;
    map['filled_qty'] = _filledQty;
    map['legName'] = _legName;
    map['omsErrorCode'] = _omsErrorCode;
    map['omsErrorDescription'] = _omsErrorDescription;
    map['orderId'] = _orderId;
    map['orderStatus'] = _orderStatus;
    map['orderType'] = _orderType;
    map['price'] = _price;
    map['productType'] = _productType;
    map['quantity'] = _quantity;
    map['securityId'] = _securityId;
    map['tradingSymbol'] = _tradingSymbol;
    map['transactionType'] = _transactionType;
    map['triggerPrice'] = _triggerPrice;
    map['updateTime'] = _updateTime;
    map['validity'] = _validity;
    return map;
  }

}