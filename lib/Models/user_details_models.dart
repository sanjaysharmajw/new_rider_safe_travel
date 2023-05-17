import 'dart:convert';
UserDetailsModels userDetailsModelsFromJson(String str) => UserDetailsModels.fromJson(json.decode(str));
String userDetailsModelsToJson(UserDetailsModels data) => json.encode(data.toJson());
class UserDetailsModels {
  UserDetailsModels({
    bool? status,
    List<UserDetailsData>? data,}){
    _status = status;
    _data = data;
  }

  UserDetailsModels.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(UserDetailsData.fromJson(v));
      });
    }
  }
  bool? _status;
  List<UserDetailsData>? _data;
  UserDetailsModels copyWith({  bool? status,
    List<UserDetailsData>? data,
  }) => UserDetailsModels(  status: status ?? _status,
    data: data ?? _data,
  );
  bool? get status => _status;
  List<UserDetailsData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

UserDetailsData dataFromJson(String str) => UserDetailsData.fromJson(json.decode(str));
String dataToJson(UserDetailsData data) => json.encode(data.toJson());
class UserDetailsData {
  UserDetailsData({
    String? id,
    String? firstName,
    String? lastName,
    String? emailId,
    String? mobileNumber,
    String? gender,
    String? password,
    String? alternateContactNo,
    String? userType,
    String? aadharNumber,
    String? panNumber,
    String? dlNumber,
    String? shiftType,
    List<Documents>? documents,
    String? accidentalHistory,
    String? accidentalDiscription,
    String? maritalStatus,
    String? citizenship,
    String? failAttempt,
    String? isLock,
    String? resetPassword,
    String? status,
    String? city,
    String? state,
    PermanentAddress? permanentAddress,
    PresentAddress? presentAddress,
    String? sameAddress,
    String? pincode,
    String? createdAt,
    String? updatedAt,
    String? createdBy,
    String? updatedBy,
    String? dob,
    String? profileImage,
    Dldetails? dldetails,
    String? address,
    String? fcmtoken,
    String? emergencyContactNo,
    dynamic organizationName,
    dynamic coordinatorContactNo,
    dynamic coordinatorName,
    dynamic bloodGroup,
    dynamic emergencyContactNo1,
    dynamic emergencyContactPerson,
    dynamic emergencyContactPerson1,
    String? clientId,
    String? volunteer,
    List<VolunteerAri>? volunteerAri,
    Location? location,
    String? dlImage,
    String? dlExpiryDate,
    String? dlMobileNumber,
    String? available24by7,
    String? shiftTimeFrom,
    String? shiftTimeTo,
    num? profilePercentage,}){
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _emailId = emailId;
    _mobileNumber = mobileNumber;
    _gender = gender;
    _password = password;
    _alternateContactNo = alternateContactNo;
    _userType = userType;
    _aadharNumber = aadharNumber;
    _panNumber = panNumber;
    _dlNumber = dlNumber;
    _shiftType = shiftType;
    _documents = documents;
    _accidentalHistory = accidentalHistory;
    _accidentalDiscription = accidentalDiscription;
    _maritalStatus = maritalStatus;
    _citizenship = citizenship;
    _failAttempt = failAttempt;
    _isLock = isLock;
    _resetPassword = resetPassword;
    _status = status;
    _city = city;
    _state = state;
    _permanentAddress = permanentAddress;
    _presentAddress = presentAddress;
    _sameAddress = sameAddress;
    _pincode = pincode;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _createdBy = createdBy;
    _updatedBy = updatedBy;
    _dob = dob;
    _profileImage = profileImage;
    _dldetails = dldetails;
    _address = address;
    _fcmtoken = fcmtoken;
    _emergencyContactNo = emergencyContactNo;
    _organizationName = organizationName;
    _coordinatorContactNo = coordinatorContactNo;
    _coordinatorName = coordinatorName;
    _bloodGroup = bloodGroup;
    _emergencyContactNo1 = emergencyContactNo1;
    _emergencyContactPerson = emergencyContactPerson;
    _emergencyContactPerson1 = emergencyContactPerson1;
    _clientId = clientId;
    _volunteer = volunteer;
    _volunteerAri = volunteerAri;
    _location = location;
    _dlImage = dlImage;
    _dlExpiryDate = dlExpiryDate;
    _dlMobileNumber = dlMobileNumber;
    _available24by7 = available24by7;
    _shiftTimeFrom = shiftTimeFrom;
    _shiftTimeTo = shiftTimeTo;
    _profilePercentage = profilePercentage;
  }

