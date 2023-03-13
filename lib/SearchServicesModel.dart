import 'dart:convert';
/// status : true
/// data : [{"_id":"63fc894f2e0ec5faaf772791","user_id":"6386f83ba2d80074cbcfb903","service_id":"63fc74202e0ec5faaf772783","service_name":"Service 1","title":"Prathamesh service 123","address":"Panvel","city":"Panvel","state":"Maharashtra","pincode":"410206","contact_person":"1234567890","contact_person_name":"Prathamesh","email_id":"prathamesh1109@gmail.com","avaibility":{"avaibilityDays":{"Sunday":"Yes","Monday":"Yes","Wednesday":"Yes","Thursday":"Yes","Friday":"Yes","Saturday":"Yes"},"allDayAvailable":"Yes","availableTimeFrom":"10 Am","availableTimeTo":"7 PM","comment":"","24by7avaibility":"No"},"address_details":{"lat":23.36531,"lng":85.32824,"Label":"Green Acre, Kali Asthan Road, Ansar Nagar, Naya Toli, Ranchi 834001, India","Municipality":"Ranchi","Neighborhood":"Naya Toli","PostalCode":"834001","Region":"Jharkhand","SubRegion":"Ranchi"},"status":"Active","created_at":"","updated_at":"2023-03-03T13:11:56.572Z","created_by":"","updated_by":"6401f21c653004a31bc5c269","location":{"type":"Point","coordinates":[73.178927,18.89054]},"documents":[{"name":"Reg Copy","photo":"https://5.imimg.com/data5/TO/HJ/MY-38237577/shop-registration-charges-500x500.jpg"}],"dist":28.10480263348812}]

SearchServicesModel searchServicesModelFromJson(String str) => SearchServicesModel.fromJson(json.decode(str));
String searchServicesModelToJson(SearchServicesModel data) => json.encode(data.toJson());
class SearchServicesModel {
  SearchServicesModel({
      bool? status,
      List<ServiceListData>? data,}){
    _status = status;
    _data = data;
}

  SearchServicesModel.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ServiceListData.fromJson(v));
      });
    }
  }
  bool? _status;
  List<ServiceListData>? _data;
SearchServicesModel copyWith({  bool? status,
  List<ServiceListData>? data,
}) => SearchServicesModel(  status: status ?? _status,
  data: data ?? _data,
);
  bool? get status => _status;
  List<ServiceListData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "63fc894f2e0ec5faaf772791"
/// user_id : "6386f83ba2d80074cbcfb903"
/// service_id : "63fc74202e0ec5faaf772783"
/// service_name : "Service 1"
/// title : "Prathamesh service 123"
/// address : "Panvel"
/// city : "Panvel"
/// state : "Maharashtra"
/// pincode : "410206"
/// contact_person : "1234567890"
/// contact_person_name : "Prathamesh"
/// email_id : "prathamesh1109@gmail.com"
/// avaibility : {"avaibilityDays":{"Sunday":"Yes","Monday":"Yes","Wednesday":"Yes","Thursday":"Yes","Friday":"Yes","Saturday":"Yes"},"allDayAvailable":"Yes","availableTimeFrom":"10 Am","availableTimeTo":"7 PM","comment":"","24by7avaibility":"No"}
/// address_details : {"lat":23.36531,"lng":85.32824,"Label":"Green Acre, Kali Asthan Road, Ansar Nagar, Naya Toli, Ranchi 834001, India","Municipality":"Ranchi","Neighborhood":"Naya Toli","PostalCode":"834001","Region":"Jharkhand","SubRegion":"Ranchi"}
/// status : "Active"
/// created_at : ""
/// updated_at : "2023-03-03T13:11:56.572Z"
/// created_by : ""
/// updated_by : "6401f21c653004a31bc5c269"
/// location : {"type":"Point","coordinates":[73.178927,18.89054]}
/// documents : [{"name":"Reg Copy","photo":"https://5.imimg.com/data5/TO/HJ/MY-38237577/shop-registration-charges-500x500.jpg"}]
/// dist : 28.10480263348812

