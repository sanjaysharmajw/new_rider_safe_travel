/// status : true
/// data : [{"_id":"63b678340b91e4427852b05c","user_id":"63a9cc6f4d9452ca371706dc","driver_id":"63a2f7b90518372468884ae5","date":"2023-01-05","from_destination":null,"to_destination":null,"start_point":{"time":"1672902707766","latitude":19.0642024,"longitude":72.9803745,"location":""},"end_point":null,"stops":[],"distance":null,"total_time":null,"vehicle_id":"6386fbe9a2d80074cbcfb905","driver_name":"maithili kamble","owner_name":"Prathamesh b Tamboli","driver_mobile_number":"8355831970","driving_licence_number":"","driver_email_id":"maithili@gmail.com","driver_photo":"https://travelsafe-docs.s3.ap-south-1.amazonaws.com/43335646590db1-460d-42e3-84f0-1bdc4cf2e6f1308817878612008312.jpg","owner_mobile_number":"8286566801","owner_email_id":"prathamesh11092@gmail.com","owner_photo":"https://travelsafe-docs.s3.ap-south-1.amazonaws.com/890472image_picker4858478591242962850.jpg","vehicle_registrationNumber":"12345","vehicle_rcNumber":"123456","vehicle_make":"2017","vehicle_model":"Dzire","vehicle_fuelType":"Petrol","vehicle_makeYear":"2017","vehicle_fitnessValidity":"2024-03-11T00:00:00.000Z","vehicle_pucValidity":"2024-03-11T00:00:00.000Z","vehicle_insuranceValidity":"2024-03-11T00:00:00.000Z","vehicle_photo":"https://wallpapercave.com/wp/wp6205942.jpg"}]
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiNjM4ODc2MjFiYjkzMTBmNGM3MGVlMGNiIiwicm9vbU5hbWUiOiI2M2I2NzgzNDBiOTFlNDQyNzg1MmIwNWMiLCJpYXQiOjE2NzI5MTY0ODB9.K9XC18frWPChKSVe_gO2Ec7CsRpBRUbklzscP462s5Y"

class CheckActiveUserRide {
  CheckActiveUserRide({
      bool? status, 
      List<Data>? data, 
      String? token,}){
    _status = status;
    _data = data;
    _token = token;
}

  CheckActiveUserRide.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _token = json['token'];
  }
  bool? _status;
  List<Data>? _data;
  String? _token;
CheckActiveUserRide copyWith({  bool? status,
  List<Data>? data,
  String? token,
}) => CheckActiveUserRide(  status: status ?? _status,
  data: data ?? _data,
  token: token ?? _token,
);
  bool? get status => _status;
  List<Data>? get data => _data;
  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['token'] = _token;
    return map;
  }

}

/// _id : "63b678340b91e4427852b05c"
/// user_id : "63a9cc6f4d9452ca371706dc"
/// driver_id : "63a2f7b90518372468884ae5"
/// date : "2023-01-05"
/// from_destination : null
/// to_destination : null
/// start_point : {"time":"1672902707766","latitude":19.0642024,"longitude":72.9803745,"location":""}
/// end_point : null
/// stops : []
/// distance : null
/// total_time : null
/// vehicle_id : "6386fbe9a2d80074cbcfb905"
/// driver_name : "maithili kamble"
/// owner_name : "Prathamesh b Tamboli"
/// driver_mobile_number : "8355831970"
/// driving_licence_number : ""
/// driver_email_id : "maithili@gmail.com"
/// driver_photo : "https://travelsafe-docs.s3.ap-south-1.amazonaws.com/43335646590db1-460d-42e3-84f0-1bdc4cf2e6f1308817878612008312.jpg"
/// owner_mobile_number : "8286566801"
/// owner_email_id : "prathamesh11092@gmail.com"
/// owner_photo : "https://travelsafe-docs.s3.ap-south-1.amazonaws.com/890472image_picker4858478591242962850.jpg"
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