  UserDetailsData.fromJson(dynamic json) {
    _id = json['_id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _emailId = json['email_id'];
    _mobileNumber = json['mobile_number'];
    _gender = json['gender'];
    _password = json['password'];
    _alternateContactNo = json['alternate_contact_no'];
    _userType = json['user_type'];
    _aadharNumber = json['aadhar_number'];
    _panNumber = json['pan_number'];
    _dlNumber = json['dl_number'];
    _shiftType = json['shift_type'];
    if (json['documents'] != null) {
      _documents = [];
      json['documents'].forEach((v) {
        _documents?.add(Documents.fromJson(v));
      });
    }
    _accidentalHistory = json['accidental_history'];
    _accidentalDiscription = json['accidental_discription'];
    _maritalStatus = json['marital_status'];
    _citizenship = json['citizenship'];
    _failAttempt = json['fail_attempt'];
    _isLock = json['is_lock'];
    _resetPassword = json['reset_password'];
    _status = json['status'];
    _city = json['city'];
    _state = json['state'];
    _permanentAddress = json['permanent_address'] != null ? PermanentAddress.fromJson(json['permanent_address']) : null;
    _presentAddress = json['present_address'] != null ? PresentAddress.fromJson(json['present_address']) : null;
    _sameAddress = json['same_address'];
    _pincode = json['pincode'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _createdBy = json['created_by'];
    _updatedBy = json['updated_by'];
    _dob = json['dob'];
    _profileImage = json['profile_image'];
    _dldetails = json['dldetails'] != null ? Dldetails.fromJson(json['dldetails']) : null;
    _address = json['address'];
    _fcmtoken = json['fcmtoken'];
    _emergencyContactNo = json['emergency_contact_no'];
    _organizationName = json['organization_name'];
    _coordinatorContactNo = json['coordinator_contact_no'];
    _coordinatorName = json['coordinator_name'];
    _bloodGroup = json['blood_group'];
    _emergencyContactNo1 = json['emergency_contact_no1'];
    _emergencyContactPerson = json['emergency_contact_person'];
    _emergencyContactPerson1 = json['emergency_contact_person1'];
    _clientId = json['client_id'];
    _volunteer = json['volunteer'];
    if (json['volunteer_ari'] != null) {
      _volunteerAri = [];
      json['volunteer_ari'].forEach((v) {
        _volunteerAri?.add(VolunteerAri.fromJson(v));
      });
    }
    _location = json['location'] != null ? Location.fromJson(json['location']) : null;
    _dlImage = json['dl_image'];
    _dlExpiryDate = json['dl_expiry_date'];
    _dlMobileNumber = json['dl_mobile_number'];
    _available24by7 = json['available24by7'];
    _shiftTimeFrom = json['shift_time_from'];
    _shiftTimeTo = json['shift_time_to'];
    _profilePercentage = json['profile_percentage'];
  }
  String? _id;
  String? _firstName;
  String? _lastName;
  String? _emailId;
  String? _mobileNumber;
  String? _gender;
  String? _password;
  String? _alternateContactNo;
  String? _userType;
  String? _aadharNumber;
  String? _panNumber;
  String? _dlNumber;
  String? _shiftType;
  List<Documents>? _documents;
  String? _accidentalHistory;
  String? _accidentalDiscription;
  String? _maritalStatus;
  String? _citizenship;
  String? _failAttempt;
  String? _isLock;
  String? _resetPassword;
  String? _status;
  String? _city;
  String? _state;
  PermanentAddress? _permanentAddress;
  PresentAddress? _presentAddress;
  String? _sameAddress;
  String? _pincode;
  String? _createdAt;
  String? _updatedAt;
  String? _createdBy;
  String? _updatedBy;
  String? _dob;
  String? _profileImage;
  Dldetails? _dldetails;
  String? _address;
  String? _fcmtoken;
  String? _emergencyContactNo;
  dynamic _organizationName;
  dynamic _coordinatorContactNo;
  dynamic _coordinatorName;
  dynamic _bloodGroup;
  dynamic _emergencyContactNo1;
  dynamic _emergencyContactPerson;
  dynamic _emergencyContactPerson1;
  String? _clientId;
  String? _volunteer;
  List<VolunteerAri>? _volunteerAri;
  Location? _location;
  String? _dlImage;
  String? _dlExpiryDate;
  String? _dlMobileNumber;
  String? _available24by7;
  String? _shiftTimeFrom;
  String? _shiftTimeTo;
  num? _profilePercentage;
  UserDetailsData copyWith({  String? id,
    String? firstName,
    String? lastName,
    String? emailId,
    String? mobileNumber,
    String? gender,
    String? password,
    String? alternateContactNo,
    String? userType,
    String? aadharNumber,
    String? panNumber,
    String? dlNumber,
    String? shiftType,
    List<Documents>? documents,
    String? accidentalHistory,
    String? accidentalDiscription,
    String? maritalStatus,
    String? citizenship,
    String? failAttempt,
    String? isLock,
    String? resetPassword,
    String? status,
    String? city,
    String? state,
    PermanentAddress? permanentAddress,
    PresentAddress? presentAddress,
    String? sameAddress,
    String? pincode,
    String? createdAt,
    String? updatedAt,
    String? createdBy,
    String? updatedBy,
    String? dob,
    String? profileImage,
    Dldetails? dldetails,
    String? address,
    String? fcmtoken,
    String? emergencyContactNo,
    dynamic organizationName,
    dynamic coordinatorContactNo,
    dynamic coordinatorName,
    dynamic bloodGroup,
    dynamic emergencyContactNo1,
    dynamic emergencyContactPerson,
    dynamic emergencyContactPerson1,
    String? clientId,
    String? volunteer,
    List<VolunteerAri>? volunteerAri,
    Location? location,
    String? dlImage,
    String? dlExpiryDate,
    String? dlMobileNumber,
    String? available24by7,
    String? shiftTimeFrom,
    String? shiftTimeTo,
    num? profilePercentage,
  }) => UserDetailsData(  id: id ?? _id,
    firstName: firstName ?? _firstName,
    lastName: lastName ?? _lastName,
    emailId: emailId ?? _emailId,
    mobileNumber: mobileNumber ?? _mobileNumber,
    gender: gender ?? _gender,
    password: password ?? _password,
    alternateContactNo: alternateContactNo ?? _alternateContactNo,
    userType: userType ?? _userType,
    aadharNumber: aadharNumber ?? _aadharNumber,
    panNumber: panNumber ?? _panNumber,
    dlNumber: dlNumber ?? _dlNumber,
    shiftType: shiftType ?? _shiftType,
    documents: documents ?? _documents,
    accidentalHistory: accidentalHistory ?? _accidentalHistory,
    accidentalDiscription: accidentalDiscription ?? _accidentalDiscription,
    maritalStatus: maritalStatus ?? _maritalStatus,
    citizenship: citizenship ?? _citizenship,
    failAttempt: failAttempt ?? _failAttempt,
    isLock: isLock ?? _isLock,
    resetPassword: resetPassword ?? _resetPassword,
    status: status ?? _status,
    city: city ?? _city,
    state: state ?? _state,
    permanentAddress: permanentAddress ?? _permanentAddress,
    presentAddress: presentAddress ?? _presentAddress,
    sameAddress: sameAddress ?? _sameAddress,
    pincode: pincode ?? _pincode,
    createdAt: createdAt ?? _createdAt,
    updatedAt: updatedAt ?? _updatedAt,
    createdBy: createdBy ?? _createdBy,
    updatedBy: updatedBy ?? _updatedBy,
    dob: dob ?? _dob,
    profileImage: profileImage ?? _profileImage,
    dldetails: dldetails ?? _dldetails,
    address: address ?? _address,
    fcmtoken: fcmtoken ?? _fcmtoken,
    emergencyContactNo: emergencyContactNo ?? _emergencyContactNo,
    organizationName: organizationName ?? _organizationName,
    coordinatorContactNo: coordinatorContactNo ?? _coordinatorContactNo,
    coordinatorName: coordinatorName ?? _coordinatorName,
    bloodGroup: bloodGroup ?? _bloodGroup,
    emergencyContactNo1: emergencyContactNo1 ?? _emergencyContactNo1,
    emergencyContactPerson: emergencyContactPerson ?? _emergencyContactPerson,
    emergencyContactPerson1: emergencyContactPerson1 ?? _emergencyContactPerson1,
    clientId: clientId ?? _clientId,
    volunteer: volunteer ?? _volunteer,
    volunteerAri: volunteerAri ?? _volunteerAri,
    location: location ?? _location,
    dlImage: dlImage ?? _dlImage,
    dlExpiryDate: dlExpiryDate ?? _dlExpiryDate,
    dlMobileNumber: dlMobileNumber ?? _dlMobileNumber,
    available24by7: available24by7 ?? _available24by7,
    shiftTimeFrom: shiftTimeFrom ?? _shiftTimeFrom,
    shiftTimeTo: shiftTimeTo ?? _shiftTimeTo,
    profilePercentage: profilePercentage ?? _profilePercentage,
  );
  String? get id => _id;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get emailId => _emailId;
  String? get mobileNumber => _mobileNumber;
  String? get gender => _gender;
  String? get password => _password;
  String? get alternateContactNo => _alternateContactNo;
  String? get userType => _userType;
  String? get aadharNumber => _aadharNumber;
  String? get panNumber => _panNumber;
  String? get dlNumber => _dlNumber;
  String? get shiftType => _shiftType;
  List<Documents>? get documents => _documents;
  String? get accidentalHistory => _accidentalHistory;
  String? get accidentalDiscription => _accidentalDiscription;
  String? get maritalStatus => _maritalStatus;
  String? get citizenship => _citizenship;
  String? get failAttempt => _failAttempt;
  String? get isLock => _isLock;
  String? get resetPassword => _resetPassword;
  String? get status => _status;
  String? get city => _city;
  String? get state => _state;
  PermanentAddress? get permanentAddress => _permanentAddress;
  PresentAddress? get presentAddress => _presentAddress;
  String? get sameAddress => _sameAddress;
  String? get pincode => _pincode;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get createdBy => _createdBy;
  String? get updatedBy => _updatedBy;
  String? get dob => _dob;
  String? get profileImage => _profileImage;
  Dldetails? get dldetails => _dldetails;
  String? get address => _address;
  String? get fcmtoken => _fcmtoken;
  String? get emergencyContactNo => _emergencyContactNo;
  dynamic get organizationName => _organizationName;
  dynamic get coordinatorContactNo => _coordinatorContactNo;
  dynamic get coordinatorName => _coordinatorName;
  dynamic get bloodGroup => _bloodGroup;
  dynamic get emergencyContactNo1 => _emergencyContactNo1;
  dynamic get emergencyContactPerson => _emergencyContactPerson;
  dynamic get emergencyContactPerson1 => _emergencyContactPerson1;
  String? get clientId => _clientId;
  String? get volunteer => _volunteer;
  List<VolunteerAri>? get volunteerAri => _volunteerAri;
  Location? get location => _location;
  String? get dlImage => _dlImage;
  String? get dlExpiryDate => _dlExpiryDate;
  String? get dlMobileNumber => _dlMobileNumber;
  String? get available24by7 => _available24by7;
  String? get shiftTimeFrom => _shiftTimeFrom;
  String? get shiftTimeTo => _shiftTimeTo;
  num? get profilePercentage => _profilePercentage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['email_id'] = _emailId;
    map['mobile_number'] = _mobileNumber;
    map['gender'] = _gender;
    map['password'] = _password;
    map['alternate_contact_no'] = _alternateContactNo;
    map['user_type'] = _userType;
    map['aadhar_number'] = _aadharNumber;
    map['pan_number'] = _panNumber;
    map['dl_number'] = _dlNumber;
    map['shift_type'] = _shiftType;
    if (_documents != null) {
      map['documents'] = _documents?.map((v) => v.toJson()).toList();
    }
    map['accidental_history'] = _accidentalHistory;
    map['accidental_discription'] = _accidentalDiscription;
    map['marital_status'] = _maritalStatus;
    map['citizenship'] = _citizenship;
    map['fail_attempt'] = _failAttempt;
    map['is_lock'] = _isLock;
    map['reset_password'] = _resetPassword;
    map['status'] = _status;
    map['city'] = _city;
    map['state'] = _state;
    if (_permanentAddress != null) {
      map['permanent_address'] = _permanentAddress?.toJson();
    }
    if (_presentAddress != null) {
      map['present_address'] = _presentAddress?.toJson();
    }
    map['same_address'] = _sameAddress;
    map['pincode'] = _pincode;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['created_by'] = _createdBy;
    map['updated_by'] = _updatedBy;
    map['dob'] = _dob;
    map['profile_image'] = _profileImage;
    if (_dldetails != null) {
      map['dldetails'] = _dldetails?.toJson();
    }
    map['address'] = _address;
    map['fcmtoken'] = _fcmtoken;
    map['emergency_contact_no'] = _emergencyContactNo;
    map['organization_name'] = _organizationName;
    map['coordinator_contact_no'] = _coordinatorContactNo;
    map['coordinator_name'] = _coordinatorName;
    map['blood_group'] = _bloodGroup;
    map['emergency_contact_no1'] = _emergencyContactNo1;
    map['emergency_contact_person'] = _emergencyContactPerson;
    map['emergency_contact_person1'] = _emergencyContactPerson1;
    map['client_id'] = _clientId;
    map['volunteer'] = _volunteer;
    if (_volunteerAri != null) {
      map['volunteer_ari'] = _volunteerAri?.map((v) => v.toJson()).toList();
    }
    if (_location != null) {
      map['location'] = _location?.toJson();
    }
    map['dl_image'] = _dlImage;
    map['dl_expiry_date'] = _dlExpiryDate;
    map['dl_mobile_number'] = _dlMobileNumber;
    map['available24by7'] = _available24by7;
    map['shift_time_from'] = _shiftTimeFrom;
    map['shift_time_to'] = _shiftTimeTo;
    map['profile_percentage'] = _profilePercentage;
    return map;
  }

}

Location locationFromJson(String str) => Location.fromJson(json.decode(str));
String locationToJson(Location data) => json.encode(data.toJson());
class Location {
  Location({
    String? type,
    List<num>? coordinates,}){
    _type = type;
    _coordinates = coordinates;
  }

