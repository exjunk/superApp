/// data : [{"dhanClientId":"1100323569","id":"142","index_name":"BANKNIFTY","option_type":"CE","price_level":"345.0","trade_confidence":"0.25"},{"dhanClientId":"1100323569","id":"144","index_name":"BANKNIFTY","option_type":"CE","price_level":"124.0","trade_confidence":"0.75"}]

class GetTriggerLevelsResponse {
  GetTriggerLevelsResponse({
      List<Data>? data,}){
    _data = data;
}

  GetTriggerLevelsResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  List<Data>? _data;
GetTriggerLevelsResponse copyWith({  List<Data>? data,
}) => GetTriggerLevelsResponse(  data: data ?? _data,
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
/// id : "142"
/// index_name : "BANKNIFTY"
/// option_type : "CE"
/// price_level : "345.0"
/// trade_confidence : "0.25"

class Data {
  Data({
      String? dhanClientId, 
      String? id, 
      String? indexName, 
      String? optionType, 
      String? priceLevel, 
      String? tradeConfidence,}){
    _dhanClientId = dhanClientId;
    _id = id;
    _indexName = indexName;
    _optionType = optionType;
    _priceLevel = priceLevel;
    _tradeConfidence = tradeConfidence;
}

  Data.fromJson(dynamic json) {
    _dhanClientId = json['dhanClientId'];
    _id = json['id'];
    _indexName = json['index_name'];
    _optionType = json['option_type'];
    _priceLevel = json['price_level'];
    _tradeConfidence = json['trade_confidence'];
  }
  String? _dhanClientId;
  String? _id;
  String? _indexName;
  String? _optionType;
  String? _priceLevel;
  String? _tradeConfidence;
Data copyWith({  String? dhanClientId,
  String? id,
  String? indexName,
  String? optionType,
  String? priceLevel,
  String? tradeConfidence,
}) => Data(  dhanClientId: dhanClientId ?? _dhanClientId,
  id: id ?? _id,
  indexName: indexName ?? _indexName,
  optionType: optionType ?? _optionType,
  priceLevel: priceLevel ?? _priceLevel,
  tradeConfidence: tradeConfidence ?? _tradeConfidence,
);
  String? get dhanClientId => _dhanClientId;
  String? get id => _id;
  String? get indexName => _indexName;
  String? get optionType => _optionType;
  String? get priceLevel => _priceLevel;
  String? get tradeConfidence => _tradeConfidence;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dhanClientId'] = _dhanClientId;
    map['id'] = _id;
    map['index_name'] = _indexName;
    map['option_type'] = _optionType;
    map['price_level'] = _priceLevel;
    map['trade_confidence'] = _tradeConfidence;
    return map;
  }

}