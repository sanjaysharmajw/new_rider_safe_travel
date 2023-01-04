import 'dart:convert';

Familymodel familymodelFromJson(String str) =>
    Familymodel.fromJson(json.decode(str));
String familymodelToJson(Familymodel data) => json.encode(data.toJson());

class Familymodel {
  Familymodel({
    this.id,
    this.userId,
    this.driverId,
    this.date,
    this.fromDestination,
    this.toDestination,
    this.distance,
    this.totalTime,
    this.vehicleId,
    this.memberName,
    this.drivingLicenceNumber,
    this.vehicleRegistrationNumber,
    this.member_photo,
    this.driverName,
    this.ownerName,
    this.driverMobileNumber,
    this.driverEmailId,
    this.driverPhoto,
    this.ownerMobileNumber,
    this.ownerEmailId,
    this.ownerPhoto,
    this.vehicleMake,
    this.vehicleModel,
    this.vehicleFuelType,
    this.vehicleMakeYear,
    this.vehicleFitnessValidity,
    this.vehiclePucValidity,
    this.vehicleInsuranceValidity,
    this.vehiclePhoto,
  });

  Familymodel.fromJson(dynamic json) {
    id = json['_id'];
    userId = json['user_id'];
    driverId = json['driver_id'];
    date = json['date'];
    fromDestination = json['from_destination'];
    toDestination = json['to_destination'];
    distance = json['distance'];
    totalTime = json['total_time'];
    vehicleId = json['vehicle_id'];
    memberName = json['member_name'];
    drivingLicenceNumber = json['driving_licence_number'];
    vehicleRegistrationNumber = json['vehicle_registrationNumber'];
    member_photo = json['member_photo'];
    driverName = json['driver_name'];
    ownerName = json['owner_name'];
    driverMobileNumber = json['driver_mobile_number'];
    driverEmailId = json['driver_email_id'];
    driverPhoto = json['driver_photo'];
    ownerMobileNumber = json['owner_mobile_number'];
    ownerEmailId = json['owner_email_id'];
    ownerPhoto = json['owner_photo'];
    vehicleMake = json['vehicle_make'];
    vehicleModel = json['vehicle_model'];
    vehicleFuelType = json['vehicle_fuelType'];
    vehicleMakeYear = json['vehicle_makeYear'];
    vehicleFitnessValidity = json['vehicle_fitnessValidity'];
    vehiclePucValidity = json['vehicle_pucValidity'];
    vehicleInsuranceValidity = json['vehicle_insuranceValidity'];
    vehiclePhoto = json['vehicle_photo'];
  }
  String? id;
  String? userId;
  String? driverId;
  String? date;
  String? fromDestination;
  String? toDestination;
  String? distance;
  String? totalTime;
  String? vehicleId;
  String? memberName;
  String? drivingLicenceNumber;
  String? vehicleRegistrationNumber;
  String? member_photo;
  String? driverName;
  String? ownerName;
  String? driverMobileNumber;
  String? driverEmailId;
  String? driverPhoto;
  String? ownerMobileNumber;
  String? ownerEmailId;
  String? ownerPhoto;
  String? vehicleMake;
  String? vehicleModel;
  String? vehicleFuelType;
  String? vehicleMakeYear;
  String? vehicleFitnessValidity;
  String? vehiclePucValidity;
  String? vehicleInsuranceValidity;
  String? vehiclePhoto;
  Familymodel copyWith({
    String? id,
    String? userId,
    String? driverId,
    String? date,
    String? fromDestination,
    String? toDestination,
    String? distance,
    String? totalTime,
    String? vehicleId,
    String? memberName,
    String? drivingLicenceNumber,
    String? driverName,
    String? ownerName,
    String? driverMobileNumber,
    String? driverEmailId,
    String? driverPhoto,
    String? ownerMobileNumber,
    String? ownerEmailId,
    String? ownerPhoto,
    String? vehicleMake,
    String? vehicleModel,
    String? vehicleFuelType,
    String? vehicleMakeYear,
    String? vehicleFitnessValidity,
    String? vehiclePucValidity,
    String? vehicleInsuranceValidity,
    String? vehiclePhoto,
  }) =>
      Familymodel(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        driverId: driverId ?? this.driverId,
        date: date ?? this.date,
        fromDestination: fromDestination ?? this.fromDestination,
        toDestination: toDestination ?? this.toDestination,
        distance: distance ?? this.distance,
        totalTime: totalTime ?? this.totalTime,
        vehicleId: vehicleId ?? this.vehicleId,
        memberName: memberName ?? this.memberName,
        drivingLicenceNumber: drivingLicenceNumber ?? this.drivingLicenceNumber,
        vehicleRegistrationNumber:
            vehicleRegistrationNumber ?? this.vehicleRegistrationNumber,
        member_photo: member_photo ?? this.member_photo,
        driverName: driverName ?? this.driverName,
        ownerName: ownerName ?? this.ownerName,
        driverMobileNumber: driverMobileNumber ?? this.driverMobileNumber,
        driverEmailId: driverEmailId ?? this.driverEmailId,
        driverPhoto: driverPhoto ?? this.driverPhoto,
        ownerMobileNumber: ownerMobileNumber ?? this.ownerMobileNumber,
        ownerEmailId: ownerEmailId ?? this.ownerEmailId,
        ownerPhoto: ownerPhoto ?? this.ownerPhoto,
        vehicleMake: vehicleMake ?? this.vehicleMake,
        vehicleModel: vehicleModel ?? this.vehicleModel,
        vehicleFuelType: vehicleFuelType ?? this.vehicleFuelType,
        vehicleMakeYear: vehicleMakeYear ?? this.vehicleMakeYear,
        vehicleFitnessValidity:
            vehicleFitnessValidity ?? this.vehicleFitnessValidity,
        vehiclePucValidity: vehiclePucValidity ?? this.vehiclePucValidity,
        vehicleInsuranceValidity:
            vehicleInsuranceValidity ?? this.vehicleInsuranceValidity,
        vehiclePhoto: vehiclePhoto ?? this.vehiclePhoto,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['user_id'] = userId;
    map['driver_id'] = driverId;
    map['date'] = date;
    map['from_destination'] = fromDestination;
    map['to_destination'] = toDestination;
    map['distance'] = distance;
    map['total_time'] = totalTime;
    map['vehicle_id'] = vehicleId;
    map['member_name'] = memberName;
    map['driving_licence_number'] = drivingLicenceNumber;
    map['vehicleRegistrationNumber'] = vehicleRegistrationNumber;
    map['member_photo'] = member_photo;
    map['driver_name'] = driverName;
    map['owner_name'] = ownerName;
    map['driver_mobile_number'] = driverMobileNumber;
    map['driver_email_id'] = driverEmailId;
    map['driver_photo'] = driverPhoto;
    map['owner_mobile_number'] = ownerMobileNumber;
    map['owner_email_id'] = ownerEmailId;
    map['owner_photo'] = ownerPhoto;
    map['vehicle_make'] = vehicleMake;
    map['vehicle_model'] = vehicleModel;
    map['vehicle_fuelType'] = vehicleFuelType;
    map['vehicle_makeYear'] = vehicleMakeYear;
    map['vehicle_fitnessValidity'] = vehicleFitnessValidity;
    map['vehicle_pucValidity'] = vehiclePucValidity;
    map['vehicle_insuranceValidity'] = vehicleInsuranceValidity;
    map['vehicle_photo'] = vehiclePhoto;
    return map;
  }
}
