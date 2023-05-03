class CheckActiveRideModels {
  CheckActiveRideModels({
      bool? status, 
      List<Data>? data, 
      String? token,}){
    _status = status;
    _data = data;
    _token = token;
}

  CheckActiveRideModels.fromJson(dynamic json) {
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
CheckActiveRideModels copyWith({  bool? status,
  List<Data>? data,
  String? token,
}) => CheckActiveRideModels(  status: status ?? _status,
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

class Data {
  Data({
      String? id, 
      String? userId, 
      String? driverId, 
      String? date, 
      String? fromDestination, 
      String? toDestination, 
      StartPoint? startPoint, 
      String? endPoint, 
      List<dynamic>? stops, 
      String? distance, 
      String? totalTime, 
      num? rideStartOtp, 
      String? vehicleId, 
      String? driverName, 
      num? pickupPointLat, 
      num? pickupPointLng, 
      String? pickupPointMunicipality, 
      String? pickupPointArea, 
      String? pickupPointPincode,
    double? endPointLat,
    double? endPointLng,
      String? endPointMunicipality, 
      String? endPointArea, 
      String? endPointPincode, 
      String? startTime, 
      String? endTime, 
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
    double? rating,
  }){
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
    _pickupPointLat = pickupPointLat;
    _pickupPointLng = pickupPointLng;
    _pickupPointMunicipality = pickupPointMunicipality;
    _pickupPointArea = pickupPointArea;
    _pickupPointPincode = pickupPointPincode;
    _endPointLat = endPointLat;
    _endPointLng = endPointLng;
    _endPointMunicipality = endPointMunicipality;
    _endPointArea = endPointArea;
    _endPointPincode = endPointPincode;
    _startTime = startTime;
    _endTime = endTime;
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
    _rating = rating;
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
    _rideStartOtp = json['ride_start_otp'];
    _vehicleId = json['vehicle_id'];
    _driverName = json['driver_name'];
    _pickupPointLat = json['pickup_point_lat'];
    _pickupPointLng = json['pickup_point_lng'];
    _pickupPointMunicipality = json['pickup_point_municipality'];
    _pickupPointArea = json['pickup_point_area'];
    _pickupPointPincode = json['pickup_point_pincode'];
    _endPointLat = json['end_point_lat'];
    _endPointLng = json['end_point_lng'];
    _endPointMunicipality = json['end_point_municipality'];
    _endPointArea = json['end_point_area'];
    _endPointPincode = json['end_point_pincode'];
    _startTime = json['start_time'];
    _endTime = json['end_time'];
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
    _rating = json['rating'];
  }
  String? _id;
  String? _userId;
  String? _driverId;
  String? _date;
  String? _fromDestination;
  String? _toDestination;
  StartPoint? _startPoint;
  String? _endPoint;
  List<dynamic>? _stops;
  String? _distance;
  String? _totalTime;
  num? _rideStartOtp;
  String? _vehicleId;
  String? _driverName;
  num? _pickupPointLat;
  num? _pickupPointLng;
  String? _pickupPointMunicipality;
  String? _pickupPointArea;
  String? _pickupPointPincode;
  double? _endPointLat;
  double? _endPointLng;
  String? _endPointMunicipality;
  String? _endPointArea;
  String? _endPointPincode;
  String? _startTime;
  String? _endTime;
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
  double? _rating;
Data copyWith({  String? id,
  String? userId,
  String? driverId,
  String? date,
  String? fromDestination,
  String? toDestination,
  StartPoint? startPoint,
  String? endPoint,
  List<dynamic>? stops,
  String? distance,
  String? totalTime,
  num? rideStartOtp,
  String? vehicleId,
  String? driverName,
  num? pickupPointLat,
  num? pickupPointLng,
  String? pickupPointMunicipality,
  String? pickupPointArea,
  String? pickupPointPincode,
  double? endPointLat,
  double? endPointLng,
  String? endPointMunicipality,
  String? endPointArea,
  String? endPointPincode,
  String? startTime,
  String? endTime,
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
  double? rating,
}) => Data(  id: id ?? _id,
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
  pickupPointLat: pickupPointLat ?? _pickupPointLat,
  pickupPointLng: pickupPointLng ?? _pickupPointLng,
  pickupPointMunicipality: pickupPointMunicipality ?? _pickupPointMunicipality,
  pickupPointArea: pickupPointArea ?? _pickupPointArea,
  pickupPointPincode: pickupPointPincode ?? _pickupPointPincode,
  endPointLat: endPointLat ?? _endPointLat,
  endPointLng: endPointLng ?? _endPointLng,
  endPointMunicipality: endPointMunicipality ?? _endPointMunicipality,
  endPointArea: endPointArea ?? _endPointArea,
  endPointPincode: endPointPincode ?? _endPointPincode,
  startTime: startTime ?? _startTime,
  endTime: endTime ?? _endTime,
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
  rating: rating ?? _rating,
);
  String? get id => _id;
  String? get userId => _userId;
  String? get driverId => _driverId;
  String? get date => _date;
  String? get fromDestination => _fromDestination;
  String? get toDestination => _toDestination;
  StartPoint? get startPoint => _startPoint;
  String? get endPoint => _endPoint;
  List<dynamic>? get stops => _stops;
  String? get distance => _distance;
  String? get totalTime => _totalTime;
  num? get rideStartOtp => _rideStartOtp;
  String? get vehicleId => _vehicleId;
  String? get driverName => _driverName;
  num? get pickupPointLat => _pickupPointLat;
  num? get pickupPointLng => _pickupPointLng;
  String? get pickupPointMunicipality => _pickupPointMunicipality;
  String? get pickupPointArea => _pickupPointArea;
  String? get pickupPointPincode => _pickupPointPincode;
  double? get endPointLat => _endPointLat;
  double? get endPointLng => _endPointLng;
  String? get endPointMunicipality => _endPointMunicipality;
  String? get endPointArea => _endPointArea;
  String? get endPointPincode => _endPointPincode;
  String? get startTime => _startTime;
  String? get endTime => _endTime;
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
  double? get rating => _rating;

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
    map['pickup_point_lat'] = _pickupPointLat;
    map['pickup_point_lng'] = _pickupPointLng;
    map['pickup_point_municipality'] = _pickupPointMunicipality;
    map['pickup_point_area'] = _pickupPointArea;
    map['pickup_point_pincode'] = _pickupPointPincode;
    map['end_point_lat'] = _endPointLat;
    map['end_point_lng'] = _endPointLng;
    map['end_point_municipality'] = _endPointMunicipality;
    map['end_point_area'] = _endPointArea;
    map['end_point_pincode'] = _endPointPincode;
    map['start_time'] = _startTime;
    map['end_time'] = _endTime;
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
    map['rating'] = _rating;
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