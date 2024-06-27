/// data : [{"dhanClientId":"1100323569","id":1,"index_name":"BANKNIFTY","option_type":"CE","price_level":52800.0},{"dhanClientId":"1100323569","id":2,"index_name":"BANKNIFTY","option_type":"CE","price_level":52780.0},{"dhanClientId":"1100323569","id":3,"index_name":"NIFTY","option_type":"PE","price_level":22001.0},{"dhanClientId":"1100323569","id":4,"index_name":"BANKNIFTY","option_type":"PE","price_level":52820.0},{"dhanClientId":"1100323569","id":5,"index_name":"SENSEX","option_type":"PE","price_level":72011.0},{"dhanClientId":"1100323569","id":6,"index_name":"BANKNIFTY","option_type":"CE","price_level":52840.0},{"dhanClientId":"1100323569","id":25,"index_name":"BANKNIFTY","option_type":"PE","price_level":52862.0},{"dhanClientId":"1100323569","id":26,"index_name":"BANKNIFTY","option_type":"CE","price_level":12211.0}]

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
/// id : 1
/// index_name : "BANKNIFTY"
/// option_type : "CE"
/// price_level : 52800.0

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