class StartRideDetails {
  StartRideDetails({
      bool? status, 
      String? message, 
      String? data, 
      num? rideStartOtp, 
      String? sockettoken, 
      List<Ridedetails>? ridedetails,}){
    _status = status;
    _message = message;
    _data = data;
    _rideStartOtp = rideStartOtp;
    _sockettoken = sockettoken;
    _ridedetails = ridedetails;
}

  StartRideDetails.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'];
    _rideStartOtp = json['ride_start_otp'];
    _sockettoken = json['sockettoken'];
    if (json['ridedetails'] != null) {
      _ridedetails = [];
      json['ridedetails'].forEach((v) {
        _ridedetails?.add(Ridedetails.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  String? _data;
  num? _rideStartOtp;
  String? _sockettoken;
  List<Ridedetails>? _ridedetails;
StartRideDetails copyWith({  bool? status,
  String? message,
  String? data,
  num? rideStartOtp,
  String? sockettoken,
  List<Ridedetails>? ridedetails,
}) => StartRideDetails(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
  rideStartOtp: rideStartOtp ?? _rideStartOtp,
  sockettoken: sockettoken ?? _sockettoken,
  ridedetails: ridedetails ?? _ridedetails,
);
  bool? get status => _status;
  String? get message => _message;
  String? get data => _data;
  num? get rideStartOtp => _rideStartOtp;
  String? get sockettoken => _sockettoken;
  List<Ridedetails>? get ridedetails => _ridedetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['data'] = _data;
    map['ride_start_otp'] = _rideStartOtp;
    map['sockettoken'] = _sockettoken;
    if (_ridedetails != null) {
      map['ridedetails'] = _ridedetails?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Ridedetails {
  Ridedetails({
      String? id, 
      String? userId, 
      String? driverId, 
      String? date, 
      String? fromDestination, 
      String? toDestination, 
      StartPoint? startPoint, 
      dynamic endPoint, 
      List<dynamic>? stops, 
      dynamic distance, 
      dynamic totalTime, 
      num? rideStartOtp, 
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
    _stops = stops;
    _distance = distance;
    _totalTime = totalTime;
    _rideStartOtp = rideStartOtp;
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

  Ridedetails.fromJson(dynamic json) {
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
    _rideStartOtp = json['ride_start_otp'];
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
  String? _fromDestination;
  String? _toDestination;
  StartPoint? _startPoint;
  dynamic _endPoint;
  List<dynamic>? _stops;
  dynamic _distance;
  dynamic _totalTime;
  num? _rideStartOtp;
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
Ridedetails copyWith({  String? id,
  String? userId,
  String? driverId,
  String? date,
  String? fromDestination,
  String? toDestination,
  StartPoint? startPoint,
  dynamic endPoint,
  List<dynamic>? stops,
  dynamic distance,
  dynamic totalTime,
  num? rideStartOtp,
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
}) => Ridedetails(  id: id ?? _id,
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
  rideStartOtp: rideStartOtp ?? _rideStartOtp,
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
  String? get fromDestination => _fromDestination;
  String? get toDestination => _toDestination;
  StartPoint? get startPoint => _startPoint;
  dynamic get endPoint => _endPoint;
  List<dynamic>? get stops => _stops;
  dynamic get distance => _distance;
  dynamic get totalTime => _totalTime;
  num? get rideStartOtp => _rideStartOtp;
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
    if (_stops != null) {
      map['stops'] = _stops?.map((v) => v.toJson()).toList();
    }
    map['distance'] = _distance;
    map['total_time'] = _totalTime;
    map['ride_start_otp'] = _rideStartOtp;
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