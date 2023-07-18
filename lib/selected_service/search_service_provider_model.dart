class SearchServiceProviderModel {
  SearchServiceProviderModel({
      bool? status, 
      List<SearchServiceProviderModelData>? data,}){
    _status = status;
    _data = data;
}

  SearchServiceProviderModel.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(SearchServiceProviderModelData.fromJson(v));
      });
    }
  }
  bool? _status;
  List<SearchServiceProviderModelData>? _data;
SearchServiceProviderModel copyWith({  bool? status,
  List<SearchServiceProviderModelData>? data,
}) => SearchServiceProviderModel(  status: status ?? _status,
  data: data ?? _data,
);
  bool? get status => _status;
  List<SearchServiceProviderModelData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class SearchServiceProviderModelData {
  SearchServiceProviderModelData({
      String? id, 
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
      AddressDetails? addressDetails, 
      Avaibility? avaibility, 
      String? status, 
      String? serviceProviderId, 
      num? dist,}){
    _id = id;
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
    _addressDetails = addressDetails;
    _avaibility = avaibility;
    _status = status;
    _serviceProviderId = serviceProviderId;
    _dist = dist;
}

  SearchServiceProviderModelData.fromJson(dynamic json) {
    _id = json['_id'];
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
    _addressDetails = json['address_details'] != null ? AddressDetails.fromJson(json['address_details']) : null;
    _avaibility = json['avaibility'] != null ? Avaibility.fromJson(json['avaibility']) : null;
    _status = json['status'];
    _serviceProviderId = json['service_provider_id'];
    _dist = json['dist'];
  }
  String? _id;
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
  AddressDetails? _addressDetails;
  Avaibility? _avaibility;
  String? _status;
  String? _serviceProviderId;
  num? _dist;
  SearchServiceProviderModelData copyWith({  String? id,
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
  AddressDetails? addressDetails,
  Avaibility? avaibility,
  String? status,
  String? serviceProviderId,
  num? dist,
}) => SearchServiceProviderModelData(  id: id ?? _id,
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
  addressDetails: addressDetails ?? _addressDetails,
  avaibility: avaibility ?? _avaibility,
  status: status ?? _status,
  serviceProviderId: serviceProviderId ?? _serviceProviderId,
  dist: dist ?? _dist,
);
  String? get id => _id;
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
  AddressDetails? get addressDetails => _addressDetails;
  Avaibility? get avaibility => _avaibility;
  String? get status => _status;
  String? get serviceProviderId => _serviceProviderId;
  num? get dist => _dist;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
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
    if (_addressDetails != null) {
      map['address_details'] = _addressDetails?.toJson();
    }
    if (_avaibility != null) {
      map['avaibility'] = _avaibility?.toJson();
    }
    map['status'] = _status;
    map['service_provider_id'] = _serviceProviderId;
    map['dist'] = _dist;
    return map;
  }

}

class Avaibility {
  Avaibility({
      AvaibilityDays? avaibilityDays, 
      bool? allDayAvailable, 
      String? availableTimeFrom, 
      String? availableTimeTo, 
      String? comment, 
      bool? by7avaibility,}){
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
  bool? _allDayAvailable;
  String? _availableTimeFrom;
  String? _availableTimeTo;
  String? _comment;
  bool? _by7avaibility;
Avaibility copyWith({  AvaibilityDays? avaibilityDays,
  bool? allDayAvailable,
  String? availableTimeFrom,
  String? availableTimeTo,
  String? comment,
  bool? by7avaibility,
}) => Avaibility(  avaibilityDays: avaibilityDays ?? _avaibilityDays,
  allDayAvailable: allDayAvailable ?? _allDayAvailable,
  availableTimeFrom: availableTimeFrom ?? _availableTimeFrom,
  availableTimeTo: availableTimeTo ?? _availableTimeTo,
  comment: comment ?? _comment,
  by7avaibility: by7avaibility ?? _by7avaibility,
);
  AvaibilityDays? get avaibilityDays => _avaibilityDays;
  bool? get allDayAvailable => _allDayAvailable;
  String? get availableTimeFrom => _availableTimeFrom;
  String? get availableTimeTo => _availableTimeTo;
  String? get comment => _comment;
  bool? get by7avaibility => _by7avaibility;

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

class AvaibilityDays {
  AvaibilityDays({
      bool? sunday, 
      bool? monday, 
      bool? tuesday, 
      bool? wednesday, 
      bool? thursday, 
      bool? friday, 
      bool? saturday,}){
    _sunday = sunday;
    _monday = monday;
    _tuesday = tuesday;
    _wednesday = wednesday;
    _thursday = thursday;
    _friday = friday;
    _saturday = saturday;
}

  AvaibilityDays.fromJson(dynamic json) {
    _sunday = json['Sunday'];
    _monday = json['Monday'];
    _tuesday = json['Tuesday'];
    _wednesday = json['Wednesday'];
    _thursday = json['Thursday'];
    _friday = json['Friday'];
    _saturday = json['Saturday'];
  }
  bool? _sunday;
  bool? _monday;
  bool? _tuesday;
  bool? _wednesday;
  bool? _thursday;
  bool? _friday;
  bool? _saturday;
AvaibilityDays copyWith({  bool? sunday,
  bool? monday,
  bool? tuesday,
  bool? wednesday,
  bool? thursday,
  bool? friday,
  bool? saturday,
}) => AvaibilityDays(  sunday: sunday ?? _sunday,
  monday: monday ?? _monday,
  tuesday: tuesday ?? _tuesday,
  wednesday: wednesday ?? _wednesday,
  thursday: thursday ?? _thursday,
  friday: friday ?? _friday,
  saturday: saturday ?? _saturday,
);
  bool? get sunday => _sunday;
  bool? get monday => _monday;
  bool? get tuesday => _tuesday;
  bool? get wednesday => _wednesday;
  bool? get thursday => _thursday;
  bool? get friday => _friday;
  bool? get saturday => _saturday;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Sunday'] = _sunday;
    map['Monday'] = _monday;
    map['Tuesday'] = _tuesday;
    map['Wednesday'] = _wednesday;
    map['Thursday'] = _thursday;
    map['Friday'] = _friday;
    map['Saturday'] = _saturday;
    return map;
  }

}

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