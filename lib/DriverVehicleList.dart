import 'dart:convert';
/// status : true
/// data : [{"_id":"63870128a2d80074cbcfb914","shift":"10 AM to 6 PM","status":"Active","vehicle_id":"6386fbe9a2d80074cbcfb905","vehicledetails":[{"_id":"6386fbe9a2d80074cbcfb905","registration_number":"12345","mobile_number_rc":"8286566802","rc_number":"123456","make":"2017","model":"Dzire","fuel_type":"Petrol","make_year":"2017","fitness_validity":"2024-03-11T00:00:00.000Z","puc_validity":"2024-03-11T00:00:00.000Z","insurance_validity":"2024-03-11T00:00:00.000Z","bcnt":"87954","status":"Active","created_at":"","updated_at":"","created_by":"","updated_by":"","photos":[],"owner_id":"6386f83ba2d80074cbcfb903","documents":{"pancard":["https://tse2.mm.bing.net/th?id=OIP.ia_iuOqb_9uvUC60EHhccQHaEM&pid=Api&P=0"],"aadharcard":["http://2.bp.blogspot.com/-pAcTdofDRq0/UMuCyQl8LzI/AAAAAAAAAKs/cghycsf-f6g/s1600/UIACardDetails1.png","http://2.bp.blogspot.com/-pAcTdofDRq0/UMuCyQl8LzI/AAAAAAAAAKs/cghycsf-f6g/s1600/UIACardDetails1.png"],"rc":["https://tse3.mm.bing.net/th?id=OIP.Mg6c2Up38NAyxu28upE0fwHaEK&pid=Api&P=0"],"insurance":["https://imgv2-2-f.scribdassets.com/img/document/414046126/original/742f544042/1583247596?v=1"],"puc":["http://www.team-bhp.com/forum/attachments/technical-stuff/1083107d1368457312-mahindra-scorpio-issues-solutions-puc.jpg"],"vehicle_photos":["https://wallpapercave.com/wp/wp6205942.jpg","https://wallpapercave.com/wp/wp6205942.jpg","https://wallpapercave.com/wp/wp6205942.jpg"]},"vehicle_type":"SUV"}],"driver_id":"63b94ebee2424c83be29abe9","driver_name":"Maithili Kamble","owner_name":"Prathamesh Tamboli","driver_mobile_number":"8355831970","driving_licence_number":"MH4920220875555","driver_email_id":"maithili@gmail.com","driver_photo":"https://travelsafe-docs.s3.ap-south-1.amazonaws.com/9872344f61cca-ce9b-41d1-9d8a-33f228f4ff898724766188882598728.jpg","owner_mobile_number":"8286566801","owner_email_id":"prathamesh11092@gmail.com","owner_photo":"http://wallsdesk.com/wp-content/uploads/2016/11/Google-Images.jpg","other_info":{"total_rides":340,"total_comments":10,"rating":3.86}}]

DriverVehicleList driverVehicleListFromJson(String str) => DriverVehicleList.fromJson(json.decode(str));
String driverVehicleListToJson(DriverVehicleList data) => json.encode(data.toJson());
class DriverVehicleList {
  DriverVehicleList({
      bool? status, 
      List<VehicleListData>? data,}){
    _status = status;
    _data = data;
}

  DriverVehicleList.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(VehicleListData.fromJson(v));
      });
    }
  }
  bool? _status;
  List<VehicleListData>? _data;
DriverVehicleList copyWith({  bool? status,
  List<VehicleListData>? data,
}) => DriverVehicleList(  status: status ?? _status,
  data: data ?? _data,
);
  bool? get status => _status;
  List<VehicleListData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "63870128a2d80074cbcfb914"
