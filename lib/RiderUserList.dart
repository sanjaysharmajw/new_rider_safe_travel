import 'dart:convert';
/// status : true
/// data : [{"_id":"6386f83ba2d80074cbcfb903","first_name":"Prathamesh","last_name":"tamboli","email_id":"prathamesh11092@gmail.com","mobile_number":"8286566801","gender":"Male","password":"51073c709764d45eb6658bbf50fedcb396fb702bb0e6d95c2fd31de30b66cdfe7fd9ec1ce32b1573b524611508cbe4ef95744a848f2863867db4d5ab764ad0d6","alternate_contact_no":null,"user_type":"Rider","aadhar_number":null,"pan_number":null,"dl_number":"9874","shift_type":"","documents":[],"accidental_history":"No","accidental_discription":"","marital_status":null,"citizenship":"","fail_attempt":"","is_lock":"","reset_password":"","status":"Active","city":"diphu","state":"assam","permanent_address":null,"present_address":null,"same_address":"","pincode":"258696","created_at":"","updated_at":"2022-12-23T09:28:12.959Z","created_by":"63a3fac4bfb42fd184d37bb1","updated_by":"6386f83ba2d80074cbcfb903","dob":"1990-12-30","profile_image":"https://hdqwalls.com/wallpapers/chris-hemsworth-mens-health-2019-a5.jpg","dldetails":{"dl_number":"466733","photo":"image","dl_expiry_date":"31-12-2022","dl_mobile_number":"8355831970","accidental_history":"No","accidental_discription":"","available24by7":"Yes","shift_time_from":"11:41:00","shift_time_to":"19:41:00"},"address":"diphu, assam"}]

RiderUserList riderUserListFromJson(String str) => RiderUserList.fromJson(json.decode(str));
String riderUserListToJson(RiderUserList data) => json.encode(data.toJson());
class RiderUserList {
  RiderUserList({
      bool? status, 
      List<RiderUserListData>? data,}){
    _status = status;
    _data = data;
}

  RiderUserList.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(RiderUserListData.fromJson(v));
      });
    }
  }
  bool? _status;
  List<RiderUserListData>? _data;
RiderUserList copyWith({  bool? status,
  List<RiderUserListData>? data,
}) => RiderUserList(  status: status ?? _status,
  data: data ?? _data,
);
  bool? get status => _status;
  List<RiderUserListData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "6386f83ba2d80074cbcfb903"
/// first_name : "Prathamesh"
/// last_name : "tamboli"
/// email_id : "prathamesh11092@gmail.com"
/// mobile_number : "8286566801"
/// gender : "Male"
/// password : "51073c709764d45eb6658bbf50fedcb396fb702bb0e6d95c2fd31de30b66cdfe7fd9ec1ce32b1573b524611508cbe4ef95744a848f2863867db4d5ab764ad0d6"
/// alternate_contact_no : null
/// user_type : "Rider"
/// aadhar_number : null
/// pan_number : null
/// dl_number : "9874"
/// shift_type : ""
/// documents : []
/// accidental_history : "No"
/// accidental_discription : ""
/// marital_status : null
/// citizenship : ""
/// fail_attempt : ""
/// is_lock : ""
/// reset_password : ""
/// status : "Active"
/// city : "diphu"
/// state : "assam"
/// permanent_address : null
/// present_address : null
/// same_address : ""
/// pincode : "258696"
/// created_at : ""
/// updated_at : "2022-12-23T09:28:12.959Z"
/// created_by : "63a3fac4bfb42fd184d37bb1"
/// updated_by : "6386f83ba2d80074cbcfb903"
/// dob : "1990-12-30"
/// profile_image : "https://hdqwalls.com/wallpapers/chris-hemsworth-mens-health-2019-a5.jpg"
/// dldetails : {"dl_number":"466733","photo":"image","dl_expiry_date":"31-12-2022","dl_mobile_number":"8355831970","accidental_history":"No","accidental_discription":"","available24by7":"Yes","shift_time_from":"11:41:00","shift_time_to":"19:41:00"}
/// address : "diphu, assam"

