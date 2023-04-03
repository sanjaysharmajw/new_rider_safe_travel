import 'dart:convert';

RideDataModel dataFromJson(String str) =>
    RideDataModel.fromJson(json.decode(str));
String dataToJson(RideDataModel data) => json.encode(data.toJson());

class RideDataModel {
  RideDataModel({
    this.id,
    this.userId,
    this.driverId,
    this.date,
    this.fromDestination,
    this.toDestination,
    this.startPoint,
    this.endPoint,
    this.stops,
    this.distance,
    this.totalTime,
    this.vehicleId,
    this.driverName,
    this.driverMobileNumber,
    this.drivingLicenceNumber,
    this.driverEmailId,
    this.driverPhoto,
    this.vehicleRegistrationNumber,
    this.vehicleRcNumber,
    this.vehicleMake,
    this.vehicleModel,
    this.vehicleFuelType,
    this.vehicleMakeYear,
    this.vehicleFitnessValidity,
    this.vehiclePucValidity,
    this.vehicleInsuranceValidity,
    this.vehiclePhoto,
    this.startTime,
    this.endTime,
  });

  RideDataModel.fromJson(dynamic json) {
    id = json['_id'];
    userId = json['user_id'];
    driverId = json['driver_id'];
    date = json['date'];
    fromDestination = json['from_destination'];
    toDestination = json['to_destination'];
    startPoint = json['start_point'] != null
        ? StartPoint.fromJson(json['start_point'])
        : null;
    endPoint = json['end_point'];

    distance = json['distance'];
    totalTime = json['total_time'];
    vehicleId = json['vehicle_id'];
    driverName = json['driver_name'];
    driverMobileNumber = json['driver_mobile_number'];
    drivingLicenceNumber = json['driving_licence_number'];
    driverEmailId = json['driver_email_id'];
    driverPhoto = json['driver_photo'];
    vehicleRegistrationNumber = json['vehicle_registrationNumber'];
    vehicleRcNumber = json['vehicle_rcNumber'];
    vehicleMake = json['vehicle_make'];
    vehicleModel = json['vehicle_model'];
    vehicleFuelType = json['vehicle_fuelType'];
    vehicleMakeYear = json['vehicle_makeYear'];
    vehicleFitnessValidity = json['vehicle_fitnessValidity'];
    vehiclePucValidity = json['vehicle_pucValidity'];
    vehicleInsuranceValidity = json['vehicle_insuranceValidity'];
    vehiclePhoto = json['vehicle_photo'];
    startTime = json['start_time'];
    endTime = json['end_time'];
  }
  String? id;
  String? userId;
  String? driverId;
  String? date;
  dynamic fromDestination;
  dynamic toDestination;
  StartPoint? startPoint;
  dynamic endPoint;
  List<dynamic>? stops;
  dynamic distance;
  dynamic totalTime;
  String? vehicleId;
  String? driverName;
  String? driverMobileNumber;
  String? drivingLicenceNumber;
  String? driverEmailId;
  String? driverPhoto;
  String? vehicleRegistrationNumber;
  String? vehicleRcNumber;
  String? vehicleMake;
  String? vehicleModel;
  String? vehicleFuelType;
  String? vehicleMakeYear;
  String? vehicleFitnessValidity;
  String? vehiclePucValidity;
  String? vehicleInsuranceValidity;
  String? vehiclePhoto;
  String? startTime;
  String? endTime;
  RideDataModel copyWith({
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
    String? startTime,
    String? endTime,
  }) =>
      RideDataModel(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        driverId: driverId ?? this.driverId,
        date: date ?? this.date,
        fromDestination: fromDestination ?? this.fromDestination,
        toDestination: toDestination ?? this.toDestination,
        startPoint: startPoint ?? this.startPoint,
        endPoint: endPoint ?? this.endPoint,
        stops: stops ?? this.stops,
        distance: distance ?? this.distance,
        totalTime: totalTime ?? this.totalTime,
        vehicleId: vehicleId ?? this.vehicleId,
        driverName: driverName ?? this.driverName,
        driverMobileNumber: driverMobileNumber ?? this.driverMobileNumber,
        drivingLicenceNumber: drivingLicenceNumber ?? this.drivingLicenceNumber,
        driverEmailId: driverEmailId ?? this.driverEmailId,
        driverPhoto: driverPhoto ?? this.driverPhoto,
        vehicleRegistrationNumber:
            vehicleRegistrationNumber ?? this.vehicleRegistrationNumber,
        vehicleRcNumber: vehicleRcNumber ?? this.vehicleRcNumber,
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
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['user_id'] = userId;
    map['driver_id'] = driverId;
    map['date'] = date;
    map['from_destination'] = fromDestination;
    map['to_destination'] = toDestination;
    if (startPoint != null) {
      map['start_point'] = startPoint?.toJson();
    }
    map['end_point'] = endPoint;
    if (stops != null) {
      map['stops'] = stops?.map((v) => v.toJson()).toList();
    }
    map['distance'] = distance;
    map['total_time'] = totalTime;
    map['vehicle_id'] = vehicleId;
    map['driver_name'] = driverName;
    map['driver_mobile_number'] = driverMobileNumber;
    map['driving_licence_number'] = drivingLicenceNumber;
    map['driver_email_id'] = driverEmailId;
    map['driver_photo'] = driverPhoto;
    map['vehicle_registrationNumber'] = vehicleRegistrationNumber;
    map['vehicle_rcNumber'] = vehicleRcNumber;
    map['vehicle_make'] = vehicleMake;
    map['vehicle_model'] = vehicleModel;
    map['vehicle_fuelType'] = vehicleFuelType;
    map['vehicle_makeYear'] = vehicleMakeYear;
    map['vehicle_fitnessValidity'] = vehicleFitnessValidity;
    map['vehicle_pucValidity'] = vehiclePucValidity;
    map['vehicle_insuranceValidity'] = vehicleInsuranceValidity;
    map['vehicle_photo'] = vehiclePhoto;
    map['start_time'] = startTime;
    map['end_time'] = endTime;
    return map;
  }
}

StartPoint startPointFromJson(String str) =>
    StartPoint.fromJson(json.decode(str));
String startPointToJson(StartPoint data) => json.encode(data.toJson());

class StartPoint {
  StartPoint({
    this.time,
    //required this.latitude,
    // required this.longitude,
    this.location,
  });

  StartPoint.fromJson(dynamic json) {
    time = json['time'];
    //latitude = double.tryParse(json['latitude'].toString()) as String;
    //longitude = double.tryParse(json['longitude'].toString()) as String;
    location = json['location'];
  }
  String? time;
  String latitude = "";
  String longitude = "";
  String? location;
  StartPoint copyWith({
    String? time,
    //String? latitude,
    //required String longitude,
    required String location,
  }) =>
      StartPoint(
        time: time ?? this.time,
        // latitude: latitude ?? this.latitude,
        //longitude: longitude ?? this.longitude,
        location: location ?? this.location,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['time'] = time;
    // map['latitude'] = latitude;
    //map['longitude'] = longitude;
    map['location'] = location;
    return map;
  }
}