/// shift : "10 AM to 6 PM"
/// status : "Active"
/// vehicle_id : "6386fbe9a2d80074cbcfb905"
/// vehicledetails : [{"_id":"6386fbe9a2d80074cbcfb905","registration_number":"12345","mobile_number_rc":"8286566802","rc_number":"123456","make":"2017","model":"Dzire","fuel_type":"Petrol","make_year":"2017","fitness_validity":"2024-03-11T00:00:00.000Z","puc_validity":"2024-03-11T00:00:00.000Z","insurance_validity":"2024-03-11T00:00:00.000Z","bcnt":"87954","status":"Active","created_at":"","updated_at":"","created_by":"","updated_by":"","photos":[],"owner_id":"6386f83ba2d80074cbcfb903","documents":{"pancard":["https://tse2.mm.bing.net/th?id=OIP.ia_iuOqb_9uvUC60EHhccQHaEM&pid=Api&P=0"],"aadharcard":["http://2.bp.blogspot.com/-pAcTdofDRq0/UMuCyQl8LzI/AAAAAAAAAKs/cghycsf-f6g/s1600/UIACardDetails1.png","http://2.bp.blogspot.com/-pAcTdofDRq0/UMuCyQl8LzI/AAAAAAAAAKs/cghycsf-f6g/s1600/UIACardDetails1.png"],"rc":["https://tse3.mm.bing.net/th?id=OIP.Mg6c2Up38NAyxu28upE0fwHaEK&pid=Api&P=0"],"insurance":["https://imgv2-2-f.scribdassets.com/img/document/414046126/original/742f544042/1583247596?v=1"],"puc":["http://www.team-bhp.com/forum/attachments/technical-stuff/1083107d1368457312-mahindra-scorpio-issues-solutions-puc.jpg"],"vehicle_photos":["https://wallpapercave.com/wp/wp6205942.jpg","https://wallpapercave.com/wp/wp6205942.jpg","https://wallpapercave.com/wp/wp6205942.jpg"]},"vehicle_type":"SUV"}]
/// driver_id : "63b94ebee2424c83be29abe9"
/// driver_name : "Maithili Kamble"
/// owner_name : "Prathamesh Tamboli"
/// driver_mobile_number : "8355831970"
/// driving_licence_number : "MH4920220875555"
/// driver_email_id : "maithili@gmail.com"
/// driver_photo : "https://travelsafe-docs.s3.ap-south-1.amazonaws.com/9872344f61cca-ce9b-41d1-9d8a-33f228f4ff898724766188882598728.jpg"
/// owner_mobile_number : "8286566801"
/// owner_email_id : "prathamesh11092@gmail.com"
/// owner_photo : "http://wallsdesk.com/wp-content/uploads/2016/11/Google-Images.jpg"
/// other_info : {"total_rides":340,"total_comments":10,"rating":3.86}

VehicleListData dataFromJson(String str) => VehicleListData.fromJson(json.decode(str));
String dataToJson(VehicleListData data) => json.encode(data.toJson());
class VehicleListData {
  VehicleListData({
      String? id, 
      String? shift, 
      String? status, 
      String? vehicleId, 
      List<Vehicledetails>? vehicledetails, 
      String? driverId, 
      String? driverName, 
      String? ownerName, 
      String? driverMobileNumber, 
      String? drivingLicenceNumber, 
      String? driverEmailId, 
      String? driverPhoto, 
      String? ownerMobileNumber, 
      String? ownerEmailId, 
      String? ownerPhoto, 
      OtherInfo? otherInfo,}){
    _id = id;
    _shift = shift;
    _status = status;
    _vehicleId = vehicleId;
    _vehicledetails = vehicledetails;
    _driverId = driverId;
    _driverName = driverName;
    _ownerName = ownerName;
    _driverMobileNumber = driverMobileNumber;
    _drivingLicenceNumber = drivingLicenceNumber;
    _driverEmailId = driverEmailId;
    _driverPhoto = driverPhoto;
    _ownerMobileNumber = ownerMobileNumber;
    _ownerEmailId = ownerEmailId;
    _ownerPhoto = ownerPhoto;
    _otherInfo = otherInfo;
}