class Data {
  Data({
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
      String? driverName, 
      String? ownerName, 
      String? driverMobileNumber, 
      String? drivingLicenceNumber, 
      String? driverEmailId, 
      String? driverPhoto, 
      String? ownerMobileNumber, 
      String? ownerEmailId, 
      String? ownerPhoto, 
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
    _distance = distance;
    _totalTime = totalTime;
    _vehicleId = vehicleId;
    _driverName = driverName;
    _ownerName = ownerName;
    _driverMobileNumber = driverMobileNumber;
    _drivingLicenceNumber = drivingLicenceNumber;
    _driverEmailId = driverEmailId;
    _driverPhoto = driverPhoto;
    _ownerMobileNumber = ownerMobileNumber;
    _ownerEmailId = ownerEmailId;
    _ownerPhoto = ownerPhoto;
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

  Data.fromJson(dynamic json) {
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
    _driverName = json['driver_name'];
    _ownerName = json['owner_name'];
    _driverMobileNumber = json['driver_mobile_number'];
    _drivingLicenceNumber = json['driving_licence_number'];
    _driverEmailId = json['driver_email_id'];
    _driverPhoto = json['driver_photo'];
    _ownerMobileNumber = json['owner_mobile_number'];
    _ownerEmailId = json['owner_email_id'];
    _ownerPhoto = json['owner_photo'];
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
  dynamic _distance;
  dynamic _totalTime;
  String? _vehicleId;
  String? _driverName;
  String? _ownerName;
  String? _driverMobileNumber;
  String? _drivingLicenceNumber;
  String? _driverEmailId;
  String? _driverPhoto;
  String? _ownerMobileNumber;
  String? _ownerEmailId;
  String? _ownerPhoto;
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
Data copyWith({  String? id,
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
  String? driverName,
  String? ownerName,
  String? driverMobileNumber,
  String? drivingLicenceNumber,
  String? driverEmailId,
  String? driverPhoto,
  String? ownerMobileNumber,
  String? ownerEmailId,
  String? ownerPhoto,
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
}) => Data(  id: id ?? _id,
  userId: userId ?? _userId,
  driverId: driverId ?? _driverId,
  date: date ?? _date,
  fromDestination: fromDestination ?? _fromDestination,
  toDestination: toDestination ?? _toDestination,
  startPoint: startPoint ?? _startPoint,
  endPoint: endPoint ?? _endPoint,
  distance: distance ?? _distance,
  totalTime: totalTime ?? _totalTime,
  vehicleId: vehicleId ?? _vehicleId,
  driverName: driverName ?? _driverName,
  ownerName: ownerName ?? _ownerName,
  driverMobileNumber: driverMobileNumber ?? _driverMobileNumber,
  drivingLicenceNumber: drivingLicenceNumber ?? _drivingLicenceNumber,
  driverEmailId: driverEmailId ?? _driverEmailId,
  driverPhoto: driverPhoto ?? _driverPhoto,
  ownerMobileNumber: ownerMobileNumber ?? _ownerMobileNumber,
  ownerEmailId: ownerEmailId ?? _ownerEmailId,
  ownerPhoto: ownerPhoto ?? _ownerPhoto,
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
  dynamic get distance => _distance;
  dynamic get totalTime => _totalTime;
  String? get vehicleId => _vehicleId;
  String? get driverName => _driverName;
  String? get ownerName => _ownerName;
  String? get driverMobileNumber => _driverMobileNumber;
  String? get drivingLicenceNumber => _drivingLicenceNumber;
  String? get driverEmailId => _driverEmailId;
  String? get driverPhoto => _driverPhoto;
  String? get ownerMobileNumber => _ownerMobileNumber;
  String? get ownerEmailId => _ownerEmailId;
  String? get ownerPhoto => _ownerPhoto;
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
    map['distance'] = _distance;
    map['total_time'] = _totalTime;
    map['vehicle_id'] = _vehicleId;
    map['driver_name'] = _driverName;
    map['owner_name'] = _ownerName;
    map['driver_mobile_number'] = _driverMobileNumber;
    map['driving_licence_number'] = _drivingLicenceNumber;
    map['driver_email_id'] = _driverEmailId;
    map['driver_photo'] = _driverPhoto;
    map['owner_mobile_number'] = _ownerMobileNumber;
    map['owner_email_id'] = _ownerEmailId;
    map['owner_photo'] = _ownerPhoto;
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

/// time : "1672902707766"
/// latitude : 19.0642024
/// longitude : 72.9803745
/// location : ""

class StartPoint {
  StartPoint({
      String? time, 
      num? latitude, 
      num? longitude, 
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
  num? _latitude;
  num? _longitude;
  String? _location;
StartPoint copyWith({  String? time,
  num? latitude,
  num? longitude,
  String? location,
}) => StartPoint(  time: time ?? _time,
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