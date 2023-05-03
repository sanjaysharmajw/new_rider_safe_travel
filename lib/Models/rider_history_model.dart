import 'dart:convert';
/// status : true
/// data : [{"_id":"6411b1016b2fc6093a155b68","user_id":"6405e5bd7cd52d6861853c0a","driver_id":"63b94ebee2424c83be29abe9","date":"2023-03-15","from_destination":null,"to_destination":null,"distance":null,"total_time":null,"created_at":"2023-03-15T11:50:25.479Z","ride_start_otp":9395,"verify_start_otp":"","ride_id":"6411b1016b2fc6093a155b68","vehicle_id":"6386fbe9a2d80074cbcfb905","ride_status":"Complete","user_name":"sanjay sharma","driving_licence_number":"MH4920220875555","user_mobile_number":"9167410084","user_email_id":"sanjay@gmail.com","user_photo":"https://travelsafe-docs.s3.ap-south-1.amazonaws.com/670860Screenshot_20221230-161618_WhatsApp.jpg","driver_name":"Maithili Kamble","owner_name":"Prathamesh Tamboli","driver_mobile_number":"8355831970","driver_email_id":"maithili@gmail.com","driver_photo":"https://travelsafe-docs.s3.ap-south-1.amazonaws.com/9872344f61cca-ce9b-41d1-9d8a-33f228f4ff898724766188882598728.jpg","owner_mobile_number":"8286566801","owner_email_id":"prathamesh11092@gmail.com","owner_photo":"http://wallsdesk.com/wp-content/uploads/2016/11/Google-Images.jpg","vehicle_registrationNumber":"12345","vehicle_rcNumber":"123456","vehicle_make":"2017","vehicle_model":"Dzire","vehicle_fuelType":"Petrol","vehicle_makeYear":"2017","vehicle_fitnessValidity":"30-12-2023","vehicle_pucValidity":"30-12-2023","vehicle_insuranceValidity":"04-12-2027","vehicle_photo":"https://wallpapercave.com/wp/wp6205942.jpg"},null]

RiderHistoryModel riderHistoryModelFromJson(String str) => RiderHistoryModel.fromJson(json.decode(str));
String riderHistoryModelToJson(RiderHistoryModel data) => json.encode(data.toJson());
class RiderHistoryModel {
  RiderHistoryModel({
      bool? status, 
      List<RiderHistoryData>? data,}){
    _status = status;
    _data = data;
}

  RiderHistoryModel.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(RiderHistoryData.fromJson(v));
      });
    }
  }
  bool? _status;
  List<RiderHistoryData>? _data;
RiderHistoryModel copyWith({  bool? status,
  List<RiderHistoryData>? data,
}) => RiderHistoryModel(  status: status ?? _status,
  data: data ?? _data,
);
  bool? get status => _status;
  List<RiderHistoryData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "6411b1016b2fc6093a155b68"
/// user_id : "6405e5bd7cd52d6861853c0a"
/// driver_id : "63b94ebee2424c83be29abe9"
/// date : "2023-03-15"
/// from_destination : null
/// to_destination : null
/// distance : null
/// total_time : null
/// created_at : "2023-03-15T11:50:25.479Z"
/// ride_start_otp : 9395
/// verify_start_otp : ""
/// ride_id : "6411b1016b2fc6093a155b68"
/// vehicle_id : "6386fbe9a2d80074cbcfb905"
/// ride_status : "Complete"
/// user_name : "sanjay sharma"
/// driving_licence_number : "MH4920220875555"
/// user_mobile_number : "9167410084"
/// user_email_id : "sanjay@gmail.com"
/// user_photo : "https://travelsafe-docs.s3.ap-south-1.amazonaws.com/670860Screenshot_20221230-161618_WhatsApp.jpg"
/// driver_name : "Maithili Kamble"
/// owner_name : "Prathamesh Tamboli"
/// driver_mobile_number : "8355831970"
/// driver_email_id : "maithili@gmail.com"
/// driver_photo : "https://travelsafe-docs.s3.ap-south-1.amazonaws.com/9872344f61cca-ce9b-41d1-9d8a-33f228f4ff898724766188882598728.jpg"
/// owner_mobile_number : "8286566801"
/// owner_email_id : "prathamesh11092@gmail.com"
/// owner_photo : "http://wallsdesk.com/wp-content/uploads/2016/11/Google-Images.jpg"
/// vehicle_registrationNumber : "12345"
/// vehicle_rcNumber : "123456"
/// vehicle_make : "2017"
/// vehicle_model : "Dzire"
/// vehicle_fuelType : "Petrol"
/// vehicle_makeYear : "2017"
/// vehicle_fitnessValidity : "30-12-2023"
/// vehicle_pucValidity : "30-12-2023"
/// vehicle_insuranceValidity : "04-12-2027"
/// vehicle_photo : "https://wallpapercave.com/wp/wp6205942.jpg"

