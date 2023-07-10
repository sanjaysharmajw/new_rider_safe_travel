class GetRideDataLive {
  GetRideDataLive({
      bool? status, 
      List<Data>? data,}){
    _status = status;
    _data = data;
}

  GetRideDataLive.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _status;
  List<Data>? _data;
GetRideDataLive copyWith({  bool? status,
  List<Data>? data,
}) => GetRideDataLive(  status: status ?? _status,
  data: data ?? _data,
);
  bool? get status => _status;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Data {
  Data({
      num? lat, 
      num? lng, 
      String? status, 
      String? subStatus, 
      String? vehicleType, 
      String? gender, 
      String? driverLicense, 
      String? vehicleNo, 
      num? altitude, 
      num? speed, 
      num? speedAccuracy, 
      String? elapsedRealtimeUncertaintyNanos, 
      num? elapsedRealtimeNanos, 
      num? heading, 
      num? headingAccuracy, 
      String? provider, 
      String? satelliteNumber, 
      num? verticalAccuracy, 
      num? hDop, 
      num? vDop, 
      String? time,}){
    _lat = lat;
    _lng = lng;
    _status = status;
    _subStatus = subStatus;
    _vehicleType = vehicleType;
    _gender = gender;
    _driverLicense = driverLicense;
    _vehicleNo = vehicleNo;
    _altitude = altitude;
    _speed = speed;
    _speedAccuracy = speedAccuracy;
    _elapsedRealtimeUncertaintyNanos = elapsedRealtimeUncertaintyNanos;
    _elapsedRealtimeNanos = elapsedRealtimeNanos;
    _heading = heading;
    _headingAccuracy = headingAccuracy;
    _provider = provider;
    _satelliteNumber = satelliteNumber;
    _verticalAccuracy = verticalAccuracy;
    _hDop = hDop;
    _vDop = vDop;
    _time = time;
}

  Data.fromJson(dynamic json) {
    _lat = json['lat'];
    _lng = json['lng'];
    _status = json['status'];
    _subStatus = json['sub_status'];
    _vehicleType = json['vehicle_type'];
    _gender = json['gender'];
    _driverLicense = json['driver_license'];
    _vehicleNo = json['vehicle_no'];
    _altitude = json['altitude'];
    _speed = json['speed'];
    _speedAccuracy = json['speedAccuracy'];
    _elapsedRealtimeUncertaintyNanos = json['elapsedRealtimeUncertaintyNanos'];
    _elapsedRealtimeNanos = json['elapsedRealtimeNanos'];
    _heading = json['heading'];
    _headingAccuracy = json['headingAccuracy'];
    _provider = json['provider'];
    _satelliteNumber = json['satelliteNumber'];
    _verticalAccuracy = json['verticalAccuracy'];
    _hDop = json['h_dop'];
    _vDop = json['v_dop'];
    _time = json['time'];
  }
  num? _lat;
  num? _lng;
  String? _status;
  String? _subStatus;
  String? _vehicleType;
  String? _gender;
  String? _driverLicense;
  String? _vehicleNo;
  num? _altitude;
  num? _speed;
  num? _speedAccuracy;
  String? _elapsedRealtimeUncertaintyNanos;
  num? _elapsedRealtimeNanos;
  num? _heading;
  num? _headingAccuracy;
  String? _provider;
  String? _satelliteNumber;
  num? _verticalAccuracy;
  num? _hDop;
  num? _vDop;
  String? _time;
Data copyWith({  num? lat,
  num? lng,
  String? status,
  String? subStatus,
  String? vehicleType,
  String? gender,
  String? driverLicense,
  String? vehicleNo,
  num? altitude,
  num? speed,
  num? speedAccuracy,
  String? elapsedRealtimeUncertaintyNanos,
  num? elapsedRealtimeNanos,
  num? heading,
  num? headingAccuracy,
  String? provider,
  String? satelliteNumber,
  num? verticalAccuracy,
  num? hDop,
  num? vDop,
  String? time,
}) => Data(  lat: lat ?? _lat,
  lng: lng ?? _lng,
  status: status ?? _status,
  subStatus: subStatus ?? _subStatus,
  vehicleType: vehicleType ?? _vehicleType,
  gender: gender ?? _gender,
  driverLicense: driverLicense ?? _driverLicense,
  vehicleNo: vehicleNo ?? _vehicleNo,
  altitude: altitude ?? _altitude,
  speed: speed ?? _speed,
  speedAccuracy: speedAccuracy ?? _speedAccuracy,
  elapsedRealtimeUncertaintyNanos: elapsedRealtimeUncertaintyNanos ?? _elapsedRealtimeUncertaintyNanos,
  elapsedRealtimeNanos: elapsedRealtimeNanos ?? _elapsedRealtimeNanos,
  heading: heading ?? _heading,
  headingAccuracy: headingAccuracy ?? _headingAccuracy,
  provider: provider ?? _provider,
  satelliteNumber: satelliteNumber ?? _satelliteNumber,
  verticalAccuracy: verticalAccuracy ?? _verticalAccuracy,
  hDop: hDop ?? _hDop,
  vDop: vDop ?? _vDop,
  time: time ?? _time,
);
  num? get lat => _lat;
  num? get lng => _lng;
  String? get status => _status;
  String? get subStatus => _subStatus;
  String? get vehicleType => _vehicleType;
  String? get gender => _gender;
  String? get driverLicense => _driverLicense;
  String? get vehicleNo => _vehicleNo;
  num? get altitude => _altitude;
  num? get speed => _speed;
  num? get speedAccuracy => _speedAccuracy;
  String? get elapsedRealtimeUncertaintyNanos => _elapsedRealtimeUncertaintyNanos;
  num? get elapsedRealtimeNanos => _elapsedRealtimeNanos;
  num? get heading => _heading;
  num? get headingAccuracy => _headingAccuracy;
  String? get provider => _provider;
  String? get satelliteNumber => _satelliteNumber;
  num? get verticalAccuracy => _verticalAccuracy;
  num? get hDop => _hDop;
  num? get vDop => _vDop;
  String? get time => _time;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = _lat;
    map['lng'] = _lng;
    map['status'] = _status;
    map['sub_status'] = _subStatus;
    map['vehicle_type'] = _vehicleType;
    map['gender'] = _gender;
    map['driver_license'] = _driverLicense;
    map['vehicle_no'] = _vehicleNo;
    map['altitude'] = _altitude;
    map['speed'] = _speed;
    map['speedAccuracy'] = _speedAccuracy;
    map['elapsedRealtimeUncertaintyNanos'] = _elapsedRealtimeUncertaintyNanos;
    map['elapsedRealtimeNanos'] = _elapsedRealtimeNanos;
    map['heading'] = _heading;
    map['headingAccuracy'] = _headingAccuracy;
    map['provider'] = _provider;
    map['satelliteNumber'] = _satelliteNumber;
    map['verticalAccuracy'] = _verticalAccuracy;
    map['h_dop'] = _hDop;
    map['v_dop'] = _vDop;
    map['time'] = _time;
    return map;
  }

}