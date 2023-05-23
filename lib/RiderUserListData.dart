import 'dart:convert';
RiderUserListData riderUserListDataFromJson(String str) => RiderUserListData.fromJson(json.decode(str));
String riderUserListDataToJson(RiderUserListData data) => json.encode(data.toJson());
class RiderUserListData {
  RiderUserListData({
      bool? status, 
      List<RiderDetails>? data,}){
    _status = status;
    _data = data;
}

  RiderUserListData.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(RiderDetails.fromJson(v));
      });
    }
  }
  bool? _status;
  List<RiderDetails>? _data;
RiderUserListData copyWith({  bool? status,
  List<RiderDetails>? data,
}) => RiderUserListData(  status: status ?? _status,
  data: data ?? _data,
);
  bool? get status => _status;
  List<RiderDetails>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

RiderDetails dataFromJson(String str) => RiderDetails.fromJson(json.decode(str));
String dataToJson(RiderDetails data) => json.encode(data.toJson());
class RiderDetails {
  RiderDetails({
      String? id, 
      Dldetails? dldetails, 
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
      String? profileImage, 
      String? maritalStatus, 
      String? citizenship, 
      String? failAttempt, 
      String? isLock, 
      String? address, 
      String? city, 
      String? state, 
      String? pincode, 
      String? resetPassword, 
      String? status, 
      PermanentAddress? permanentAddress, 
      PresentAddress? presentAddress, 
      String? sameAddress, 
      String? createdAt, 
      String? updatedAt, 
      String? createdBy, 
      String? updatedBy, 
      String? dob, 
      String? remark, 
      String? fcmtoken, 
      String? emergencyContactNo, 
      String? organizationName, 
      String? coordinatorContactNo, 
      String? coordinatorName, 
      String? bloodGroup, 
      String? emergencyContactNo1, 
      String? emergencyContactPerson, 
      String? emergencyContactPerson1, 
      String? clientId, 
      String? volunteer, 
      List<String>? volunteerAri, 
      String? dlNumber, 
      String? dlExpiryDate, 
      String? dlMobileNumber, 
      String? accidentalHistory, 
      String? accidentalDiscription, 
      String? available24by7, 
      String? shiftTimeFrom, 
      String? shiftTimeTo, 
      num? profilePercentage,}){
    _id = id;
    _dldetails = dldetails;
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
    _profileImage = profileImage;
    _maritalStatus = maritalStatus;
    _citizenship = citizenship;
    _failAttempt = failAttempt;
    _isLock = isLock;
    _address = address;
    _city = city;
    _state = state;
    _pincode = pincode;
    _resetPassword = resetPassword;
    _status = status;
    _permanentAddress = permanentAddress;
    _presentAddress = presentAddress;
    _sameAddress = sameAddress;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _createdBy = createdBy;
    _updatedBy = updatedBy;
    _dob = dob;
    _remark = remark;
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
    _dlNumber = dlNumber;
    _dlExpiryDate = dlExpiryDate;
    _dlMobileNumber = dlMobileNumber;
    _accidentalHistory = accidentalHistory;
    _accidentalDiscription = accidentalDiscription;
    _available24by7 = available24by7;
    _shiftTimeFrom = shiftTimeFrom;
    _shiftTimeTo = shiftTimeTo;
    _profilePercentage = profilePercentage;
}

