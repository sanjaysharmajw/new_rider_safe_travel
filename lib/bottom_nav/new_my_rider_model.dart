/// status : true
/// data : [{"_id":"63be87c129b7f4822c315368","user_id":"63b56f764333591b3115b5bc","driver_id":"63b94ebee2424c83be29abe9","date":"2023-01-11","from_destination":null,"to_destination":null,"start_point":{"time":"1673430977068","latitude":null,"longitude":null,"location":""},"end_point":null,"stops":[],"distance":null,"total_time":null,"vehicle_id":"6386fbe9a2d80074cbcfb905","ride_status":"Active","driver_name":"Maithili Kamble","driver_mobile_number":"8355831970","driving_licence_number":"MH4920220875555","driver_email_id":"maithili@gmail.com","driver_photo":"https://travelsafe-docs.s3.ap-south-1.amazonaws.com/9872344f61cca-ce9b-41d1-9d8a-33f228f4ff898724766188882598728.jpg","vehicle_registrationNumber":"12345","vehicle_rcNumber":"123456","vehicle_make":"2017","vehicle_model":"Dzire","vehicle_fuelType":"Petrol","vehicle_makeYear":"2017","vehicle_fitnessValidity":"2024-03-11T00:00:00.000Z","vehicle_pucValidity":"2024-03-11T00:00:00.000Z","vehicle_insuranceValidity":"2024-03-11T00:00:00.000Z","vehicle_photo":"https://wallpapercave.com/wp/wp6205942.jpg"}]

class NewMyRiderModel {
  NewMyRiderModel({
      bool? status, 
      List<DataMyRider>? data,}){
    _status = status;
    _data = data;
}

  NewMyRiderModel.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(DataMyRider.fromJson(v));
      });
    }
  }
  bool? _status;
  List<DataMyRider>? _data;
NewMyRiderModel copyWith({  bool? status,
  List<DataMyRider>? data,
}) => NewMyRiderModel(  status: status ?? _status,
  data: data ?? _data,
);
  bool? get status => _status;
  List<DataMyRider>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "63be87c129b7f4822c315368"
/// user_id : "63b56f764333591b3115b5bc"
/// driver_id : "63b94ebee2424c83be29abe9"
/// date : "2023-01-11"
/// from_destination : null
/// to_destination : null
/// start_point : {"time":"1673430977068","latitude":null,"longitude":null,"location":""}
/// end_point : null
/// stops : []
/// distance : null
/// total_time : null
/// vehicle_id : "6386fbe9a2d80074cbcfb905"
/// ride_status : "Active"
/// driver_name : "Maithili Kamble"
/// driver_mobile_number : "8355831970"
/// driving_licence_number : "MH4920220875555"
/// driver_email_id : "maithili@gmail.com"
/// driver_photo : "https://travelsafe-docs.s3.ap-south-1.amazonaws.com/9872344f61cca-ce9b-41d1-9d8a-33f228f4ff898724766188882598728.jpg"
/// vehicle_registrationNumber : "12345"
/// vehicle_rcNumber : "123456"
/// vehicle_make : "2017"
/// vehicle_model : "Dzire"
/// vehicle_fuelType : "Petrol"
/// vehicle_makeYear : "2017"
/// vehicle_fitnessValidity : "2024-03-11T00:00:00.000Z"
/// vehicle_pucValidity : "2024-03-11T00:00:00.000Z"
/// vehicle_insuranceValidity : "2024-03-11T00:00:00.000Z"
/// vehicle_photo : "https://wallpapercave.com/wp/wp6205942.jpg"

class DataMyRider {
  DataMyRider({
      String? id, 
      String? userId, 
      String? driverId, 
      String? date, 
      dynamic fromDestination, 
      dynamic toDestination, 
      StartPoint? startPoint, 
      dynamic endPoint, 
      List<dynamic>? stops, 
      dynamic distance, 
      dynamic totalTime, 
      String? vehicleId, 
      String? rideStatus, 
      String? driverName, 
      String? driverMobileNumber, 
      String? drivingLicenceNumber, 
      String? driverEmailId, 
      String? driverPhoto, 
      String? vehicleRegistrationNumber, 
      String? vehicleRcNumber, 
      String? vehicleMake, 
      String? vehicleModel, 
      String? vehicleFuelType, 
      String? vehicleMakeYear, 
      String? vehicleFitnessValidity, 
      String? vehiclePucValidity, 
      String? vehicleInsuranceValidity, 
      String? vehiclePhoto,}){
    _id = id;
    _userId = userId;
    _driverId = driverId;
    _date = date;
    _fromDestination = fromDestination;
    _toDestination = toDestination;
    _startPoint = startPoint;
    _endPoint = endPoint;
    _stops = stops;
    _distance = distance;
    _totalTime = totalTime;
    _vehicleId = vehicleId;
    _rideStatus = rideStatus;
    _driverName = driverName;
    _driverMobileNumber = driverMobileNumber;
    _drivingLicenceNumber = drivingLicenceNumber;
    _driverEmailId = driverEmailId;
    _driverPhoto = driverPhoto;
    _vehicleRegistrationNumber = vehicleRegistrationNumber;
    _vehicleRcNumber = vehicleRcNumber;
    _vehicleMake = vehicleMake;
    _vehicleModel = vehicleModel;
    _vehicleFuelType = vehicleFuelType;
    _vehicleMakeYear = vehicleMakeYear;
    _vehicleFitnessValidity = vehicleFitnessValidity;
    _vehiclePucValidity = vehiclePucValidity;
    _vehicleInsuranceValidity = vehicleInsuranceValidity;
    _vehiclePhoto = vehiclePhoto;
}