ServiceListData dataFromJson(String str) => ServiceListData.fromJson(json.decode(str));
String dataToJson(ServiceListData data) => json.encode(data.toJson());
class ServiceListData {
  ServiceListData({
      String? id, 
      String? userId, 
      String? serviceId, 
      String? serviceName, 
      String? title, 
      String? address, 
      String? city, 
      String? state, 
      String? pincode, 
      String? contactPerson, 
      String? contactPersonName, 
      String? emailId, 
      Avaibility? avaibility, 
      AddressDetails? addressDetails, 
      String? status, 
      String? createdAt, 
      String? updatedAt, 
      String? createdBy, 
      String? updatedBy,
    LocationDataModel? location,
      List<Documents>? documents, 
      num? dist,}){
    _id = id;
    _userId = userId;
    _serviceId = serviceId;
    _serviceName = serviceName;
    _title = title;
    _address = address;
    _city = city;
    _state = state;
    _pincode = pincode;
    _contactPerson = contactPerson;
    _contactPersonName = contactPersonName;
    _emailId = emailId;
    _avaibility = avaibility;
    _addressDetails = addressDetails;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _createdBy = createdBy;
    _updatedBy = updatedBy;
    _location = location;
    _documents = documents;
    _dist = dist;
}

  ServiceListData.fromJson(dynamic json) {
    _id = json['_id'];
    _userId = json['user_id'];
    _serviceId = json['service_id'];
    _serviceName = json['service_name'];
    _title = json['title'];
    _address = json['address'];
    _city = json['city'];
    _state = json['state'];
    _pincode = json['pincode'];
    _contactPerson = json['contact_person'];
    _contactPersonName = json['contact_person_name'];
    _emailId = json['email_id'];
    _avaibility = json['avaibility'] != null ? Avaibility.fromJson(json['avaibility']) : null;
    _addressDetails = json['address_details'] != null ? AddressDetails.fromJson(json['address_details']) : null;
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _createdBy = json['created_by'];
    _updatedBy = json['updated_by'];
    _location = json['location'] != null ? LocationDataModel.fromJson(json['location']) : null;
    if (json['documents'] != null) {
      _documents = [];
      json['documents'].forEach((v) {
        _documents?.add(Documents.fromJson(v));
      });
    }
    _dist = json['dist'];
  }
  String? _id;
  String? _userId;
  String? _serviceId;
  String? _serviceName;
  String? _title;
  String? _address;
  String? _city;
  String? _state;
  String? _pincode;
  String? _contactPerson;
  String? _contactPersonName;
  String? _emailId;
  Avaibility? _avaibility;
  AddressDetails? _addressDetails;
  String? _status;
  String? _createdAt;
  String? _updatedAt;
  String? _createdBy;
  String? _updatedBy;
  LocationDataModel? _location;
  List<Documents>? _documents;
  num? _dist;
  ServiceListData copyWith({  String? id,
  String? userId,
  String? serviceId,
  String? serviceName,
  String? title,
  String? address,
  String? city,
  String? state,
  String? pincode,
  String? contactPerson,
  String? contactPersonName,
  String? emailId,
  Avaibility? avaibility,
  AddressDetails? addressDetails,
  String? status,
  String? createdAt,
  String? updatedAt,
  String? createdBy,
  String? updatedBy,
  LocationDataModel? location,
  List<Documents>? documents,
  num? dist,
}) => ServiceListData(  id: id ?? _id,
  userId: userId ?? _userId,
  serviceId: serviceId ?? _serviceId,
  serviceName: serviceName ?? _serviceName,
  title: title ?? _title,
  address: address ?? _address,
  city: city ?? _city,
  state: state ?? _state,
  pincode: pincode ?? _pincode,
  contactPerson: contactPerson ?? _contactPerson,
  contactPersonName: contactPersonName ?? _contactPersonName,
  emailId: emailId ?? _emailId,
  avaibility: avaibility ?? _avaibility,
  addressDetails: addressDetails ?? _addressDetails,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  createdBy: createdBy ?? _createdBy,
  updatedBy: updatedBy ?? _updatedBy,
  location: location ?? _location,
  documents: documents ?? _documents,
  dist: dist ?? _dist,
);
  String? get id => _id;
  String? get userId => _userId;
  String? get serviceId => _serviceId;
  String? get serviceName => _serviceName;
  String? get title => _title;
  String? get address => _address;
  String? get city => _city;
  String? get state => _state;
  String? get pincode => _pincode;
  String? get contactPerson => _contactPerson;
  String? get contactPersonName => _contactPersonName;
  String? get emailId => _emailId;
  Avaibility? get avaibility => _avaibility;
  AddressDetails? get addressDetails => _addressDetails;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get createdBy => _createdBy;
  String? get updatedBy => _updatedBy;
  LocationDataModel? get location => _location;
  List<Documents>? get documents => _documents;
  num? get dist => _dist;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['user_id'] = _userId;
    map['service_id'] = _serviceId;
    map['service_name'] = _serviceName;
    map['title'] = _title;
    map['address'] = _address;
    map['city'] = _city;
    map['state'] = _state;
    map['pincode'] = _pincode;
    map['contact_person'] = _contactPerson;
    map['contact_person_name'] = _contactPersonName;
    map['email_id'] = _emailId;
    if (_avaibility != null) {
      map['avaibility'] = _avaibility?.toJson();
    }
    if (_addressDetails != null) {
      map['address_details'] = _addressDetails?.toJson();
    }
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['created_by'] = _createdBy;
    map['updated_by'] = _updatedBy;
    if (_location != null) {
      map['location'] = _location?.toJson();
    }
    if (_documents != null) {
      map['documents'] = _documents?.map((v) => v.toJson()).toList();
    }
    map['dist'] = _dist;
    return map;
  }

}

