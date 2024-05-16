/// data : {"availabelBalance":1377.32,"blockedPayoutAmount":0.0,"collateralAmount":0.0,"dhanClientId":"1100323569","receiveableAmount":0.0,"sodLimit":1341.07,"utilizedAmount":80.0,"withdrawableBalance":1198.0165}
/// remarks : ""
/// status : "success"

class FundLimitResponse {
  FundLimitResponse({
      Data? data, 
      String? remarks, 
      String? status,}){
    _data = data;
    _remarks = remarks;
    _status = status;
}

  FundLimitResponse.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _remarks = json['remarks'];
    _status = json['status'];
  }
  Data? _data;
  String? _remarks;
  String? _status;
FundLimitResponse copyWith({  Data? data,
  String? remarks,
  String? status,
}) => FundLimitResponse(  data: data ?? _data,
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

/// availabelBalance : 1377.32
/// blockedPayoutAmount : 0.0
/// collateralAmount : 0.0
/// dhanClientId : "1100323569"
/// receiveableAmount : 0.0
/// sodLimit : 1341.07
/// utilizedAmount : 80.0
/// withdrawableBalance : 1198.0165

class Data {
  Data({
      num? availabelBalance, 
      num? blockedPayoutAmount, 
      num? collateralAmount, 
      String? dhanClientId, 
      num? receiveableAmount, 
      num? sodLimit, 
      num? utilizedAmount, 
      num? withdrawableBalance,}){
    _availabelBalance = availabelBalance;
    _blockedPayoutAmount = blockedPayoutAmount;
    _collateralAmount = collateralAmount;
    _dhanClientId = dhanClientId;
    _receiveableAmount = receiveableAmount;
    _sodLimit = sodLimit;
    _utilizedAmount = utilizedAmount;
    _withdrawableBalance = withdrawableBalance;
}

  Data.fromJson(dynamic json) {
    _availabelBalance = json['availabelBalance'];
    _blockedPayoutAmount = json['blockedPayoutAmount'];
    _collateralAmount = json['collateralAmount'];
    _dhanClientId = json['dhanClientId'];
    _receiveableAmount = json['receiveableAmount'];
    _sodLimit = json['sodLimit'];
    _utilizedAmount = json['utilizedAmount'];
    _withdrawableBalance = json['withdrawableBalance'];
  }
  num? _availabelBalance;
  num? _blockedPayoutAmount;
  num? _collateralAmount;
  String? _dhanClientId;
  num? _receiveableAmount;
  num? _sodLimit;
  num? _utilizedAmount;
  num? _withdrawableBalance;
Data copyWith({  num? availabelBalance,
  num? blockedPayoutAmount,
  num? collateralAmount,
  String? dhanClientId,
  num? receiveableAmount,
  num? sodLimit,
  num? utilizedAmount,
  num? withdrawableBalance,
}) => Data(  availabelBalance: availabelBalance ?? _availabelBalance,
  blockedPayoutAmount: blockedPayoutAmount ?? _blockedPayoutAmount,
  collateralAmount: collateralAmount ?? _collateralAmount,
  dhanClientId: dhanClientId ?? _dhanClientId,
  receiveableAmount: receiveableAmount ?? _receiveableAmount,
  sodLimit: sodLimit ?? _sodLimit,
  utilizedAmount: utilizedAmount ?? _utilizedAmount,
  withdrawableBalance: withdrawableBalance ?? _withdrawableBalance,
);
  num? get availabelBalance => _availabelBalance;
  num? get blockedPayoutAmount => _blockedPayoutAmount;
  num? get collateralAmount => _collateralAmount;
  String? get dhanClientId => _dhanClientId;
  num? get receiveableAmount => _receiveableAmount;
  num? get sodLimit => _sodLimit;
  num? get utilizedAmount => _utilizedAmount;
  num? get withdrawableBalance => _withdrawableBalance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['availabelBalance'] = _availabelBalance;
    map['blockedPayoutAmount'] = _blockedPayoutAmount;
    map['collateralAmount'] = _collateralAmount;
    map['dhanClientId'] = _dhanClientId;
    map['receiveableAmount'] = _receiveableAmount;
    map['sodLimit'] = _sodLimit;
    map['utilizedAmount'] = _utilizedAmount;
    map['withdrawableBalance'] = _withdrawableBalance;
    return map;
  }

}