  Location.fromJson(dynamic json) {
    _type = json['type'];
    _coordinates = json['coordinates'] != null ? json['coordinates'].cast<num>() : [];
  }
  String? _type;
  List<num>? _coordinates;
  Location copyWith({  String? type,
    List<num>? coordinates,
  }) => Location(  type: type ?? _type,
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

VolunteerAri volunteerAriFromJson(String str) => VolunteerAri.fromJson(json.decode(str));
String volunteerAriToJson(VolunteerAri data) => json.encode(data.toJson());
class VolunteerAri {
  VolunteerAri({
    String? id,
    String? name,}){
    _id = id;
    _name = name;
  }

  VolunteerAri.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  String? _id;
  String? _name;
  VolunteerAri copyWith({  String? id,
    String? name,
  }) => VolunteerAri(  id: id ?? _id,
    name: name ?? _name,
  );
  String? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }

}

Dldetails dldetailsFromJson(String str) => Dldetails.fromJson(json.decode(str));
String dldetailsToJson(Dldetails data) => json.encode(data.toJson());
class Dldetails {
  Dldetails({
    String? dlNumber,
    String? dlImage,
    String? dlExpiryDate,
    String? dlMobileNumber,
    String? accidentalHistory,
    String? accidentalDiscription,
    String? available24by7,
    String? shiftTimeFrom,
    String? shiftTimeTo,}){
    _dlNumber = dlNumber;
    _dlImage = dlImage;
    _dlExpiryDate = dlExpiryDate;
    _dlMobileNumber = dlMobileNumber;
    _accidentalHistory = accidentalHistory;
    _accidentalDiscription = accidentalDiscription;
    _available24by7 = available24by7;
    _shiftTimeFrom = shiftTimeFrom;
    _shiftTimeTo = shiftTimeTo;
  }