/// name : "Reg Copy"
/// photo : "https://5.imimg.com/data5/TO/HJ/MY-38237577/shop-registration-charges-500x500.jpg"

Documents documentsFromJson(String str) => Documents.fromJson(json.decode(str));
String documentsToJson(Documents data) => json.encode(data.toJson());
class Documents {
  Documents({
      String? name, 
      String? photo,}){
    _name = name;
    _photo = photo;
}

  Documents.fromJson(dynamic json) {
    _name = json['name'];
    _photo = json['photo'];
  }
  String? _name;
  String? _photo;
Documents copyWith({  String? name,
  String? photo,
}) => Documents(  name: name ?? _name,
  photo: photo ?? _photo,
);
  String? get name => _name;
  String? get photo => _photo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['photo'] = _photo;
    return map;
  }

}

/// type : "Point"
/// coordinates : [73.178927,18.89054]

LocationDataModel locationFromJson(String str) => LocationDataModel.fromJson(json.decode(str));
String locationToJson(LocationDataModel data) => json.encode(data.toJson());
class LocationDataModel {
  LocationDataModel({
      String? type, 
      List<num>? coordinates,}){
    _type = type;
    _coordinates = coordinates;
}

  LocationDataModel.fromJson(dynamic json) {
    _type = json['type'];
    _coordinates = json['coordinates'] != null ? json['coordinates'].cast<num>() : [];
  }
  String? _type;
  List<num>? _coordinates;
  LocationDataModel copyWith({  String? type,
  List<num>? coordinates,
}) => LocationDataModel(  type: type ?? _type,
  coordinates: coordinates ?? _coordinates,
);
  String? get type => _type;
  List<num>? get coordinates => _coordinates;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    map['coordinates'] = _coordinates;
    return map;
  }

}