RiderHistoryData dataFromJson(String str) => RiderHistoryData.fromJson(json.decode(str));
String dataToJson(RiderHistoryData data) => json.encode(data.toJson());
class RiderHistoryData {
  RiderHistoryData({
      String? id, 
      String? userId, 
      String? driverId, 
      String? date, 
      dynamic fromDestination, 
      dynamic toDestination, 
      dynamic distance, 
      dynamic totalTime, 
      String? createdAt, 
      num? rideStartOtp, 
      String? verifyStartOtp, 
      String? rideId, 
      String? vehicleId, 
      String? rideStatus, 
      String? userName, 
      String? drivingLicenceNumber, 
      String? userMobileNumber, 
      String? userEmailId, 
      String? userPhoto, 
      String? driverName, 
      String? ownerName, 
      String? driverMobileNumber, 
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
    String? groupName,

  }){
    _id = id;
    _userId = userId;
    _driverId = driverId;
    _date = date;
    _fromDestination = fromDestination;
    _toDestination = toDestination;
    _distance = distance;
    _totalTime = totalTime;
    _createdAt = createdAt;
    _rideStartOtp = rideStartOtp;
    _verifyStartOtp = verifyStartOtp;
    _rideId = rideId;
    _vehicleId = vehicleId;
    _rideStatus = rideStatus;
    _userName = userName;
    _drivingLicenceNumber = drivingLicenceNumber;
    _userMobileNumber = userMobileNumber;
    _userEmailId = userEmailId;
    _userPhoto = userPhoto;
    _driverName = driverName;
    _ownerName = ownerName;
    _driverMobileNumber = driverMobileNumber;
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
    _groupName = groupName;
}

