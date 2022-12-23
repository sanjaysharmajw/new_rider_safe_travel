import 'dart:convert';
DriverVehicleList driverVehicleListFromJson(String str) => DriverVehicleList.fromJson(json.decode(str));
String driverVehicleListToJson(DriverVehicleList data) => json.encode(data.toJson());
class DriverVehicleList {
  DriverVehicleList({
    this.status,
    this.data,});

  DriverVehicleList.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  bool? status;
  List<Data>? data;
  DriverVehicleList copyWith({  bool? status,
    List<Data>? data,
  }) => DriverVehicleList(  status: status ?? this.status,
    data: data ?? this.data,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
    this.id,
    this.status,
    this.shift,
    this.vehicledetails,
    this.driverName,
    this.ownerName,
    this.driverMobileNumber,
    this.drivingLicenceNumber,
    this.driverEmailId,
    this.driverId,
    this.driverPhoto,
    this.ownerMobileNumber,
    this.ownerEmailId,
    this.ownerPhoto,});

  Data.fromJson(dynamic json) {
    id = json['_id'];
    status = json['status'];
    shift = json['shift'];
    if (json['vehicledetails'] != null) {
      vehicledetails = [];
      json['vehicledetails'].forEach((v) {
        vehicledetails?.add(Vehicledetails.fromJson(v));
      });
    }
    driverName = json['driver_name'];
    ownerName = json['owner_name'];
    driverMobileNumber = json['driver_mobile_number'];
    drivingLicenceNumber = json['driving_licence_number'];
    driverEmailId = json['driver_email_id'];
    driverId = json['driver_id'];
    driverPhoto = json['driver_photo'];
    ownerMobileNumber = json['owner_mobile_number'];
    ownerEmailId = json['owner_email_id'];
    ownerPhoto = json['owner_photo'];
  }
  String? id;
  String? status;
  String? shift;
  List<Vehicledetails>? vehicledetails;
  String? driverName;
  String? ownerName;
  String? driverMobileNumber;
  String? drivingLicenceNumber;
  String? driverEmailId;
  String? driverId;
  String? driverPhoto;
  String? ownerMobileNumber;
  String? ownerEmailId;
  String? ownerPhoto;
  Data copyWith({  String? id,
    String? status,
    String? shift,
    List<Vehicledetails>? vehicledetails,
    String? driverName,
    String? ownerName,
    String? driverMobileNumber,
    String? drivingLicenceNumber,
    String? driverEmailId,
    String? driverId,
    String? driverPhoto,
    String? ownerMobileNumber,
    String? ownerEmailId,
    String? ownerPhoto,
  }) => Data(  id: id ?? this.id,
    status: status ?? this.status,
    shift: shift ?? this.shift,
    vehicledetails: vehicledetails ?? this.vehicledetails,
    driverName: driverName ?? this.driverName,
    ownerName: ownerName ?? this.ownerName,
    driverMobileNumber: driverMobileNumber ?? this.driverMobileNumber,
    drivingLicenceNumber: drivingLicenceNumber ?? this.drivingLicenceNumber,
    driverEmailId: driverEmailId ?? this.driverEmailId,
    driverId: driverId ?? this.driverId,
    driverPhoto: driverPhoto ?? this.driverPhoto,
    ownerMobileNumber: ownerMobileNumber ?? this.ownerMobileNumber,
    ownerEmailId: ownerEmailId ?? this.ownerEmailId,
    ownerPhoto: ownerPhoto ?? this.ownerPhoto,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['status'] = status;
    map['shift'] = shift;
    if (vehicledetails != null) {
      map['vehicledetails'] = vehicledetails?.map((v) => v.toJson()).toList();
    }
    map['driver_name'] = driverName;
    map['owner_name'] = ownerName;
    map['driver_mobile_number'] = driverMobileNumber;
    map['driving_licence_number'] = drivingLicenceNumber;
    map['driver_email_id'] = driverEmailId;
    map['driver_id'] = driverId;
    map['driver_photo'] = driverPhoto;
    map['owner_mobile_number'] = ownerMobileNumber;
    map['owner_email_id'] = ownerEmailId;
    map['owner_photo'] = ownerPhoto;
    return map;
  }

}

Vehicledetails vehicledetailsFromJson(String str) => Vehicledetails.fromJson(json.decode(str));
String vehicledetailsToJson(Vehicledetails data) => json.encode(data.toJson());
class Vehicledetails {
  Vehicledetails({
    this.id,
    this.registrationNumber,
    this.mobileNumberRc,
    this.rcNumber,
    this.make,
    this.model,
    this.fuelType,
    this.makeYear,
    this.fitnessValidity,
    this.pucValidity,
    this.insuranceValidity,
    this.bcnt,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.photos,
    this.ownerId,
  });