  RiderDetails.fromJson(dynamic json) {
    _id = json['_id'];
    _dldetails = json['dldetails'] != null ? Dldetails.fromJson(json['dldetails']) : null;
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
    _profileImage = json['profile_image'];
    _maritalStatus = json['marital_status'];
    _citizenship = json['citizenship'];
    _failAttempt = json['fail_attempt'];
    _isLock = json['is_lock'];
    _address = json['address'];
    _city = json['city'];
    _state = json['state'];
    _pincode = json['pincode'];
    _resetPassword = json['reset_password'];
    _status = json['status'];
    _permanentAddress = json['permanent_address'] != null ? PermanentAddress.fromJson(json['permanent_address']) : null;
    _presentAddress = json['present_address'] != null ? PresentAddress.fromJson(json['present_address']) : null;
    _sameAddress = json['same_address'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _createdBy = json['created_by'];
    _updatedBy = json['updated_by'];
    _dob = json['dob'];
    _remark = json['remark'];
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
    _volunteerAri = json['volunteer_ari'] != null ? json['volunteer_ari'].cast<String>() : [];
    _dlNumber = json['dl_number'];
    _dlExpiryDate = json['dl_expiry_date'];
    _dlMobileNumber = json['dl_mobile_number'];
    _accidentalHistory = json['accidental_history'];
    _accidentalDiscription = json['accidental_discription'];
    _available24by7 = json['available24by7'];
    _shiftTimeFrom = json['shift_time_from'];
    _shiftTimeTo = json['shift_time_to'];
    _profilePercentage = json['profile_percentage'];
  }
  String? _id;
  Dldetails? _dldetails;
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
  String? _profileImage;
  String? _maritalStatus;
  String? _citizenship;
  String? _failAttempt;
  String? _isLock;
  String? _address;
  String? _city;
  String? _state;
  String? _pincode;
  String? _resetPassword;
  String? _status;
  PermanentAddress? _permanentAddress;
  PresentAddress? _presentAddress;
  String? _sameAddress;
  String? _createdAt;
  String? _updatedAt;
  String? _createdBy;
  String? _updatedBy;
  String? _dob;
  String? _remark;
  String? _fcmtoken;
  String? _emergencyContactNo;
  String? _organizationName;
  String? _coordinatorContactNo;
  String? _coordinatorName;
  String? _bloodGroup;
  String? _emergencyContactNo1;
  String? _emergencyContactPerson;
  String? _emergencyContactPerson1;
  String? _clientId;
  String? _volunteer;
  List<String>? _volunteerAri;
  String? _dlNumber;
  String? _dlExpiryDate;
  String? _dlMobileNumber;
  String? _accidentalHistory;
  String? _accidentalDiscription;
  String? _available24by7;
  String? _shiftTimeFrom;
  String? _shiftTimeTo;
  num? _profilePercentage;
  RiderDetails copyWith({  String? id,
  Dldetails? dldetails,
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
  String? profileImage,
  String? maritalStatus,
  String? citizenship,
  String? failAttempt,
  String? isLock,
  String? address,
  String? city,
  String? state,
  String? pincode,
  String? resetPassword,
  String? status,
  PermanentAddress? permanentAddress,
  PresentAddress? presentAddress,
  String? sameAddress,
  String? createdAt,
  String? updatedAt,
  String? createdBy,
  String? updatedBy,
  String? dob,
  String? remark,
  String? fcmtoken,
  String? emergencyContactNo,
  String? organizationName,
  String? coordinatorContactNo,
  String? coordinatorName,
  String? bloodGroup,
  String? emergencyContactNo1,
  String? emergencyContactPerson,
  String? emergencyContactPerson1,
  String? clientId,
  String? volunteer,
  List<String>? volunteerAri,
  String? dlNumber,
  String? dlExpiryDate,
  String? dlMobileNumber,
  String? accidentalHistory,
  String? accidentalDiscription,
  String? available24by7,
  String? shiftTimeFrom,
  String? shiftTimeTo,
  num? profilePercentage,
}) => RiderDetails(  id: id ?? _id,
  dldetails: dldetails ?? _dldetails,
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
  profileImage: profileImage ?? _profileImage,
  maritalStatus: maritalStatus ?? _maritalStatus,
  citizenship: citizenship ?? _citizenship,
  failAttempt: failAttempt ?? _failAttempt,
  isLock: isLock ?? _isLock,
  address: address ?? _address,
  city: city ?? _city,
  state: state ?? _state,
  pincode: pincode ?? _pincode,
  resetPassword: resetPassword ?? _resetPassword,
  status: status ?? _status,
  permanentAddress: permanentAddress ?? _permanentAddress,
  presentAddress: presentAddress ?? _presentAddress,
  sameAddress: sameAddress ?? _sameAddress,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  createdBy: createdBy ?? _createdBy,
  updatedBy: updatedBy ?? _updatedBy,
  dob: dob ?? _dob,
  remark: remark ?? _remark,
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
  dlNumber: dlNumber ?? _dlNumber,
  dlExpiryDate: dlExpiryDate ?? _dlExpiryDate,
  dlMobileNumber: dlMobileNumber ?? _dlMobileNumber,
  accidentalHistory: accidentalHistory ?? _accidentalHistory,
  accidentalDiscription: accidentalDiscription ?? _accidentalDiscription,
  available24by7: available24by7 ?? _available24by7,
  shiftTimeFrom: shiftTimeFrom ?? _shiftTimeFrom,
  shiftTimeTo: shiftTimeTo ?? _shiftTimeTo,
  profilePercentage: profilePercentage ?? _profilePercentage,
);
  String? get id => _id;
  Dldetails? get dldetails => _dldetails;
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
  String? get profileImage => _profileImage;
  String? get maritalStatus => _maritalStatus;
  String? get citizenship => _citizenship;
  String? get failAttempt => _failAttempt;
  String? get isLock => _isLock;
  String? get address => _address;
  String? get city => _city;
  String? get state => _state;
  String? get pincode => _pincode;
  String? get resetPassword => _resetPassword;
  String? get status => _status;
  PermanentAddress? get permanentAddress => _permanentAddress;
  PresentAddress? get presentAddress => _presentAddress;
  String? get sameAddress => _sameAddress;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get createdBy => _createdBy;
  String? get updatedBy => _updatedBy;
  String? get dob => _dob;
  String? get remark => _remark;
  String? get fcmtoken => _fcmtoken;
  String? get emergencyContactNo => _emergencyContactNo;
  String? get organizationName => _organizationName;
  String? get coordinatorContactNo => _coordinatorContactNo;
  String? get coordinatorName => _coordinatorName;
  String? get bloodGroup => _bloodGroup;
  String? get emergencyContactNo1 => _emergencyContactNo1;
  String? get emergencyContactPerson => _emergencyContactPerson;
  String? get emergencyContactPerson1 => _emergencyContactPerson1;
  String? get clientId => _clientId;
  String? get volunteer => _volunteer;
  List<String>? get volunteerAri => _volunteerAri;
  String? get dlNumber => _dlNumber;
  String? get dlExpiryDate => _dlExpiryDate;
  String? get dlMobileNumber => _dlMobileNumber;
  String? get accidentalHistory => _accidentalHistory;
  String? get accidentalDiscription => _accidentalDiscription;
  String? get available24by7 => _available24by7;
  String? get shiftTimeFrom => _shiftTimeFrom;
  String? get shiftTimeTo => _shiftTimeTo;
  num? get profilePercentage => _profilePercentage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    if (_dldetails != null) {
      map['dldetails'] = _dldetails?.toJson();
    }
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
    map['profile_image'] = _profileImage;
    map['marital_status'] = _maritalStatus;
    map['citizenship'] = _citizenship;
    map['fail_attempt'] = _failAttempt;
    map['is_lock'] = _isLock;
    map['address'] = _address;
    map['city'] = _city;
    map['state'] = _state;
    map['pincode'] = _pincode;
    map['reset_password'] = _resetPassword;
    map['status'] = _status;
    if (_permanentAddress != null) {
      map['permanent_address'] = _permanentAddress?.toJson();
    }
    if (_presentAddress != null) {
      map['present_address'] = _presentAddress?.toJson();
    }
    map['same_address'] = _sameAddress;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['created_by'] = _createdBy;
    map['updated_by'] = _updatedBy;
    map['dob'] = _dob;
    map['remark'] = _remark;
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
    map['volunteer_ari'] = _volunteerAri;
    map['dl_number'] = _dlNumber;
    map['dl_expiry_date'] = _dlExpiryDate;
    map['dl_mobile_number'] = _dlMobileNumber;
    map['accidental_history'] = _accidentalHistory;
    map['accidental_discription'] = _accidentalDiscription;
    map['available24by7'] = _available24by7;
    map['shift_time_from'] = _shiftTimeFrom;
    map['shift_time_to'] = _shiftTimeTo;
    map['profile_percentage'] = _profilePercentage;
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

Dldetails dldetailsFromJson(String str) => Dldetails.fromJson(json.decode(str));
String dldetailsToJson(Dldetails data) => json.encode(data.toJson());
class Dldetails {
  Dldetails({
      String? dlNumber, 
      String? photo, 
      String? dlExpiryDate, 
      String? dlMobileNumber, 
      String? accidentalHistory, 
      String? accidentalDiscription, 
      String? available24by7, 
      String? shiftTimeFrom, 
      String? shiftTimeTo,}){
    _dlNumber = dlNumber;
    _photo = photo;
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
    _photo = json['photo'];
    _dlExpiryDate = json['dl_expiry_date'];
    _dlMobileNumber = json['dl_mobile_number'];
    _accidentalHistory = json['accidental_history'];
    _accidentalDiscription = json['accidental_discription'];
    _available24by7 = json['available24by7'];
    _shiftTimeFrom = json['shift_time_from'];
    _shiftTimeTo = json['shift_time_to'];
  }
  String? _dlNumber;
  String? _photo;
  String? _dlExpiryDate;
  String? _dlMobileNumber;
  String? _accidentalHistory;
  String? _accidentalDiscription;
  String? _available24by7;
  String? _shiftTimeFrom;
  String? _shiftTimeTo;
Dldetails copyWith({  String? dlNumber,
  String? photo,
  String? dlExpiryDate,
  String? dlMobileNumber,
  String? accidentalHistory,
  String? accidentalDiscription,
  String? available24by7,
  String? shiftTimeFrom,
  String? shiftTimeTo,
}) => Dldetails(  dlNumber: dlNumber ?? _dlNumber,
  photo: photo ?? _photo,
  dlExpiryDate: dlExpiryDate ?? _dlExpiryDate,
  dlMobileNumber: dlMobileNumber ?? _dlMobileNumber,
  accidentalHistory: accidentalHistory ?? _accidentalHistory,
  accidentalDiscription: accidentalDiscription ?? _accidentalDiscription,
  available24by7: available24by7 ?? _available24by7,
  shiftTimeFrom: shiftTimeFrom ?? _shiftTimeFrom,
  shiftTimeTo: shiftTimeTo ?? _shiftTimeTo,
);
  String? get dlNumber => _dlNumber;
  String? get photo => _photo;
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
    map['photo'] = _photo;
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