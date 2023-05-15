class StartRideRequestForVehicle {
  StartRideRequestForVehicle({
      String? userId, 
      String? vehicleNumber, 
      String? driverName, 
      String? mobileNumber, 
      String? date,
    StartPointForVehicle? startPoint,}){
    _userId = userId;
    _vehicleNumber = vehicleNumber;
    _driverName = driverName;
    _mobileNumber = mobileNumber;
    _date = date;
    _startPoint = startPoint;
}

  StartRideRequestForVehicle.fromJson(dynamic json) {
    _userId = json['user_id'];
    _vehicleNumber = json['vehicle_number'];
    _driverName = json['driver_name'];
    _mobileNumber = json['mobile_number'];
    _date = json['date'];
    _startPoint = json['start_point'] != null ? StartPointForVehicle.fromJson(json['start_point']) : null;
  }
  String? _userId;
  String? _vehicleNumber;
  String? _driverName;
  String? _mobileNumber;
  String? _date;
  StartPointForVehicle? _startPoint;
  StartRideRequestForVehicle copyWith({  String? userId,
  String? vehicleNumber,
  String? driverName,
  String? mobileNumber,
  String? date,
    StartPointForVehicle? startPoint,
}) => StartRideRequestForVehicle(  userId: userId ?? _userId,
  vehicleNumber: vehicleNumber ?? _vehicleNumber,
  driverName: driverName ?? _driverName,
  mobileNumber: mobileNumber ?? _mobileNumber,
  date: date ?? _date,
  startPoint: startPoint ?? _startPoint,
);
  String? get userId => _userId;
  String? get vehicleNumber => _vehicleNumber;
  String? get driverName => _driverName;
  String? get mobileNumber => _mobileNumber;
  String? get date => _date;
  StartPointForVehicle? get startPoint => _startPoint;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['vehicle_number'] = _vehicleNumber;
    map['driver_name'] = _driverName;
    map['mobile_number'] = _mobileNumber;
    map['date'] = _date;
    if (_startPoint != null) {
      map['start_point'] = _startPoint?.toJson();
    }
    return map;
  }

}

class StartPointForVehicle {
  StartPointForVehicle({
      String? time, 
      num? latitude, 
      num? longitude, 
      String? location,}){
    _time = time;
    _latitude = latitude;
    _longitude = longitude;
    _location = location;
}

  StartPointForVehicle.fromJson(dynamic json) {
    _time = json['time'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _location = json['location'];
  }
  String? _time;
  num? _latitude;
  num? _longitude;
  String? _location;
  StartPointForVehicle copyWith({  String? time,
  num? latitude,
  num? longitude,
  String? location,
}) => StartPointForVehicle(  time: time ?? _time,
  latitude: latitude ?? _latitude,
  longitude: longitude ?? _longitude,
  location: location ?? _location,
);
  String? get time => _time;
  num? get latitude => _latitude;
  num? get longitude => _longitude;
  String? get location => _location;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['time'] = _time;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['location'] = _location;
    return map;
  }

}