  VehicleListData.fromJson(dynamic json) {
    _id = json['_id'];
    _shift = json['shift'];
    _status = json['status'];
    _vehicleId = json['vehicle_id'];
    if (json['vehicledetails'] != null) {
      _vehicledetails = [];
      json['vehicledetails'].forEach((v) {
        _vehicledetails?.add(Vehicledetails.fromJson(v));
      });
    }
    _driverId = json['driver_id'];
    _driverName = json['driver_name'];
    _ownerName = json['owner_name'];
    _driverMobileNumber = json['driver_mobile_number'];
    _drivingLicenceNumber = json['driving_licence_number'];
    _driverEmailId = json['driver_email_id'];
    _driverPhoto = json['driver_photo'];
    _ownerMobileNumber = json['owner_mobile_number'];
    _ownerEmailId = json['owner_email_id'];
    _ownerPhoto = json['owner_photo'];
    _otherInfo = json['other_info'] != null ? OtherInfo.fromJson(json['other_info']) : null;
  }
  String? _id;
  String? _shift;
  String? _status;
  String? _vehicleId;
  List<Vehicledetails>? _vehicledetails;
  String? _driverId;
  String? _driverName;
  String? _ownerName;
  String? _driverMobileNumber;
  String? _drivingLicenceNumber;
  String? _driverEmailId;
  String? _driverPhoto;
  String? _ownerMobileNumber;
  String? _ownerEmailId;
  String? _ownerPhoto;
  OtherInfo? _otherInfo;
  VehicleListData copyWith({  String? id,
  String? shift,
  String? status,
  String? vehicleId,
  List<Vehicledetails>? vehicledetails,
  String? driverId,
  String? driverName,
  String? ownerName,
  String? driverMobileNumber,
  String? drivingLicenceNumber,
  String? driverEmailId,
  String? driverPhoto,
  String? ownerMobileNumber,
  String? ownerEmailId,
  String? ownerPhoto,
  OtherInfo? otherInfo,
}) => VehicleListData(  id: id ?? _id,
  shift: shift ?? _shift,
  status: status ?? _status,
  vehicleId: vehicleId ?? _vehicleId,
  vehicledetails: vehicledetails ?? _vehicledetails,
  driverId: driverId ?? _driverId,
  driverName: driverName ?? _driverName,
  ownerName: ownerName ?? _ownerName,
  driverMobileNumber: driverMobileNumber ?? _driverMobileNumber,
  drivingLicenceNumber: drivingLicenceNumber ?? _drivingLicenceNumber,
  driverEmailId: driverEmailId ?? _driverEmailId,
  driverPhoto: driverPhoto ?? _driverPhoto,
  ownerMobileNumber: ownerMobileNumber ?? _ownerMobileNumber,
  ownerEmailId: ownerEmailId ?? _ownerEmailId,
  ownerPhoto: ownerPhoto ?? _ownerPhoto,
  otherInfo: otherInfo ?? _otherInfo,
);
  String? get id => _id;
  String? get shift => _shift;
  String? get status => _status;
  String? get vehicleId => _vehicleId;
  List<Vehicledetails>? get vehicledetails => _vehicledetails;
  String? get driverId => _driverId;
  String? get driverName => _driverName;
  String? get ownerName => _ownerName;
  String? get driverMobileNumber => _driverMobileNumber;
  String? get drivingLicenceNumber => _drivingLicenceNumber;
  String? get driverEmailId => _driverEmailId;
  String? get driverPhoto => _driverPhoto;
  String? get ownerMobileNumber => _ownerMobileNumber;
  String? get ownerEmailId => _ownerEmailId;
  String? get ownerPhoto => _ownerPhoto;
  OtherInfo? get otherInfo => _otherInfo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['shift'] = _shift;
    map['status'] = _status;
    map['vehicle_id'] = _vehicleId;
    if (_vehicledetails != null) {
      map['vehicledetails'] = _vehicledetails?.map((v) => v.toJson()).toList();
    }
    map['driver_id'] = _driverId;
    map['driver_name'] = _driverName;
    map['owner_name'] = _ownerName;
    map['driver_mobile_number'] = _driverMobileNumber;
    map['driving_licence_number'] = _drivingLicenceNumber;
    map['driver_email_id'] = _driverEmailId;
    map['driver_photo'] = _driverPhoto;
    map['owner_mobile_number'] = _ownerMobileNumber;
    map['owner_email_id'] = _ownerEmailId;
    map['owner_photo'] = _ownerPhoto;
    if (_otherInfo != null) {
      map['other_info'] = _otherInfo?.toJson();
    }
    return map;
  }

}