  RiderHistoryData.fromJson(dynamic json) {
    _id = json['_id'];
    _userId = json['user_id'];
    _driverId = json['driver_id'];
    _date = json['date'];
    _fromDestination = json['from_destination'];
    _toDestination = json['to_destination'];
    _distance = json['distance'];
    _totalTime = json['total_time'];
    _createdAt = json['created_at'];
    _rideStartOtp = json['ride_start_otp'];
    _verifyStartOtp = json['verify_start_otp'];
    _rideId = json['ride_id'];
    _vehicleId = json['vehicle_id'];
    _rideStatus = json['ride_status'];
    _userName = json['user_name'];
    _drivingLicenceNumber = json['driving_licence_number'];
    _userMobileNumber = json['user_mobile_number'];
    _userEmailId = json['user_email_id'];
    _userPhoto = json['user_photo'];
    _driverName = json['driver_name'];
    _ownerName = json['owner_name'];
    _driverMobileNumber = json['driver_mobile_number'];
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
    _groupName = json['group_name'];
  }
  String? _id;
  String? _userId;
  String? _driverId;
  String? _date;
  dynamic _fromDestination;
  dynamic _toDestination;
  dynamic _distance;
  dynamic _totalTime;
  String? _createdAt;
  num? _rideStartOtp;
  String? _verifyStartOtp;
  String? _rideId;
  String? _vehicleId;
  String? _rideStatus;
  String? _userName;
  String? _drivingLicenceNumber;
  String? _userMobileNumber;
  String? _userEmailId;
  String? _userPhoto;
  String? _driverName;
  String? _ownerName;
  String? _driverMobileNumber;
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
  String? _groupName;
  RiderHistoryData copyWith({  String? id,
  String? userId,
  String? driverId,
  String? date,
  dynamic fromDestination,
  dynamic toDestination,
  dynamic distance,
  dynamic totalTime,
  String? createdAt,
  num? rideStartOtp,
  String? verifyStartOtp,
  String? rideId,
  String? vehicleId,
  String? rideStatus,
  String? userName,
  String? drivingLicenceNumber,
  String? userMobileNumber,
  String? userEmailId,
  String? userPhoto,
  String? driverName,
  String? ownerName,
  String? driverMobileNumber,
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
    String? groupName,
}) => RiderHistoryData(  id: id ?? _id,
  userId: userId ?? _userId,
  driverId: driverId ?? _driverId,
  date: date ?? _date,
  fromDestination: fromDestination ?? _fromDestination,
  toDestination: toDestination ?? _toDestination,
  distance: distance ?? _distance,
  totalTime: totalTime ?? _totalTime,
  createdAt: createdAt ?? _createdAt,
  rideStartOtp: rideStartOtp ?? _rideStartOtp,
  verifyStartOtp: verifyStartOtp ?? _verifyStartOtp,
  rideId: rideId ?? _rideId,
  vehicleId: vehicleId ?? _vehicleId,
  rideStatus: rideStatus ?? _rideStatus,
  userName: userName ?? _userName,
  drivingLicenceNumber: drivingLicenceNumber ?? _drivingLicenceNumber,
  userMobileNumber: userMobileNumber ?? _userMobileNumber,
  userEmailId: userEmailId ?? _userEmailId,
  userPhoto: userPhoto ?? _userPhoto,
  driverName: driverName ?? _driverName,
  ownerName: ownerName ?? _ownerName,
  driverMobileNumber: driverMobileNumber ?? _driverMobileNumber,
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
    groupName: groupName ?? _groupName,
);
  String? get id => _id;
  String? get userId => _userId;
  String? get driverId => _driverId;
  String? get date => _date;
  dynamic get fromDestination => _fromDestination;
  dynamic get toDestination => _toDestination;
  dynamic get distance => _distance;
  dynamic get totalTime => _totalTime;
  String? get createdAt => _createdAt;
  num? get rideStartOtp => _rideStartOtp;
  String? get verifyStartOtp => _verifyStartOtp;
  String? get rideId => _rideId;
  String? get vehicleId => _vehicleId;
  String? get rideStatus => _rideStatus;
  String? get userName => _userName;
  String? get drivingLicenceNumber => _drivingLicenceNumber;
  String? get userMobileNumber => _userMobileNumber;
  String? get userEmailId => _userEmailId;
  String? get userPhoto => _userPhoto;
  String? get driverName => _driverName;
  String? get ownerName => _ownerName;
  String? get driverMobileNumber => _driverMobileNumber;
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
  String? get groupName => _groupName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['user_id'] = _userId;
    map['driver_id'] = _driverId;
    map['date'] = _date;
    map['from_destination'] = _fromDestination;
    map['to_destination'] = _toDestination;
    map['distance'] = _distance;
    map['total_time'] = _totalTime;
    map['created_at'] = _createdAt;
    map['ride_start_otp'] = _rideStartOtp;
    map['verify_start_otp'] = _verifyStartOtp;
    map['ride_id'] = _rideId;
    map['vehicle_id'] = _vehicleId;
    map['ride_status'] = _rideStatus;
    map['user_name'] = _userName;
    map['driving_licence_number'] = _drivingLicenceNumber;
    map['user_mobile_number'] = _userMobileNumber;
    map['user_email_id'] = _userEmailId;
    map['user_photo'] = _userPhoto;
    map['driver_name'] = _driverName;
    map['owner_name'] = _ownerName;
    map['driver_mobile_number'] = _driverMobileNumber;
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
    map['group_name'] = _groupName;
    return map;
  }

}