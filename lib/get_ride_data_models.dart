class GetRideDataModels {
  GetRideDataModels({
      bool? status, 
      List<Data>? data,}){
    _status = status;
    _data = data;
}

  GetRideDataModels.fromJson(dynamic json) {
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
GetRideDataModels copyWith({  bool? status,
  List<Data>? data,
}) => GetRideDataModels(  status: status ?? _status,
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
      num? altitude, 
      String? rideId, 
      num? lng, 
      String? subStatus, 
      String? gender, 
      String? heading, 
      String? headingAccuracy, 
      String? vehicleNo, 
      num? hDop, 
      String? vehicleType, 
      String? accuracy, 
      String? speed, 
      String? speedAccuracy, 
      String? elapsedRealtimeNanos, 
      String? verticalAccuracy, 
      String? provider, 
      String? satelliteNumber, 
      num? vDop, 
      String? elapsedRealtimeUncertaintyNanos, 
      String? time, 
      String? driverLicense, 
      num? lat, 
      String? timestamp, 
      String? status,}){
    _altitude = altitude;
    _rideId = rideId;
    _lng = lng;
    _subStatus = subStatus;
    _gender = gender;
    _heading = heading;
    _headingAccuracy = headingAccuracy;
    _vehicleNo = vehicleNo;
    _hDop = hDop;
    _vehicleType = vehicleType;
    _accuracy = accuracy;
    _speed = speed;
    _speedAccuracy = speedAccuracy;
    _elapsedRealtimeNanos = elapsedRealtimeNanos;
    _verticalAccuracy = verticalAccuracy;
    _provider = provider;
    _satelliteNumber = satelliteNumber;
    _vDop = vDop;
    _elapsedRealtimeUncertaintyNanos = elapsedRealtimeUncertaintyNanos;
    _time = time;
    _driverLicense = driverLicense;
    _lat = lat;
    _timestamp = timestamp;
    _status = status;
}

  Data.fromJson(dynamic json) {
    _altitude = json['altitude'];
    _rideId = json['ride_id'];
    _lng = json['lng'];
    _subStatus = json['sub_status'];
    _gender = json['gender'];
    _heading = json['heading'];
    _headingAccuracy = json['headingAccuracy'];
    _vehicleNo = json['vehicle_no'];
    _hDop = json['h_dop'];
    _vehicleType = json['vehicle_type'];
    _accuracy = json['accuracy'];
    _speed = json['speed'];
    _speedAccuracy = json['speedAccuracy'];
    _elapsedRealtimeNanos = json['elapsedRealtimeNanos'];
    _verticalAccuracy = json['verticalAccuracy'];
    _provider = json['provider'];
    _satelliteNumber = json['satelliteNumber'];
    _vDop = json['v_dop'];
    _elapsedRealtimeUncertaintyNanos = json['elapsedRealtimeUncertaintyNanos'];
    _time = json['time'];
    _driverLicense = json['driver_license'];
    _lat = json['lat'];
    _timestamp = json['timestamp'];
    _status = json['status'];
  }
  num? _altitude;
  String? _rideId;
  num? _lng;
  String? _subStatus;
  String? _gender;
  String? _heading;
  String? _headingAccuracy;
  String? _vehicleNo;
  num? _hDop;
  String? _vehicleType;
  String? _accuracy;
  String? _speed;
  String? _speedAccuracy;
  String? _elapsedRealtimeNanos;
  String? _verticalAccuracy;
  String? _provider;
  String? _satelliteNumber;
  num? _vDop;
  String? _elapsedRealtimeUncertaintyNanos;
  String? _time;
  String? _driverLicense;
  num? _lat;
  String? _timestamp;
  String? _status;
Data copyWith({  num? altitude,
  String? rideId,
  num? lng,
  String? subStatus,
  String? gender,
  String? heading,
  String? headingAccuracy,
  String? vehicleNo,
  num? hDop,
  String? vehicleType,
  String? accuracy,
  String? speed,
  String? speedAccuracy,
  String? elapsedRealtimeNanos,
  String? verticalAccuracy,
  String? provider,
  String? satelliteNumber,
  num? vDop,
  String? elapsedRealtimeUncertaintyNanos,
  String? time,
  String? driverLicense,
  num? lat,
  String? timestamp,
  String? status,
}) => Data(  altitude: altitude ?? _altitude,
  rideId: rideId ?? _rideId,
  lng: lng ?? _lng,
  subStatus: subStatus ?? _subStatus,
  gender: gender ?? _gender,
  heading: heading ?? _heading,
  headingAccuracy: headingAccuracy ?? _headingAccuracy,
  vehicleNo: vehicleNo ?? _vehicleNo,
  hDop: hDop ?? _hDop,
  vehicleType: vehicleType ?? _vehicleType,
  accuracy: accuracy ?? _accuracy,
  speed: speed ?? _speed,
  speedAccuracy: speedAccuracy ?? _speedAccuracy,
  elapsedRealtimeNanos: elapsedRealtimeNanos ?? _elapsedRealtimeNanos,
  verticalAccuracy: verticalAccuracy ?? _verticalAccuracy,
  provider: provider ?? _provider,
  satelliteNumber: satelliteNumber ?? _satelliteNumber,
  vDop: vDop ?? _vDop,
  elapsedRealtimeUncertaintyNanos: elapsedRealtimeUncertaintyNanos ?? _elapsedRealtimeUncertaintyNanos,
  time: time ?? _time,
  driverLicense: driverLicense ?? _driverLicense,
  lat: lat ?? _lat,
  timestamp: timestamp ?? _timestamp,
  status: status ?? _status,
);
  num? get altitude => _altitude;
  String? get rideId => _rideId;
  num? get lng => _lng;
  String? get subStatus => _subStatus;
  String? get gender => _gender;
  String? get heading => _heading;
  String? get headingAccuracy => _headingAccuracy;
  String? get vehicleNo => _vehicleNo;
  num? get hDop => _hDop;
  String? get vehicleType => _vehicleType;
  String? get accuracy => _accuracy;
  String? get speed => _speed;
  String? get speedAccuracy => _speedAccuracy;
  String? get elapsedRealtimeNanos => _elapsedRealtimeNanos;
  String? get verticalAccuracy => _verticalAccuracy;
  String? get provider => _provider;
  String? get satelliteNumber => _satelliteNumber;
  num? get vDop => _vDop;
  String? get elapsedRealtimeUncertaintyNanos => _elapsedRealtimeUncertaintyNanos;
  String? get time => _time;
  String? get driverLicense => _driverLicense;
  num? get lat => _lat;
  String? get timestamp => _timestamp;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['altitude'] = _altitude;
    map['ride_id'] = _rideId;
    map['lng'] = _lng;
    map['sub_status'] = _subStatus;
    map['gender'] = _gender;
    map['heading'] = _heading;
    map['headingAccuracy'] = _headingAccuracy;
    map['vehicle_no'] = _vehicleNo;
    map['h_dop'] = _hDop;
    map['vehicle_type'] = _vehicleType;
    map['accuracy'] = _accuracy;
    map['speed'] = _speed;
    map['speedAccuracy'] = _speedAccuracy;
    map['elapsedRealtimeNanos'] = _elapsedRealtimeNanos;
    map['verticalAccuracy'] = _verticalAccuracy;
    map['provider'] = _provider;
    map['satelliteNumber'] = _satelliteNumber;
    map['v_dop'] = _vDop;
    map['elapsedRealtimeUncertaintyNanos'] = _elapsedRealtimeUncertaintyNanos;
    map['time'] = _time;
    map['driver_license'] = _driverLicense;
    map['lat'] = _lat;
    map['timestamp'] = _timestamp;
    map['status'] = _status;
    return map;
  }

}