RiderUserListData dataFromJson(String str) => RiderUserListData.fromJson(json.decode(str));
String dataToJson(RiderUserListData data) => json.encode(data.toJson());
class RiderUserListData {
  RiderUserListData({
      String? id, 
      String? firstName, 
      String? lastName, 
      String? emailId, 
      String? mobileNumber, 
      String? gender, 
      String? password, 
      dynamic alternateContactNo, 
      String? userType, 
      dynamic aadharNumber, 
      dynamic panNumber, 
      String? dlNumber, 
      String? shiftType, 
      List<dynamic>? documents, 
      String? accidentalHistory, 
      String? accidentalDiscription, 
      dynamic maritalStatus, 
      String? citizenship, 
      String? failAttempt, 
      String? isLock, 
      String? resetPassword, 
      String? status, 
      String? city, 
      String? state, 
      dynamic permanentAddress, 
      dynamic presentAddress, 
      String? sameAddress, 
      String? pincode, 
      String? createdAt, 
      String? updatedAt, 
      String? createdBy, 
      String? updatedBy, 
      String? dob, 
      String? profileImage, 
      Dldetails? dldetails, 
      String? address,}){
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
}

  RiderUserListData.fromJson(dynamic json) {
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
    // if (json['documents'] != null) {
    //   _documents = [];
    //   json['documents'].forEach((v) {
    //     _documents?.add(Dynamic.fromJson(v));
    //   });
    // }
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
    _permanentAddress = json['permanent_address'];
    _presentAddress = json['present_address'];
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
  }
  String? _id;
  String? _firstName;
  String? _lastName;
  String? _emailId;
  String? _mobileNumber;
  String? _gender;
  String? _password;
  dynamic _alternateContactNo;
  String? _userType;
  dynamic _aadharNumber;
  dynamic _panNumber;
  String? _dlNumber;
  String? _shiftType;
  List<dynamic>? _documents;
  String? _accidentalHistory;
  String? _accidentalDiscription;
  dynamic _maritalStatus;
  String? _citizenship;
  String? _failAttempt;
  String? _isLock;
  String? _resetPassword;
  String? _status;
  String? _city;
  String? _state;
  dynamic _permanentAddress;
  dynamic _presentAddress;
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
  RiderUserListData copyWith({  String? id,
  String? firstName,
  String? lastName,
  String? emailId,
  String? mobileNumber,
  String? gender,
  String? password,
  dynamic alternateContactNo,
  String? userType,
  dynamic aadharNumber,
  dynamic panNumber,
  String? dlNumber,
  String? shiftType,
  List<dynamic>? documents,
  String? accidentalHistory,
  String? accidentalDiscription,
  dynamic maritalStatus,
  String? citizenship,
  String? failAttempt,
  String? isLock,
  String? resetPassword,
  String? status,
  String? city,
  String? state,
  dynamic permanentAddress,
  dynamic presentAddress,
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
}) => RiderUserListData(  id: id ?? _id,
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
);
  String? get id => _id;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get emailId => _emailId;
  String? get mobileNumber => _mobileNumber;
  String? get gender => _gender;
  String? get password => _password;
  dynamic get alternateContactNo => _alternateContactNo;
  String? get userType => _userType;
  dynamic get aadharNumber => _aadharNumber;
  dynamic get panNumber => _panNumber;
  String? get dlNumber => _dlNumber;
  String? get shiftType => _shiftType;
  List<dynamic>? get documents => _documents;
  String? get accidentalHistory => _accidentalHistory;
  String? get accidentalDiscription => _accidentalDiscription;
  dynamic get maritalStatus => _maritalStatus;
  String? get citizenship => _citizenship;
  String? get failAttempt => _failAttempt;
  String? get isLock => _isLock;
  String? get resetPassword => _resetPassword;
  String? get status => _status;
  String? get city => _city;
  String? get state => _state;
  dynamic get permanentAddress => _permanentAddress;
  dynamic get presentAddress => _presentAddress;
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
    map['permanent_address'] = _permanentAddress;
    map['present_address'] = _presentAddress;
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
    return map;
  }

}

/// dl_number : "466733"
/// photo : "image"
/// dl_expiry_date : "31-12-2022"
/// dl_mobile_number : "8355831970"
/// accidental_history : "No"
/// accidental_discription : ""
/// available24by7 : "Yes"
/// shift_time_from : "11:41:00"
/// shift_time_to : "19:41:00"

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