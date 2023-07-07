class GetVolunteerModels {
  GetVolunteerModels({
      bool? status, 
      List<VolunteerData>? data,}){
    _status = status;
    _data = data;
}

  GetVolunteerModels.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(VolunteerData.fromJson(v));
      });
    }
  }
  bool? _status;
  List<VolunteerData>? _data;
  GetVolunteerModels copyWith({  bool? status,
  List<VolunteerData>? data,
}) => GetVolunteerModels(  status: status ?? _status,
  data: data ?? _data,
);
  bool? get status => _status;
  List<VolunteerData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class VolunteerData {
  VolunteerData({
      String? id, 
      String? reason, 
      num? distance, 
      String? lat, 
      String? lng, 
      String? userName, 
      String? userMobile, 
      String? driverName, 
      String? driverMobile, 
      String? vehicleNumber, 
      String? color, 
      String? vehicleType, 
      String? vehicleModel, 
      String? date, 
      String? status,}){
    _id = id;
    _reason = reason;
    _distance = distance;
    _lat = lat;
    _lng = lng;
    _userName = userName;
    _userMobile = userMobile;
    _driverName = driverName;
    _driverMobile = driverMobile;
    _vehicleNumber = vehicleNumber;
    _color = color;
    _vehicleType = vehicleType;
    _vehicleModel = vehicleModel;
    _date = date;
    _status = status;
}

  VolunteerData.fromJson(dynamic json) {
    _id = json['_id'];
    _reason = json['reason'];
    _distance = json['distance'];
    _lat = json['lat'];
    _lng = json['lng'];
    _userName = json['user_name'];
    _userMobile = json['user_mobile'];
    _driverName = json['driver_name'];
    _driverMobile = json['driver_mobile'];
    _vehicleNumber = json['vehicle_number'];
    _color = json['color'];
    _vehicleType = json['vehicle_type'];
    _vehicleModel = json['vehicle_model'];
    _date = json['date'];
    _status = json['status'];
  }
  String? _id;
  String? _reason;
  num? _distance;
  String? _lat;
  String? _lng;
  String? _userName;
  String? _userMobile;
  String? _driverName;
  String? _driverMobile;
  String? _vehicleNumber;
  String? _color;
  String? _vehicleType;
  String? _vehicleModel;
  String? _date;
  String? _status;
  VolunteerData copyWith({  String? id,
  String? reason,
  num? distance,
  String? lat,
  String? lng,
  String? userName,
  String? userMobile,
  String? driverName,
  String? driverMobile,
  String? vehicleNumber,
  String? color,
  String? vehicleType,
  String? vehicleModel,
  String? date,
  String? status,
}) => VolunteerData(  id: id ?? _id,
  reason: reason ?? _reason,
  distance: distance ?? _distance,
  lat: lat ?? _lat,
  lng: lng ?? _lng,
  userName: userName ?? _userName,
  userMobile: userMobile ?? _userMobile,
  driverName: driverName ?? _driverName,
  driverMobile: driverMobile ?? _driverMobile,
  vehicleNumber: vehicleNumber ?? _vehicleNumber,
  color: color ?? _color,
  vehicleType: vehicleType ?? _vehicleType,
  vehicleModel: vehicleModel ?? _vehicleModel,
  date: date ?? _date,
  status: status ?? _status,
);
  String? get id => _id;
  String? get reason => _reason;
  num? get distance => _distance;
  String? get lat => _lat;
  String? get lng => _lng;
  String? get userName => _userName;
  String? get userMobile => _userMobile;
  String? get driverName => _driverName;
  String? get driverMobile => _driverMobile;
  String? get vehicleNumber => _vehicleNumber;
  String? get color => _color;
  String? get vehicleType => _vehicleType;
  String? get vehicleModel => _vehicleModel;
  String? get date => _date;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['reason'] = _reason;
    map['distance'] = _distance;
    map['lat'] = _lat;
    map['lng'] = _lng;
    map['user_name'] = _userName;
    map['user_mobile'] = _userMobile;
    map['driver_name'] = _driverName;
    map['driver_mobile'] = _driverMobile;
    map['vehicle_number'] = _vehicleNumber;
    map['color'] = _color;
    map['vehicle_type'] = _vehicleType;
    map['vehicle_model'] = _vehicleModel;
    map['date'] = _date;
    map['status'] = _status;
    return map;
  }

}