/// total_rides : 340
/// total_comments : 10
/// rating : 3.86

OtherInfo otherInfoFromJson(String str) => OtherInfo.fromJson(json.decode(str));
String otherInfoToJson(OtherInfo data) => json.encode(data.toJson());
class OtherInfo {
  OtherInfo({
      num? totalRides, 
      num? totalComments, 
      num? rating,}){
    _totalRides = totalRides;
    _totalComments = totalComments;
    _rating = rating;
}

  OtherInfo.fromJson(dynamic json) {
    _totalRides = json['total_rides'];
    _totalComments = json['total_comments'];
    _rating = json['rating'];
  }
  num? _totalRides;
  num? _totalComments;
  num? _rating;
OtherInfo copyWith({  num? totalRides,
  num? totalComments,
  num? rating,
}) => OtherInfo(  totalRides: totalRides ?? _totalRides,
  totalComments: totalComments ?? _totalComments,
  rating: rating ?? _rating,
);
  num? get totalRides => _totalRides;
  num? get totalComments => _totalComments;
  num? get rating => _rating;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total_rides'] = _totalRides;
    map['total_comments'] = _totalComments;
    map['rating'] = _rating;
    return map;
  }

}

/// _id : "6386fbe9a2d80074cbcfb905"
/// registration_number : "12345"
/// mobile_number_rc : "8286566802"
/// rc_number : "123456"
/// make : "2017"
/// model : "Dzire"
/// fuel_type : "Petrol"
/// make_year : "2017"
/// fitness_validity : "2024-03-11T00:00:00.000Z"
/// puc_validity : "2024-03-11T00:00:00.000Z"
/// insurance_validity : "2024-03-11T00:00:00.000Z"
/// bcnt : "87954"
/// status : "Active"
/// created_at : ""
/// updated_at : ""
/// created_by : ""
/// updated_by : ""
/// photos : []
/// owner_id : "6386f83ba2d80074cbcfb903"
/// documents : {"pancard":["https://tse2.mm.bing.net/th?id=OIP.ia_iuOqb_9uvUC60EHhccQHaEM&pid=Api&P=0"],"aadharcard":["http://2.bp.blogspot.com/-pAcTdofDRq0/UMuCyQl8LzI/AAAAAAAAAKs/cghycsf-f6g/s1600/UIACardDetails1.png","http://2.bp.blogspot.com/-pAcTdofDRq0/UMuCyQl8LzI/AAAAAAAAAKs/cghycsf-f6g/s1600/UIACardDetails1.png"],"rc":["https://tse3.mm.bing.net/th?id=OIP.Mg6c2Up38NAyxu28upE0fwHaEK&pid=Api&P=0"],"insurance":["https://imgv2-2-f.scribdassets.com/img/document/414046126/original/742f544042/1583247596?v=1"],"puc":["http://www.team-bhp.com/forum/attachments/technical-stuff/1083107d1368457312-mahindra-scorpio-issues-solutions-puc.jpg"],"vehicle_photos":["https://wallpapercave.com/wp/wp6205942.jpg","https://wallpapercave.com/wp/wp6205942.jpg","https://wallpapercave.com/wp/wp6205942.jpg"]}
/// vehicle_type : "SUV"

Vehicledetails vehicledetailsFromJson(String str) => Vehicledetails.fromJson(json.decode(str));
String vehicledetailsToJson(Vehicledetails data) => json.encode(data.toJson());
class Vehicledetails {
  Vehicledetails({
      String? id, 
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
      String? status, 
      String? createdAt, 
      String? updatedAt, 
      String? createdBy, 
      String? updatedBy, 
      List<dynamic>? photos, 
      String? ownerId, 
      Documents? documents, 
      String? vehicleType,}){
    _id = id;
    _registrationNumber = registrationNumber;
    _mobileNumberRc = mobileNumberRc;
    _rcNumber = rcNumber;
    _make = make;
    _model = model;
    _fuelType = fuelType;
    _makeYear = makeYear;
    _fitnessValidity = fitnessValidity;
    _pucValidity = pucValidity;
    _insuranceValidity = insuranceValidity;
    _bcnt = bcnt;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _createdBy = createdBy;
    _updatedBy = updatedBy;
    _photos = photos;
    _ownerId = ownerId;
    _documents = documents;
    _vehicleType = vehicleType;
}