  Dldetails.fromJson(dynamic json) {
    _dlNumber = json['dl_number'];
    _dlImage = json['dl_image'];
    _dlExpiryDate = json['dl_expiry_date'];
    _dlMobileNumber = json['dl_mobile_number'];
    _accidentalHistory = json['accidental_history'];
    _accidentalDiscription = json['accidental_discription'];
    _available24by7 = json['available24by7'];
    _shiftTimeFrom = json['shift_time_from'];
    _shiftTimeTo = json['shift_time_to'];
  }
  String? _dlNumber;
  String? _dlImage;
  String? _dlExpiryDate;
  String? _dlMobileNumber;
  String? _accidentalHistory;
  String? _accidentalDiscription;
  String? _available24by7;
  String? _shiftTimeFrom;
  String? _shiftTimeTo;
  Dldetails copyWith({  String? dlNumber,
    String? dlImage,
    String? dlExpiryDate,
    String? dlMobileNumber,
    String? accidentalHistory,
    String? accidentalDiscription,
    String? available24by7,
    String? shiftTimeFrom,
    String? shiftTimeTo,
  }) => Dldetails(  dlNumber: dlNumber ?? _dlNumber,
    dlImage: dlImage ?? _dlImage,
    dlExpiryDate: dlExpiryDate ?? _dlExpiryDate,
    dlMobileNumber: dlMobileNumber ?? _dlMobileNumber,
    accidentalHistory: accidentalHistory ?? _accidentalHistory,
    accidentalDiscription: accidentalDiscription ?? _accidentalDiscription,
    available24by7: available24by7 ?? _available24by7,
    shiftTimeFrom: shiftTimeFrom ?? _shiftTimeFrom,
    shiftTimeTo: shiftTimeTo ?? _shiftTimeTo,
  );
  String? get dlNumber => _dlNumber;
  String? get dlImage => _dlImage;
  String? get dlExpiryDate => _dlExpiryDate;
  String? get dlMobileNumber => _dlMobileNumber;
  String? get accidentalHistory => _accidentalHistory;
  String? get accidentalDiscription => _accidentalDiscription;
  String? get available24by7 => _available24by7;
  String? get shiftTimeFrom => _shiftTimeFrom;
  String? get shiftTimeTo => _shiftTimeTo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dl_number'] = _dlNumber;
    map['dl_image'] = _dlImage;
    map['dl_expiry_date'] = _dlExpiryDate;
    map['dl_mobile_number'] = _dlMobileNumber;
    map['accidental_history'] = _accidentalHistory;
    map['accidental_discription'] = _accidentalDiscription;
    map['available24by7'] = _available24by7;
    map['shift_time_from'] = _shiftTimeFrom;
    map['shift_time_to'] = _shiftTimeTo;
    return map;
  }

}

PresentAddress presentAddressFromJson(String str) => PresentAddress.fromJson(json.decode(str));
String presentAddressToJson(PresentAddress data) => json.encode(data.toJson());
class PresentAddress {
  PresentAddress({
    String? address,
    String? city,
    String? state,
    String? pincode,}){
    _address = address;
    _city = city;
    _state = state;
    _pincode = pincode;
  }