/// lat : 23.36531
/// lng : 85.32824
/// Label : "Green Acre, Kali Asthan Road, Ansar Nagar, Naya Toli, Ranchi 834001, India"
/// Municipality : "Ranchi"
/// Neighborhood : "Naya Toli"
/// PostalCode : "834001"
/// Region : "Jharkhand"
/// SubRegion : "Ranchi"

AddressDetails addressDetailsFromJson(String str) => AddressDetails.fromJson(json.decode(str));
String addressDetailsToJson(AddressDetails data) => json.encode(data.toJson());
class AddressDetails {
  AddressDetails({
      num? lat, 
      num? lng, 
      String? label, 
      String? municipality, 
      String? neighborhood, 
      String? postalCode, 
      String? region, 
      String? subRegion,}){
    _lat = lat;
    _lng = lng;
    _label = label;
    _municipality = municipality;
    _neighborhood = neighborhood;
    _postalCode = postalCode;
    _region = region;
    _subRegion = subRegion;
}

  AddressDetails.fromJson(dynamic json) {
    _lat = json['lat'];
    _lng = json['lng'];
    _label = json['Label'];
    _municipality = json['Municipality'];
    _neighborhood = json['Neighborhood'];
    _postalCode = json['PostalCode'];
    _region = json['Region'];
    _subRegion = json['SubRegion'];
  }
  num? _lat;
  num? _lng;
  String? _label;
  String? _municipality;
  String? _neighborhood;
  String? _postalCode;
  String? _region;
  String? _subRegion;
AddressDetails copyWith({  num? lat,
  num? lng,
  String? label,
  String? municipality,
  String? neighborhood,
  String? postalCode,
  String? region,
  String? subRegion,
}) => AddressDetails(  lat: lat ?? _lat,
  lng: lng ?? _lng,
  label: label ?? _label,
  municipality: municipality ?? _municipality,
  neighborhood: neighborhood ?? _neighborhood,
  postalCode: postalCode ?? _postalCode,
  region: region ?? _region,
  subRegion: subRegion ?? _subRegion,
);
  num? get lat => _lat;
  num? get lng => _lng;
  String? get label => _label;
  String? get municipality => _municipality;
  String? get neighborhood => _neighborhood;
  String? get postalCode => _postalCode;
  String? get region => _region;
  String? get subRegion => _subRegion;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = _lat;
    map['lng'] = _lng;
    map['Label'] = _label;
    map['Municipality'] = _municipality;
    map['Neighborhood'] = _neighborhood;
    map['PostalCode'] = _postalCode;
    map['Region'] = _region;
    map['SubRegion'] = _subRegion;
    return map;
  }

}

/// avaibilityDays : {"Sunday":"Yes","Monday":"Yes","Wednesday":"Yes","Thursday":"Yes","Friday":"Yes","Saturday":"Yes"}
/// allDayAvailable : "Yes"
/// availableTimeFrom : "10 Am"
/// availableTimeTo : "7 PM"
/// comment : ""
/// 24by7avaibility : "No"

Avaibility avaibilityFromJson(String str) => Avaibility.fromJson(json.decode(str));
String avaibilityToJson(Avaibility data) => json.encode(data.toJson());
class Avaibility {
  Avaibility({
      AvaibilityDays? avaibilityDays, 
      String? allDayAvailable, 
      String? availableTimeFrom, 
      String? availableTimeTo, 
      String? comment, 
      String? by7avaibility,}){
    _avaibilityDays = avaibilityDays;
    _allDayAvailable = allDayAvailable;
    _availableTimeFrom = availableTimeFrom;
    _availableTimeTo = availableTimeTo;
    _comment = comment;
    _by7avaibility = by7avaibility;
}

