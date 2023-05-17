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
    String? emergencyContactNo,
    String? userType,
    String? aadharNumber,
    String? panNumber,
    String? profileImage,
    List<dynamic>? documents,
    String? maritalStatus,
    String? citizenship,
    String? failAttempt,
    String? isLock,
    Dldetails? dldetails,
    String? resetPassword,
    String? status,
    dynamic permanentAddress,
    dynamic presentAddress,
    String? sameAddress,
    String? createdAt,
    String? updatedAt,
    String? createdBy,
    String? updatedBy,
    String? dob,
    dynamic fcmtoken,
    String? volunteer,
    List<VolunteerAri>? volunteerAri,
    String? dlNumber,
    String? dlExpiryDate,
    String? dlMobileNumber,
    String? accidentalHistory,
    String? accidentalDiscription,
    String? available24by7,
    String? shiftTimeFrom,
    String? shiftTimeTo,
    String? profilePercentage,}){
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _emailId = emailId;
    _mobileNumber = mobileNumber;
    _gender = gender;
    _password = password;
    _alternateContactNo = alternateContactNo;
    _emergencyContactNo = emergencyContactNo;
    _userType = userType;
    _aadharNumber = aadharNumber;
    _panNumber = panNumber;
    _profileImage = profileImage;
    _documents = documents;
    _maritalStatus = maritalStatus;
    _citizenship = citizenship;
    _failAttempt = failAttempt;
    _isLock = isLock;
    _dldetails = dldetails;
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
    _fcmtoken = fcmtoken;
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

  UserDetailsData.fromJson(dynamic json) {
    _id = json['_id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _emailId = json['email_id'];
    _mobileNumber = json['mobile_number'];
    _gender = json['gender'];
    _password = json['password'];
    _alternateContactNo = json['alternate_contact_no'];
    _emergencyContactNo = json['emergency_contact_no'];
    _userType = json['user_type'];
    _aadharNumber = json['aadhar_number'];
    _panNumber = json['pan_number'];
    _profileImage = json['profile_image'];

    _maritalStatus = json['marital_status'];
    _citizenship = json['citizenship'];
    _failAttempt = json['fail_attempt'];
    _isLock = json['is_lock'];
    _dldetails = json['dldetails'] != null ? Dldetails.fromJson(json['dldetails']) : null;
    _resetPassword = json['reset_password'];
    _status = json['status'];
    _permanentAddress = json['permanent_address'];
    _presentAddress = json['present_address'];
    _sameAddress = json['same_address'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _createdBy = json['created_by'];
    _updatedBy = json['updated_by'];
    _dob = json['dob'];
    _fcmtoken = json['fcmtoken'];
    _volunteer = json['volunteer'];
    if (json['volunteer_ari'] != null) {
      _volunteerAri = [];
      json['volunteer_ari'].forEach((v) {
        _volunteerAri?.add(VolunteerAri.fromJson(v));
      });
    }
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
  String? _firstName;
  String? _lastName;
  String? _emailId;
  String? _mobileNumber;
  String? _gender;
  String? _password;
  String? _alternateContactNo;
  String? _emergencyContactNo;
  String? _userType;
  String? _aadharNumber;
  String? _panNumber;
  String? _profileImage;
  List<dynamic>? _documents;
  String? _maritalStatus;
  String? _citizenship;
  String? _failAttempt;
  String? _isLock;
  Dldetails? _dldetails;
  String? _resetPassword;
  String? _status;
  dynamic _permanentAddress;
  dynamic _presentAddress;
  String? _sameAddress;
  String? _createdAt;
  String? _updatedAt;
  String? _createdBy;
  String? _updatedBy;
  String? _dob;
  dynamic _fcmtoken;
  String? _volunteer;
  List<VolunteerAri>? _volunteerAri;
  String? _dlNumber;
  String? _dlExpiryDate;
  String? _dlMobileNumber;
  String? _accidentalHistory;
  String? _accidentalDiscription;
  String? _available24by7;
  String? _shiftTimeFrom;
  String? _shiftTimeTo;
  String? _profilePercentage;
  UserDetailsData copyWith({  String? id,
    String? firstName,
    String? lastName,
    String? emailId,
    String? mobileNumber,
    String? gender,
    String? password,
    String? alternateContactNo,
    String? emergencyContactNo,
    String? userType,
    String? aadharNumber,
    String? panNumber,
    String? profileImage,
    List<dynamic>? documents,
    String? maritalStatus,
    String? citizenship,
    String? failAttempt,
    String? isLock,
    Dldetails? dldetails,
    String? resetPassword,
    String? status,
    dynamic permanentAddress,
    dynamic presentAddress,
    String? sameAddress,
    String? createdAt,
    String? updatedAt,
    String? createdBy,
    String? updatedBy,
    String? dob,
    dynamic fcmtoken,
    String? volunteer,
    List<VolunteerAri>? volunteerAri,
    String? dlNumber,
    String? dlExpiryDate,
    String? dlMobileNumber,
    String? accidentalHistory,
    String? accidentalDiscription,
    String? available24by7,
    String? shiftTimeFrom,
    String? shiftTimeTo,
    String? profilePercentage,
  }) => UserDetailsData(  id: id ?? _id,
    firstName: firstName ?? _firstName,
    lastName: lastName ?? _lastName,
    emailId: emailId ?? _emailId,
    mobileNumber: mobileNumber ?? _mobileNumber,
    gender: gender ?? _gender,
    password: password ?? _password,
    alternateContactNo: alternateContactNo ?? _alternateContactNo,
    emergencyContactNo: emergencyContactNo ?? _emergencyContactNo,
    userType: userType ?? _userType,
    aadharNumber: aadharNumber ?? _aadharNumber,
    panNumber: panNumber ?? _panNumber,
    profileImage: profileImage ?? _profileImage,
    documents: documents ?? _documents,
    maritalStatus: maritalStatus ?? _maritalStatus,
    citizenship: citizenship ?? _citizenship,
    failAttempt: failAttempt ?? _failAttempt,
    isLock: isLock ?? _isLock,
    dldetails: dldetails ?? _dldetails,
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
    fcmtoken: fcmtoken ?? _fcmtoken,
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
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get emailId => _emailId;
  String? get mobileNumber => _mobileNumber;
  String? get gender => _gender;
  String? get password => _password;
  String? get alternateContactNo => _alternateContactNo;
  String? get emergencyContactNo => _emergencyContactNo;
  String? get userType => _userType;
  String? get aadharNumber => _aadharNumber;
  String? get panNumber => _panNumber;
  String? get profileImage => _profileImage;
  List<dynamic>? get documents => _documents;
  String? get maritalStatus => _maritalStatus;
  String? get citizenship => _citizenship;
  String? get failAttempt => _failAttempt;
  String? get isLock => _isLock;
  Dldetails? get dldetails => _dldetails;
  String? get resetPassword => _resetPassword;
  String? get status => _status;
  dynamic get permanentAddress => _permanentAddress;
  dynamic get presentAddress => _presentAddress;
  String? get sameAddress => _sameAddress;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get createdBy => _createdBy;
  String? get updatedBy => _updatedBy;
  String? get dob => _dob;
  dynamic get fcmtoken => _fcmtoken;
  String? get volunteer => _volunteer;
  List<VolunteerAri>? get volunteerAri => _volunteerAri;
  String? get dlNumber => _dlNumber;
  String? get dlExpiryDate => _dlExpiryDate;
  String? get dlMobileNumber => _dlMobileNumber;
  String? get accidentalHistory => _accidentalHistory;
  String? get accidentalDiscription => _accidentalDiscription;
  String? get available24by7 => _available24by7;
  String? get shiftTimeFrom => _shiftTimeFrom;
  String? get shiftTimeTo => _shiftTimeTo;
  String? get profilePercentage => _profilePercentage;

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
    map['emergency_contact_no'] = _emergencyContactNo;
    map['user_type'] = _userType;
    map['aadhar_number'] = _aadharNumber;
    map['pan_number'] = _panNumber;
    map['profile_image'] = _profileImage;
    if (_documents != null) {
      map['documents'] = _documents?.map((v) => v.toJson()).toList();
    }
    map['marital_status'] = _maritalStatus;
    map['citizenship'] = _citizenship;
    map['fail_attempt'] = _failAttempt;
    map['is_lock'] = _isLock;
    if (_dldetails != null) {
      map['dldetails'] = _dldetails?.toJson();
    }
    map['reset_password'] = _resetPassword;
    map['status'] = _status;
    map['permanent_address'] = _permanentAddress;
    map['present_address'] = _presentAddress;
    map['same_address'] = _sameAddress;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['created_by'] = _createdBy;
    map['updated_by'] = _updatedBy;
    map['dob'] = _dob;
    map['fcmtoken'] = _fcmtoken;
    map['volunteer'] = _volunteer;
    if (_volunteerAri != null) {
      map['volunteer_ari'] = _volunteerAri?.map((v) => v.toJson()).toList();
    }
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