  PresentAddress.fromJson(dynamic json) {
    _address = json['address'];
    _city = json['city'];
    _state = json['state'];
    _pincode = json['pincode'];
  }
  String? _address;
  String? _city;
  String? _state;
  String? _pincode;
  PresentAddress copyWith({  String? address,
    String? city,
    String? state,
    String? pincode,
  }) => PresentAddress(  address: address ?? _address,
    city: city ?? _city,
    state: state ?? _state,
    pincode: pincode ?? _pincode,
  );
  String? get address => _address;
  String? get city => _city;
  String? get state => _state;
  String? get pincode => _pincode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address'] = _address;
    map['city'] = _city;
    map['state'] = _state;
    map['pincode'] = _pincode;
    return map;
  }

}

PermanentAddress permanentAddressFromJson(String str) => PermanentAddress.fromJson(json.decode(str));
String permanentAddressToJson(PermanentAddress data) => json.encode(data.toJson());
class PermanentAddress {
  PermanentAddress({
    String? address,
    String? city,
    String? state,
    String? pincode,}){
    _address = address;
    _city = city;
    _state = state;
    _pincode = pincode;
  }

  PermanentAddress.fromJson(dynamic json) {
    _address = json['address'];
    _city = json['city'];
    _state = json['state'];
    _pincode = json['pincode'];
  }
  String? _address;
  String? _city;
  String? _state;
  String? _pincode;
  PermanentAddress copyWith({  String? address,
    String? city,
    String? state,
    String? pincode,
  }) => PermanentAddress(  address: address ?? _address,
    city: city ?? _city,
    state: state ?? _state,
    pincode: pincode ?? _pincode,
  );
  String? get address => _address;
  String? get city => _city;
  String? get state => _state;
  String? get pincode => _pincode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address'] = _address;
    map['city'] = _city;
    map['state'] = _state;
    map['pincode'] = _pincode;
    return map;
  }

}

Documents documentsFromJson(String str) => Documents.fromJson(json.decode(str));
String documentsToJson(Documents data) => json.encode(data.toJson());
class Documents {
  Documents({
    String? idNumber,
    String? photo,}){
    _idNumber = idNumber;
    _photo = photo;
  }

  Documents.fromJson(dynamic json) {
    _idNumber = json['id_number'];
    _photo = json['photo'];
  }
  String? _idNumber;
  String? _photo;
  Documents copyWith({  String? idNumber,
    String? photo,
  }) => Documents(  idNumber: idNumber ?? _idNumber,
    photo: photo ?? _photo,
  );
  String? get idNumber => _idNumber;
  String? get photo => _photo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id_number'] = _idNumber;
    map['photo'] = _photo;
    return map;
  }

}