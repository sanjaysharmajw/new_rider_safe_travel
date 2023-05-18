class FamilyMemberRideListModel {
  FamilyMemberRideListModel({
      bool? status, 
      List<FamilyData>? data,}){
    _status = status;
    _data = data;
}

  FamilyMemberRideListModel.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(FamilyData.fromJson(v));
      });
    }
  }
  bool? _status;
  List<FamilyData>? _data;
FamilyMemberRideListModel copyWith({  bool? status,
  List<FamilyData>? data,
}) => FamilyMemberRideListModel(  status: status ?? _status,
  data: data ?? _data,
);
  bool? get status => _status;
  List<FamilyData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class FamilyData {
  FamilyData({
      String? id, 
      String? userId, 
      String? driverId, 
      String? date, 
      dynamic fromDestination, 
      dynamic toDestination, 
      dynamic distance, 
      dynamic totalTime, 
      String? rideId, 
      String? vehicleId, 
      String? groupId, 
      String? memberName, 
      String? drivingLicenceNumber, 
      String? driverName, 
      String? ownerName, 
      String? driverMobileNumber, 
      String? driverEmailId, 
      String? driverPhoto, 
      String? ownerMobileNumber, 
      String? ownerEmailId, 
      dynamic ownerPhoto, 
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
    _distance = distance;
    _totalTime = totalTime;
    _rideId = rideId;
    _vehicleId = vehicleId;
    _groupId = groupId;
    _memberName = memberName;
    _drivingLicenceNumber = drivingLicenceNumber;
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
}

  FamilyData.fromJson(dynamic json) {
    _id = json['_id'];
    _userId = json['user_id'];
    _driverId = json['driver_id'];
    _date = json['date'];
    _fromDestination = json['from_destination'];
    _toDestination = json['to_destination'];
    _distance = json['distance'];
    _totalTime = json['total_time'];
    _rideId = json['ride_id'];
    _vehicleId = json['vehicle_id'];
    _groupId = json['group_id'];
    _memberName = json['member_name'];
    _drivingLicenceNumber = json['driving_licence_number'];
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
  }
  String? _id;
  String? _userId;
  String? _driverId;
  String? _date;
  dynamic _fromDestination;
  dynamic _toDestination;
  dynamic _distance;
  dynamic _totalTime;
  String? _rideId;
  String? _vehicleId;
  String? _groupId;
  String? _memberName;
  String? _drivingLicenceNumber;
  String? _driverName;
  String? _ownerName;
  String? _driverMobileNumber;
  String? _driverEmailId;
  String? _driverPhoto;
  String? _ownerMobileNumber;
  String? _ownerEmailId;
  dynamic _ownerPhoto;
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
  FamilyData copyWith({  String? id,
  String? userId,
  String? driverId,
  String? date,
  dynamic fromDestination,
  dynamic toDestination,
  dynamic distance,
  dynamic totalTime,
  String? rideId,
  String? vehicleId,
  String? groupId,
  String? memberName,
  String? drivingLicenceNumber,
  String? driverName,
  String? ownerName,
  String? driverMobileNumber,
  String? driverEmailId,
  String? driverPhoto,
  String? ownerMobileNumber,
  String? ownerEmailId,
  dynamic ownerPhoto,
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
}) => FamilyData(  id: id ?? _id,
  userId: userId ?? _userId,
  driverId: driverId ?? _driverId,
  date: date ?? _date,
  fromDestination: fromDestination ?? _fromDestination,
  toDestination: toDestination ?? _toDestination,
  distance: distance ?? _distance,
  totalTime: totalTime ?? _totalTime,
  rideId: rideId ?? _rideId,
  vehicleId: vehicleId ?? _vehicleId,
  groupId: groupId ?? _groupId,
  memberName: memberName ?? _memberName,
  drivingLicenceNumber: drivingLicenceNumber ?? _drivingLicenceNumber,
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
);
  String? get id => _id;
  String? get userId => _userId;
  String? get driverId => _driverId;
  String? get date => _date;
  dynamic get fromDestination => _fromDestination;
  dynamic get toDestination => _toDestination;
  dynamic get distance => _distance;
  dynamic get totalTime => _totalTime;
  String? get rideId => _rideId;
  String? get vehicleId => _vehicleId;
  String? get groupId => _groupId;
  String? get memberName => _memberName;
  String? get drivingLicenceNumber => _drivingLicenceNumber;
  String? get driverName => _driverName;
  String? get ownerName => _ownerName;
  String? get driverMobileNumber => _driverMobileNumber;
  String? get driverEmailId => _driverEmailId;
  String? get driverPhoto => _driverPhoto;
  String? get ownerMobileNumber => _ownerMobileNumber;
  String? get ownerEmailId => _ownerEmailId;
  dynamic get ownerPhoto => _ownerPhoto;
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
    map['distance'] = _distance;
    map['total_time'] = _totalTime;
    map['ride_id'] = _rideId;
    map['vehicle_id'] = _vehicleId;
    map['group_id'] = _groupId;
    map['member_name'] = _memberName;
    map['driving_licence_number'] = _drivingLicenceNumber;
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
    return map;
  }

}