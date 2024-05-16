/// data : [{"buyAvg":19.85,"buyQty":15,"carryForwardBuyQty":0,"carryForwardBuyValue":0.0,"carryForwardSellQty":0,"carryForwardSellValue":0.0,"costPrice":19.85,"crossCurrency":false,"dayBuyQty":15,"dayBuyValue":297.75,"daySellQty":0,"daySellValue":0.0,"dhanClientId":"1100323569","drvExpiryDate":"2024-05-15 14:30:00","drvOptionType":"PUT","drvStrikePrice":47400.0,"exchangeSegment":"NSE_FNO","multiplier":1,"netQty":15,"positionType":"LONG","productType":"MARGIN","rbiReferenceRate":1.0,"realizedProfit":0.0,"securityId":"44147","sellAvg":0.0,"sellQty":0,"tradingSymbol":"BANKNIFTY-May2024-47400-PE","unrealizedProfit":-34.50001}]
/// remarks : ""
/// status : "success"

class GetPositionsResponse {
  GetPositionsResponse({
      List<Data>? data, 
      String? remarks, 
      String? status,}){
    _data = data;
    _remarks = remarks;
    _status = status;
}

  GetPositionsResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _remarks = json['remarks'];
    _status = json['status'];
  }
  List<Data>? _data;
  String? _remarks;
  String? _status;
GetPositionsResponse copyWith({  List<Data>? data,
  String? remarks,
  String? status,
}) => GetPositionsResponse(  data: data ?? _data,
  remarks: remarks ?? _remarks,
  status: status ?? _status,
);
  List<Data>? get data => _data;
  String? get remarks => _remarks;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['remarks'] = _remarks;
    map['status'] = _status;
    return map;
  }

}

/// buyAvg : 19.85
/// buyQty : 15
/// carryForwardBuyQty : 0
/// carryForwardBuyValue : 0.0
/// carryForwardSellQty : 0
/// carryForwardSellValue : 0.0
/// costPrice : 19.85
/// crossCurrency : false
/// dayBuyQty : 15
/// dayBuyValue : 297.75
/// daySellQty : 0
/// daySellValue : 0.0
/// dhanClientId : "1100323569"
/// drvExpiryDate : "2024-05-15 14:30:00"
/// drvOptionType : "PUT"
/// drvStrikePrice : 47400.0
/// exchangeSegment : "NSE_FNO"
/// multiplier : 1
/// netQty : 15
/// positionType : "LONG"
/// productType : "MARGIN"
/// rbiReferenceRate : 1.0
/// realizedProfit : 0.0
/// securityId : "44147"
/// sellAvg : 0.0
/// sellQty : 0
/// tradingSymbol : "BANKNIFTY-May2024-47400-PE"
/// unrealizedProfit : -34.50001

class Data {
  Data({
      num? buyAvg, 
      num? buyQty, 
      num? carryForwardBuyQty, 
      num? carryForwardBuyValue, 
      num? carryForwardSellQty, 
      num? carryForwardSellValue, 
      num? costPrice, 
      bool? crossCurrency, 
      num? dayBuyQty, 
      num? dayBuyValue, 
      num? daySellQty, 
      num? daySellValue, 
      String? dhanClientId, 
      String? drvExpiryDate, 
      String? drvOptionType, 
      num? drvStrikePrice, 
      String? exchangeSegment, 
      num? multiplier, 
      num? netQty, 
      String? positionType, 
      String? productType, 
      num? rbiReferenceRate, 
      num? realizedProfit, 
      String? securityId, 
      num? sellAvg, 
      num? sellQty, 
      String? tradingSymbol, 
      num? unrealizedProfit,}){
    _buyAvg = buyAvg;
    _buyQty = buyQty;
    _carryForwardBuyQty = carryForwardBuyQty;
    _carryForwardBuyValue = carryForwardBuyValue;
    _carryForwardSellQty = carryForwardSellQty;
    _carryForwardSellValue = carryForwardSellValue;
    _costPrice = costPrice;
    _crossCurrency = crossCurrency;
    _dayBuyQty = dayBuyQty;
    _dayBuyValue = dayBuyValue;
    _daySellQty = daySellQty;
    _daySellValue = daySellValue;
    _dhanClientId = dhanClientId;
    _drvExpiryDate = drvExpiryDate;
    _drvOptionType = drvOptionType;
    _drvStrikePrice = drvStrikePrice;
    _exchangeSegment = exchangeSegment;
    _multiplier = multiplier;
    _netQty = netQty;
    _positionType = positionType;
    _productType = productType;
    _rbiReferenceRate = rbiReferenceRate;
    _realizedProfit = realizedProfit;
    _securityId = securityId;
    _sellAvg = sellAvg;
    _sellQty = sellQty;
    _tradingSymbol = tradingSymbol;
    _unrealizedProfit = unrealizedProfit;
}