  DataMyRider.fromJson(dynamic json) {
    _id = json['_id'];
    _userId = json['user_id'];
    _driverId = json['driver_id'];
    _date = json['date'];
    _fromDestination = json['from_destination'];
    _toDestination = json['to_destination'];
    _startPoint = json['start_point'] != null ? StartPoint.fromJson(json['start_point']) : null;
    _endPoint = json['end_point'];
    _distance = json['distance'];
    _totalTime = json['total_time'];
    _vehicleId = json['vehicle_id'];
    _rideStatus = json['ride_status'];
    _driverName = json['driver_name'];
    _driverMobileNumber = json['driver_mobile_number'];
    _drivingLicenceNumber = json['driving_licence_number'];
    _driverEmailId = json['driver_email_id'];
    _driverPhoto = json['driver_photo'];
    _vehicleRegistrationNumber = json['vehicle_registrationNumber'];
    _vehicleRcNumber = json['vehicle_rcNumber'];
    _vehicleMake = json['vehicle_make'];
    _vehicleModel = json['vehicle_model'];
    _vehicleFuelType = json['vehicle_fuelType'];
    _vehicleMakeYear = json['vehicle_makeYear'];
    _vehicleFitnessValidity = json['vehicle_fitnessValidity'];
    _vehiclePucValidity = json['vehicle_pucValidity'];
    _vehicleInsuranceValidity = json['vehicle_insuranceValidity'];
    _vehiclePhoto = json['vehicle_photo'];
  }
  String? _id;
  String? _userId;
  String? _driverId;
  String? _date;
  dynamic _fromDestination;
  dynamic _toDestination;
  StartPoint? _startPoint;
  dynamic _endPoint;
  List<dynamic>? _stops;
  dynamic _distance;
  dynamic _totalTime;
  String? _vehicleId;
  String? _rideStatus;
  String? _driverName;
  String? _driverMobileNumber;
  String? _drivingLicenceNumber;
  String? _driverEmailId;
  String? _driverPhoto;
  String? _vehicleRegistrationNumber;
  String? _vehicleRcNumber;
  String? _vehicleMake;
  String? _vehicleModel;
  String? _vehicleFuelType;
  String? _vehicleMakeYear;
  String? _vehicleFitnessValidity;
  String? _vehiclePucValidity;
  String? _vehicleInsuranceValidity;
  String? _vehiclePhoto;
  DataMyRider copyWith({  String? id,
  String? userId,
  String? driverId,
  String? date,
  dynamic fromDestination,
  dynamic toDestination,
  StartPoint? startPoint,
  dynamic endPoint,
  List<dynamic>? stops,
  dynamic distance,
  dynamic totalTime,
  String? vehicleId,
  String? rideStatus,
  String? driverName,
  String? driverMobileNumber,
  String? drivingLicenceNumber,
  String? driverEmailId,
  String? driverPhoto,
  String? vehicleRegistrationNumber,
  String? vehicleRcNumber,
  String? vehicleMake,
  String? vehicleModel,
  String? vehicleFuelType,
  String? vehicleMakeYear,
  String? vehicleFitnessValidity,
  String? vehiclePucValidity,
  String? vehicleInsuranceValidity,
  String? vehiclePhoto,
}) => DataMyRider(  id: id ?? _id,
  userId: userId ?? _userId,
  driverId: driverId ?? _driverId,
  date: date ?? _date,
  fromDestination: fromDestination ?? _fromDestination,
  toDestination: toDestination ?? _toDestination,
  startPoint: startPoint ?? _startPoint,
  endPoint: endPoint ?? _endPoint,
  stops: stops ?? _stops,
  distance: distance ?? _distance,
  totalTime: totalTime ?? _totalTime,
  vehicleId: vehicleId ?? _vehicleId,
  rideStatus: rideStatus ?? _rideStatus,
  driverName: driverName ?? _driverName,
  driverMobileNumber: driverMobileNumber ?? _driverMobileNumber,
  drivingLicenceNumber: drivingLicenceNumber ?? _drivingLicenceNumber,
  driverEmailId: driverEmailId ?? _driverEmailId,
  driverPhoto: driverPhoto ?? _driverPhoto,
  vehicleRegistrationNumber: vehicleRegistrationNumber ?? _vehicleRegistrationNumber,
  vehicleRcNumber: vehicleRcNumber ?? _vehicleRcNumber,
  vehicleMake: vehicleMake ?? _vehicleMake,
  vehicleModel: vehicleModel ?? _vehicleModel,
  vehicleFuelType: vehicleFuelType ?? _vehicleFuelType,
  vehicleMakeYear: vehicleMakeYear ?? _vehicleMakeYear,
  vehicleFitnessValidity: vehicleFitnessValidity ?? _vehicleFitnessValidity,
  vehiclePucValidity: vehiclePucValidity ?? _vehiclePucValidity,
  vehicleInsuranceValidity: vehicleInsuranceValidity ?? _vehicleInsuranceValidity,
  vehiclePhoto: vehiclePhoto ?? _vehiclePhoto,
);
  String? get id => _id;
  String? get userId => _userId;
  String? get driverId => _driverId;
  String? get date => _date;
  dynamic get fromDestination => _fromDestination;
  dynamic get toDestination => _toDestination;
  StartPoint? get startPoint => _startPoint;
  dynamic get endPoint => _endPoint;
  List<dynamic>? get stops => _stops;
  dynamic get distance => _distance;
  dynamic get totalTime => _totalTime;
  String? get vehicleId => _vehicleId;
  String? get rideStatus => _rideStatus;
  String? get driverName => _driverName;
  String? get driverMobileNumber => _driverMobileNumber;
  String? get drivingLicenceNumber => _drivingLicenceNumber;
  String? get driverEmailId => _driverEmailId;
  String? get driverPhoto => _driverPhoto;
  String? get vehicleRegistrationNumber => _vehicleRegistrationNumber;
  String? get vehicleRcNumber => _vehicleRcNumber;
  String? get vehicleMake => _vehicleMake;
  String? get vehicleModel => _vehicleModel;
  String? get vehicleFuelType => _vehicleFuelType;
  String? get vehicleMakeYear => _vehicleMakeYear;
  String? get vehicleFitnessValidity => _vehicleFitnessValidity;
  String? get vehiclePucValidity => _vehiclePucValidity;
  String? get vehicleInsuranceValidity => _vehicleInsuranceValidity;
  String? get vehiclePhoto => _vehiclePhoto;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['user_id'] = _userId;
    map['driver_id'] = _driverId;
    map['date'] = _date;
    map['from_destination'] = _fromDestination;
    map['to_destination'] = _toDestination;
    if (_startPoint != null) {
      map['start_point'] = _startPoint?.toJson();
    }
    map['end_point'] = _endPoint;
    if (_stops != null) {
      map['stops'] = _stops?.map((v) => v.toJson()).toList();
    }
    map['distance'] = _distance;
    map['total_time'] = _totalTime;
    map['vehicle_id'] = _vehicleId;
    map['ride_status'] = _rideStatus;
    map['driver_name'] = _driverName;
    map['driver_mobile_number'] = _driverMobileNumber;
    map['driving_licence_number'] = _drivingLicenceNumber;
    map['driver_email_id'] = _driverEmailId;
    map['driver_photo'] = _driverPhoto;
    map['vehicle_registrationNumber'] = _vehicleRegistrationNumber;
    map['vehicle_rcNumber'] = _vehicleRcNumber;
    map['vehicle_make'] = _vehicleMake;
    map['vehicle_model'] = _vehicleModel;
    map['vehicle_fuelType'] = _vehicleFuelType;
    map['vehicle_makeYear'] = _vehicleMakeYear;
    map['vehicle_fitnessValidity'] = _vehicleFitnessValidity;
    map['vehicle_pucValidity'] = _vehiclePucValidity;
    map['vehicle_insuranceValidity'] = _vehicleInsuranceValidity;
    map['vehicle_photo'] = _vehiclePhoto;
    return map;
  }

}

/// time : "1673430977068"
/// latitude : null
/// longitude : null
/// location : ""

class StartPoint {
  StartPoint({
      String? time, 
      dynamic latitude, 
      dynamic longitude, 
      String? location,}){
    _time = time;
    _latitude = latitude;
    _longitude = longitude;
    _location = location;
}

  StartPoint.fromJson(dynamic json) {
    _time = json['time'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _location = json['location'];
  }
  String? _time;
  dynamic _latitude;
  dynamic _longitude;
  String? _location;
StartPoint copyWith({  String? time,
  dynamic latitude,
  dynamic longitude,
  String? location,
}) => StartPoint(  time: time ?? _time,
  latitude: latitude ?? _latitude,
  longitude: longitude ?? _longitude,
  location: location ?? _location,
);
  String? get time => _time;
  dynamic get latitude => _latitude;
  dynamic get longitude => _longitude;
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