  Vehicledetails.fromJson(dynamic json) {
    _id = json['_id'];
    _registrationNumber = json['registration_number'];
    _mobileNumberRc = json['mobile_number_rc'];
    _rcNumber = json['rc_number'];
    _make = json['make'];
    _model = json['model'];
    _fuelType = json['fuel_type'];
    _makeYear = json['make_year'];
    _fitnessValidity = json['fitness_validity'];
    _pucValidity = json['puc_validity'];
    _insuranceValidity = json['insurance_validity'];
    _bcnt = json['bcnt'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _createdBy = json['created_by'];
    _updatedBy = json['updated_by'];

    _ownerId = json['owner_id'];
    _documents = json['documents'] != null ? Documents.fromJson(json['documents']) : null;
    _vehicleType = json['vehicle_type'];
  }
  String? _id;
  String? _registrationNumber;
  String? _mobileNumberRc;
  String? _rcNumber;
  String? _make;
  String? _model;
  String? _fuelType;
  String? _makeYear;
  String? _fitnessValidity;
  String? _pucValidity;
  String? _insuranceValidity;
  String? _bcnt;
  String? _status;
  String? _createdAt;
  String? _updatedAt;
  String? _createdBy;
  String? _updatedBy;
  List<dynamic>? _photos;
  String? _ownerId;
  Documents? _documents;
  String? _vehicleType;
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
  String? status,
  String? createdAt,
  String? updatedAt,
  String? createdBy,
  String? updatedBy,
  List<dynamic>? photos,
  String? ownerId,
  Documents? documents,
  String? vehicleType,
}) => Vehicledetails(  id: id ?? _id,
  registrationNumber: registrationNumber ?? _registrationNumber,
  mobileNumberRc: mobileNumberRc ?? _mobileNumberRc,
  rcNumber: rcNumber ?? _rcNumber,
  make: make ?? _make,
  model: model ?? _model,
  fuelType: fuelType ?? _fuelType,
  makeYear: makeYear ?? _makeYear,
  fitnessValidity: fitnessValidity ?? _fitnessValidity,
  pucValidity: pucValidity ?? _pucValidity,
  insuranceValidity: insuranceValidity ?? _insuranceValidity,
  bcnt: bcnt ?? _bcnt,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  createdBy: createdBy ?? _createdBy,
  updatedBy: updatedBy ?? _updatedBy,
  photos: photos ?? _photos,
  ownerId: ownerId ?? _ownerId,
  documents: documents ?? _documents,
  vehicleType: vehicleType ?? _vehicleType,
);
  String? get id => _id;
  String? get registrationNumber => _registrationNumber;
  String? get mobileNumberRc => _mobileNumberRc;
  String? get rcNumber => _rcNumber;
  String? get make => _make;
  String? get model => _model;
  String? get fuelType => _fuelType;
  String? get makeYear => _makeYear;
  String? get fitnessValidity => _fitnessValidity;
  String? get pucValidity => _pucValidity;
  String? get insuranceValidity => _insuranceValidity;
  String? get bcnt => _bcnt;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get createdBy => _createdBy;
  String? get updatedBy => _updatedBy;
  List<dynamic>? get photos => _photos;
  String? get ownerId => _ownerId;
  Documents? get documents => _documents;
  String? get vehicleType => _vehicleType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['registration_number'] = _registrationNumber;
    map['mobile_number_rc'] = _mobileNumberRc;
    map['rc_number'] = _rcNumber;
    map['make'] = _make;
    map['model'] = _model;
    map['fuel_type'] = _fuelType;
    map['make_year'] = _makeYear;
    map['fitness_validity'] = _fitnessValidity;
    map['puc_validity'] = _pucValidity;
    map['insurance_validity'] = _insuranceValidity;
    map['bcnt'] = _bcnt;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['created_by'] = _createdBy;
    map['updated_by'] = _updatedBy;
    if (_photos != null) {
      map['photos'] = _photos?.map((v) => v.toJson()).toList();
    }
    map['owner_id'] = _ownerId;
    if (_documents != null) {
      map['documents'] = _documents?.toJson();
    }
    map['vehicle_type'] = _vehicleType;
    return map;
  }

}

