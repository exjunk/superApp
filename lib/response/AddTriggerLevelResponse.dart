/// data : {"dhanClientId":"1100323569","id":74,"index_name":"SENSEX","option_type":"PE","price_level":80235.0}

class AddTriggerLevelResponse {
  AddTriggerLevelResponse({
      Data? data,}){
    _data = data;
}

  AddTriggerLevelResponse.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Data? _data;
AddTriggerLevelResponse copyWith({  Data? data,
}) => AddTriggerLevelResponse(  data: data ?? _data,
);
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// dhanClientId : "1100323569"
/// id : 74
/// index_name : "SENSEX"
/// option_type : "PE"
/// price_level : 80235.0

class Data {
  Data({
      String? dhanClientId, 
      num? id, 
      String? indexName, 
      String? optionType, 
      num? priceLevel,}){
    _dhanClientId = dhanClientId;
    _id = id;
    _indexName = indexName;
    _optionType = optionType;
    _priceLevel = priceLevel;
}

  Data.fromJson(dynamic json) {
    _dhanClientId = json['dhanClientId'];
    _id = json['id'];
    _indexName = json['index_name'];
    _optionType = json['option_type'];
    _priceLevel = json['price_level'];
  }
  String? _dhanClientId;
  num? _id;
  String? _indexName;
  String? _optionType;
  num? _priceLevel;
Data copyWith({  String? dhanClientId,
  num? id,
  String? indexName,
  String? optionType,
  num? priceLevel,
}) => Data(  dhanClientId: dhanClientId ?? _dhanClientId,
  id: id ?? _id,
  indexName: indexName ?? _indexName,
  optionType: optionType ?? _optionType,
  priceLevel: priceLevel ?? _priceLevel,
);
  String? get dhanClientId => _dhanClientId;
  num? get id => _id;
  String? get indexName => _indexName;
  String? get optionType => _optionType;
  num? get priceLevel => _priceLevel;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dhanClientId'] = _dhanClientId;
    map['id'] = _id;
    map['index_name'] = _indexName;
    map['option_type'] = _optionType;
    map['price_level'] = _priceLevel;
    return map;
  }

}