  Avaibility.fromJson(dynamic json) {
    _avaibilityDays = json['avaibilityDays'] != null ? AvaibilityDays.fromJson(json['avaibilityDays']) : null;
    _allDayAvailable = json['allDayAvailable'];
    _availableTimeFrom = json['availableTimeFrom'];
    _availableTimeTo = json['availableTimeTo'];
    _comment = json['comment'];
    _by7avaibility = json['24by7avaibility'];
  }
  AvaibilityDays? _avaibilityDays;
  String? _allDayAvailable;
  String? _availableTimeFrom;
  String? _availableTimeTo;
  String? _comment;
  String? _by7avaibility;
Avaibility copyWith({  AvaibilityDays? avaibilityDays,
  String? allDayAvailable,
  String? availableTimeFrom,
  String? availableTimeTo,
  String? comment,
  String? by7avaibility,
}) => Avaibility(  avaibilityDays: avaibilityDays ?? _avaibilityDays,
  allDayAvailable: allDayAvailable ?? _allDayAvailable,
  availableTimeFrom: availableTimeFrom ?? _availableTimeFrom,
  availableTimeTo: availableTimeTo ?? _availableTimeTo,
  comment: comment ?? _comment,
  by7avaibility: by7avaibility ?? _by7avaibility,
);
  AvaibilityDays? get avaibilityDays => _avaibilityDays;
  String? get allDayAvailable => _allDayAvailable;
  String? get availableTimeFrom => _availableTimeFrom;
  String? get availableTimeTo => _availableTimeTo;
  String? get comment => _comment;
  String? get by7avaibility => _by7avaibility;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_avaibilityDays != null) {
      map['avaibilityDays'] = _avaibilityDays?.toJson();
    }
    map['allDayAvailable'] = _allDayAvailable;
    map['availableTimeFrom'] = _availableTimeFrom;
    map['availableTimeTo'] = _availableTimeTo;
    map['comment'] = _comment;
    map['24by7avaibility'] = _by7avaibility;
    return map;
  }

}

/// Sunday : "Yes"
/// Monday : "Yes"
/// Wednesday : "Yes"
/// Thursday : "Yes"
/// Friday : "Yes"
/// Saturday : "Yes"

AvaibilityDays avaibilityDaysFromJson(String str) => AvaibilityDays.fromJson(json.decode(str));
String avaibilityDaysToJson(AvaibilityDays data) => json.encode(data.toJson());
class AvaibilityDays {
  AvaibilityDays({
      String? sunday, 
      String? monday, 
      String? wednesday, 
      String? thursday, 
      String? friday, 
      String? saturday,}){
    _sunday = sunday;
    _monday = monday;
    _wednesday = wednesday;
    _thursday = thursday;
    _friday = friday;
    _saturday = saturday;
}

  AvaibilityDays.fromJson(dynamic json) {
    _sunday = json['Sunday'];
    _monday = json['Monday'];
    _wednesday = json['Wednesday'];
    _thursday = json['Thursday'];
    _friday = json['Friday'];
    _saturday = json['Saturday'];
  }
  String? _sunday;
  String? _monday;
  String? _wednesday;
  String? _thursday;
  String? _friday;
  String? _saturday;
AvaibilityDays copyWith({  String? sunday,
  String? monday,
  String? wednesday,
  String? thursday,
  String? friday,
  String? saturday,
}) => AvaibilityDays(  sunday: sunday ?? _sunday,
  monday: monday ?? _monday,
  wednesday: wednesday ?? _wednesday,
  thursday: thursday ?? _thursday,
  friday: friday ?? _friday,
  saturday: saturday ?? _saturday,
);
  String? get sunday => _sunday;
  String? get monday => _monday;
  String? get wednesday => _wednesday;
  String? get thursday => _thursday;
  String? get friday => _friday;
  String? get saturday => _saturday;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Sunday'] = _sunday;
    map['Monday'] = _monday;
    map['Wednesday'] = _wednesday;
    map['Thursday'] = _thursday;
    map['Friday'] = _friday;
    map['Saturday'] = _saturday;
    return map;
  }

}