/// pancard : ["https://tse2.mm.bing.net/th?id=OIP.ia_iuOqb_9uvUC60EHhccQHaEM&pid=Api&P=0"]
/// aadharcard : ["http://2.bp.blogspot.com/-pAcTdofDRq0/UMuCyQl8LzI/AAAAAAAAAKs/cghycsf-f6g/s1600/UIACardDetails1.png","http://2.bp.blogspot.com/-pAcTdofDRq0/UMuCyQl8LzI/AAAAAAAAAKs/cghycsf-f6g/s1600/UIACardDetails1.png"]
/// rc : ["https://tse3.mm.bing.net/th?id=OIP.Mg6c2Up38NAyxu28upE0fwHaEK&pid=Api&P=0"]
/// insurance : ["https://imgv2-2-f.scribdassets.com/img/document/414046126/original/742f544042/1583247596?v=1"]
/// puc : ["http://www.team-bhp.com/forum/attachments/technical-stuff/1083107d1368457312-mahindra-scorpio-issues-solutions-puc.jpg"]
/// vehicle_photos : ["https://wallpapercave.com/wp/wp6205942.jpg","https://wallpapercave.com/wp/wp6205942.jpg","https://wallpapercave.com/wp/wp6205942.jpg"]

Documents documentsFromJson(String str) => Documents.fromJson(json.decode(str));
String documentsToJson(Documents data) => json.encode(data.toJson());
class Documents {
  Documents({
      List<String>? pancard, 
      List<String>? aadharcard, 
      List<String>? rc, 
      List<String>? insurance, 
      List<String>? puc, 
      List<String>? vehiclePhotos,}){
    _pancard = pancard;
    _aadharcard = aadharcard;
    _rc = rc;
    _insurance = insurance;
    _puc = puc;
    _vehiclePhotos = vehiclePhotos;
}

  Documents.fromJson(dynamic json) {
    _pancard = json['pancard'] != null ? json['pancard'].cast<String>() : [];
    _aadharcard = json['aadharcard'] != null ? json['aadharcard'].cast<String>() : [];
    _rc = json['rc'] != null ? json['rc'].cast<String>() : [];
    _insurance = json['insurance'] != null ? json['insurance'].cast<String>() : [];
    _puc = json['puc'] != null ? json['puc'].cast<String>() : [];
    _vehiclePhotos = json['vehicle_photos'] != null ? json['vehicle_photos'].cast<String>() : [];
  }
  List<String>? _pancard;
  List<String>? _aadharcard;
  List<String>? _rc;
  List<String>? _insurance;
  List<String>? _puc;
  List<String>? _vehiclePhotos;
Documents copyWith({  List<String>? pancard,
  List<String>? aadharcard,
  List<String>? rc,
  List<String>? insurance,
  List<String>? puc,
  List<String>? vehiclePhotos,
}) => Documents(  pancard: pancard ?? _pancard,
  aadharcard: aadharcard ?? _aadharcard,
  rc: rc ?? _rc,
  insurance: insurance ?? _insurance,
  puc: puc ?? _puc,
  vehiclePhotos: vehiclePhotos ?? _vehiclePhotos,
);
  List<String>? get pancard => _pancard;
  List<String>? get aadharcard => _aadharcard;
  List<String>? get rc => _rc;
  List<String>? get insurance => _insurance;
  List<String>? get puc => _puc;
  List<String>? get vehiclePhotos => _vehiclePhotos;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pancard'] = _pancard;
    map['aadharcard'] = _aadharcard;
    map['rc'] = _rc;
    map['insurance'] = _insurance;
    map['puc'] = _puc;
    map['vehicle_photos'] = _vehiclePhotos;
    return map;
  }

}