  Data.fromJson(dynamic json) {
    _buyAvg = json['buyAvg'];
    _buyQty = json['buyQty'];
    _carryForwardBuyQty = json['carryForwardBuyQty'];
    _carryForwardBuyValue = json['carryForwardBuyValue'];
    _carryForwardSellQty = json['carryForwardSellQty'];
    _carryForwardSellValue = json['carryForwardSellValue'];
    _costPrice = json['costPrice'];
    _crossCurrency = json['crossCurrency'];
    _dayBuyQty = json['dayBuyQty'];
    _dayBuyValue = json['dayBuyValue'];
    _daySellQty = json['daySellQty'];
    _daySellValue = json['daySellValue'];
    _dhanClientId = json['dhanClientId'];
    _drvExpiryDate = json['drvExpiryDate'];
    _drvOptionType = json['drvOptionType'];
    _drvStrikePrice = json['drvStrikePrice'];
    _exchangeSegment = json['exchangeSegment'];
    _multiplier = json['multiplier'];
    _netQty = json['netQty'];
    _positionType = json['positionType'];
    _productType = json['productType'];
    _rbiReferenceRate = json['rbiReferenceRate'];
    _realizedProfit = json['realizedProfit'];
    _securityId = json['securityId'];
    _sellAvg = json['sellAvg'];
    _sellQty = json['sellQty'];
    _tradingSymbol = json['tradingSymbol'];
    _unrealizedProfit = json['unrealizedProfit'];
  }
  num? _buyAvg;
  num? _buyQty;
  num? _carryForwardBuyQty;
  num? _carryForwardBuyValue;
  num? _carryForwardSellQty;
  num? _carryForwardSellValue;
  num? _costPrice;
  bool? _crossCurrency;
  num? _dayBuyQty;
  num? _dayBuyValue;
  num? _daySellQty;
  num? _daySellValue;
  String? _dhanClientId;
  String? _drvExpiryDate;
  String? _drvOptionType;
  num? _drvStrikePrice;
  String? _exchangeSegment;
  num? _multiplier;
  num? _netQty;
  String? _positionType;
  String? _productType;
  num? _rbiReferenceRate;
  num? _realizedProfit;
  String? _securityId;
  num? _sellAvg;
  num? _sellQty;
  String? _tradingSymbol;
  num? _unrealizedProfit;
Data copyWith({  num? buyAvg,
  num? buyQty,
  num? carryForwardBuyQty,
  num? carryForwardBuyValue,
  num? carryForwardSellQty,
  num? carryForwardSellValue,
  num? costPrice,
  bool? crossCurrency,
  num? dayBuyQty,
  num? dayBuyValue,
  num? daySellQty,
  num? daySellValue,
  String? dhanClientId,
  String? drvExpiryDate,
  String? drvOptionType,
  num? drvStrikePrice,
  String? exchangeSegment,
  num? multiplier,
  num? netQty,
  String? positionType,
  String? productType,
  num? rbiReferenceRate,
  num? realizedProfit,
  String? securityId,
  num? sellAvg,
  num? sellQty,
  String? tradingSymbol,
  num? unrealizedProfit,
}) => Data(  buyAvg: buyAvg ?? _buyAvg,
  buyQty: buyQty ?? _buyQty,
  carryForwardBuyQty: carryForwardBuyQty ?? _carryForwardBuyQty,
  carryForwardBuyValue: carryForwardBuyValue ?? _carryForwardBuyValue,
  carryForwardSellQty: carryForwardSellQty ?? _carryForwardSellQty,
  carryForwardSellValue: carryForwardSellValue ?? _carryForwardSellValue,
  costPrice: costPrice ?? _costPrice,
  crossCurrency: crossCurrency ?? _crossCurrency,
  dayBuyQty: dayBuyQty ?? _dayBuyQty,
  dayBuyValue: dayBuyValue ?? _dayBuyValue,
  daySellQty: daySellQty ?? _daySellQty,
  daySellValue: daySellValue ?? _daySellValue,
  dhanClientId: dhanClientId ?? _dhanClientId,
  drvExpiryDate: drvExpiryDate ?? _drvExpiryDate,
  drvOptionType: drvOptionType ?? _drvOptionType,
  drvStrikePrice: drvStrikePrice ?? _drvStrikePrice,
  exchangeSegment: exchangeSegment ?? _exchangeSegment,
  multiplier: multiplier ?? _multiplier,
  netQty: netQty ?? _netQty,
  positionType: positionType ?? _positionType,
  productType: productType ?? _productType,
  rbiReferenceRate: rbiReferenceRate ?? _rbiReferenceRate,
  realizedProfit: realizedProfit ?? _realizedProfit,
  securityId: securityId ?? _securityId,
  sellAvg: sellAvg ?? _sellAvg,
  sellQty: sellQty ?? _sellQty,
  tradingSymbol: tradingSymbol ?? _tradingSymbol,
  unrealizedProfit: unrealizedProfit ?? _unrealizedProfit,
);
  num? get buyAvg => _buyAvg;
  num? get buyQty => _buyQty;
  num? get carryForwardBuyQty => _carryForwardBuyQty;
  num? get carryForwardBuyValue => _carryForwardBuyValue;
  num? get carryForwardSellQty => _carryForwardSellQty;
  num? get carryForwardSellValue => _carryForwardSellValue;
  num? get costPrice => _costPrice;
  bool? get crossCurrency => _crossCurrency;
  num? get dayBuyQty => _dayBuyQty;
  num? get dayBuyValue => _dayBuyValue;
  num? get daySellQty => _daySellQty;
  num? get daySellValue => _daySellValue;
  String? get dhanClientId => _dhanClientId;
  String? get drvExpiryDate => _drvExpiryDate;
  String? get drvOptionType => _drvOptionType;
  num? get drvStrikePrice => _drvStrikePrice;
  String? get exchangeSegment => _exchangeSegment;
  num? get multiplier => _multiplier;
  num? get netQty => _netQty;
  String? get positionType => _positionType;
  String? get productType => _productType;
  num? get rbiReferenceRate => _rbiReferenceRate;
  num? get realizedProfit => _realizedProfit;
  String? get securityId => _securityId;
  num? get sellAvg => _sellAvg;
  num? get sellQty => _sellQty;
  String? get tradingSymbol => _tradingSymbol;
  num? get unrealizedProfit => _unrealizedProfit;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['buyAvg'] = _buyAvg;
    map['buyQty'] = _buyQty;
    map['carryForwardBuyQty'] = _carryForwardBuyQty;
    map['carryForwardBuyValue'] = _carryForwardBuyValue;
    map['carryForwardSellQty'] = _carryForwardSellQty;
    map['carryForwardSellValue'] = _carryForwardSellValue;
    map['costPrice'] = _costPrice;
    map['crossCurrency'] = _crossCurrency;
    map['dayBuyQty'] = _dayBuyQty;
    map['dayBuyValue'] = _dayBuyValue;
    map['daySellQty'] = _daySellQty;
    map['daySellValue'] = _daySellValue;
    map['dhanClientId'] = _dhanClientId;
    map['drvExpiryDate'] = _drvExpiryDate;
    map['drvOptionType'] = _drvOptionType;
    map['drvStrikePrice'] = _drvStrikePrice;
    map['exchangeSegment'] = _exchangeSegment;
    map['multiplier'] = _multiplier;
    map['netQty'] = _netQty;
    map['positionType'] = _positionType;
    map['productType'] = _productType;
    map['rbiReferenceRate'] = _rbiReferenceRate;
    map['realizedProfit'] = _realizedProfit;
    map['securityId'] = _securityId;
    map['sellAvg'] = _sellAvg;
    map['sellQty'] = _sellQty;
    map['tradingSymbol'] = _tradingSymbol;
    map['unrealizedProfit'] = _unrealizedProfit;
    return map;
  }

}