  Vehicledetails.fromJson(dynamic json) {
    id = json['_id'];
    registrationNumber = json['registration_number'];
    mobileNumberRc = json['mobile_number_rc'];
    rcNumber = json['rc_number'];
    make = json['make'];
    model = json['model'];
    fuelType = json['fuel_type'];
    makeYear = json['make_year'];
    fitnessValidity = json['fitness_validity'];
    pucValidity = json['puc_validity'];
    insuranceValidity = json['insurance_validity'];
    bcnt = json['bcnt'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    ownerId = json['owner_id'];

  }
  String? id;
  String? registrationNumber;
  String? mobileNumberRc;
  String? rcNumber;
  String? make;
  String? model;
  String? fuelType;
  String? makeYear;
  String? fitnessValidity;
  String? pucValidity;
  String? insuranceValidity;
  String? bcnt;
  List<dynamic>? documents;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;
  List<dynamic>? photos;
  String? ownerId;
  Vehicledetails copyWith({  String? id,
    String? registrationNumber,
    String? mobileNumberRc,
    String? rcNumber,
    String? make,
    String? model,
    String? fuelType,
    String? makeYear,
    String? fitnessValidity,
    String? pucValidity,
    String? insuranceValidity,
    String? bcnt,
    List<dynamic>? documents,
    String? status,
    String? createdAt,
    String? updatedAt,
    String? createdBy,
    String? updatedBy,
    List<dynamic>? photos,
    String? ownerId,
  }) => Vehicledetails(  id: id ?? this.id,
    registrationNumber: registrationNumber ?? this.registrationNumber,
    mobileNumberRc: mobileNumberRc ?? this.mobileNumberRc,
    rcNumber: rcNumber ?? this.rcNumber,
    make: make ?? this.make,
    model: model ?? this.model,
    fuelType: fuelType ?? this.fuelType,
    makeYear: makeYear ?? this.makeYear,
    fitnessValidity: fitnessValidity ?? this.fitnessValidity,
    pucValidity: pucValidity ?? this.pucValidity,
    insuranceValidity: insuranceValidity ?? this.insuranceValidity,
    bcnt: bcnt ?? this.bcnt,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    createdBy: createdBy ?? this.createdBy,
    updatedBy: updatedBy ?? this.updatedBy,
    photos: photos ?? this.photos,
    ownerId: ownerId ?? this.ownerId,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['registration_number'] = registrationNumber;
    map['mobile_number_rc'] = mobileNumberRc;
    map['rc_number'] = rcNumber;
    map['make'] = make;
    map['model'] = model;
    map['fuel_type'] = fuelType;
    map['make_year'] = makeYear;
    map['fitness_validity'] = fitnessValidity;
    map['puc_validity'] = pucValidity;
    map['insurance_validity'] = insuranceValidity;
    map['bcnt'] = bcnt;
    if (documents != null) {
      map['Documents'] = documents?.map((v) => v.toJson()).toList();
    }
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['created_by'] = createdBy;
    map['updated_by'] = updatedBy;
    if (photos != null) {
      map['photos'] = photos?.map((v) => v.toJson()).toList();
    }
    map['owner_id'] = ownerId;
    return map;
  }

}

Documents documentsFromJson(String str) => Documents.fromJson(json.decode(str));
String documentsToJson(Documents data) => json.encode(data.toJson());
class Documents {
  Documents({
    this.pancard,
    this.aadharcard,
    this.rc,
    this.insurance,
    this.puc,
    this.vehiclePhotos,});

  Documents.fromJson(dynamic json) {
    pancard = json['pancard'] != null ? json['pancard'].cast<String>() : [];
    aadharcard = json['aadharcard'] != null ? json['aadharcard'].cast<String>() : [];
    rc = json['rc'] != null ? json['rc'].cast<String>() : [];
    insurance = json['insurance'] != null ? json['insurance'].cast<String>() : [];
    puc = json['puc'] != null ? json['puc'].cast<String>() : [];
    vehiclePhotos = json['vehicle_photos'] != null ? json['vehicle_photos'].cast<String>() : [];
  }
  List<String>? pancard;
  List<String>? aadharcard;
  List<String>? rc;
  List<String>? insurance;
  List<String>? puc;
  List<String>? vehiclePhotos;
  Documents copyWith({  List<String>? pancard,
    List<String>? aadharcard,
    List<String>? rc,
    List<String>? insurance,
    List<String>? puc,
    List<String>? vehiclePhotos,
  }) => Documents(  pancard: pancard ?? this.pancard,
    aadharcard: aadharcard ?? this.aadharcard,
    rc: rc ?? this.rc,
    insurance: insurance ?? this.insurance,
    puc: puc ?? this.puc,
    vehiclePhotos: vehiclePhotos ?? this.vehiclePhotos,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pancard'] = pancard;
    map['aadharcard'] = aadharcard;
    map['rc'] = rc;
    map['insurance'] = insurance;
    map['puc'] = puc;
    map['vehicle_photos'] = vehiclePhotos;
    return map;
  }

}