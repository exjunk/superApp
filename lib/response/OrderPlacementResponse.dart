/// data : {"orderId":"62240514896901","orderStatus":"TRANSIT"}
/// remarks : ""
/// status : "success"

class OrderPlacementResponse {
  OrderPlacementResponse({
    Data? data,
    String? remarks,
    String? status,
    String? securityID,
  }) {
    _data = data;
    _remarks = remarks;
    _status = status;
    _securityID = securityID;
  }

  OrderPlacementResponse.fromJson(dynamic json) {
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _remarks = json['remarks'];
    _status = json['status'];
    _securityID = json['security_id'];
  }

  Data? _data;
  String? _remarks;
  String? _status;
  String? _securityID;

  OrderPlacementResponse copyWith({
    Data? data,
    String? remarks,
    String? status,
    String? securityID,
  }) =>
      OrderPlacementResponse(
        data: data ?? _data,
        remarks: remarks ?? _remarks,
        status: status ?? _status,
        securityID: securityID ?? _securityID,
      );

  Data? get data => _data;

  String? get remarks => _remarks;

  String? get status => _status;

  String? get securityID => _securityID;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['remarks'] = _remarks;
    map['status'] = _status;
    map['security_id'] = _securityID;
    return map;
  }
}

/// orderId : "62240514896901"
/// orderStatus : "TRANSIT"

class Data {
  Data({
    String? orderId,
    String? orderStatus,
  }) {
    _orderId = orderId;
    _orderStatus = orderStatus;
  }

  Data.fromJson(dynamic json) {
    _orderId = json['orderId'];
    _orderStatus = json['orderStatus'];
  }

  String? _orderId;
  String? _orderStatus;

  Data copyWith({
    String? orderId,
    String? orderStatus,
  }) =>
      Data(
        orderId: orderId ?? _orderId,
        orderStatus: orderStatus ?? _orderStatus,
      );

  String? get orderId => _orderId;

  String? get orderStatus => _orderStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['orderId'] = _orderId;
    map['orderStatus'] = _orderStatus;
    return map;
  }
}
