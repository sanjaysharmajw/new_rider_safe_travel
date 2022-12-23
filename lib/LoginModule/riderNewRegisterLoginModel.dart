import 'dart:convert';
RiderNewRegisterLoginModel riderNewRegisterLoginModelFromJson(String str) => RiderNewRegisterLoginModel.fromJson(json.decode(str));
String riderNewRegisterLoginModelToJson(RiderNewRegisterLoginModel data) => json.encode(data.toJson());
class RiderNewRegisterLoginModel {
  RiderNewRegisterLoginModel({
      this.status, 
      this.data,});

  RiderNewRegisterLoginModel.fromJson(dynamic json) {
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
RiderNewRegisterLoginModel copyWith({  bool? status,
  List<Data>? data,
}) => RiderNewRegisterLoginModel(  status: status ?? this.status,
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
      this.firstName, 
      this.lastName, 
      this.emailId, 
      this.mobileNumber, 
      this.gender, 
      this.password, 
      this.alternateContactNo, 
      this.userType, 
      this.aadharNumber, 
      this.panNumber, 
      this.profileImage,
      this.maritalStatus, 
      this.citizenship, 
      this.failAttempt, 
      this.isLock, 
      this.address, 
      this.dldetails, 
      this.city, 
      this.state, 
      this.pincode, 
      this.resetPassword, 
      this.status,
      this.sameAddress, 
      this.createdAt, 
      this.updatedAt, 
      this.createdBy, 
      this.updatedBy, 
      this.dob,});

  Data.fromJson(dynamic json) {
    id = json['_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    emailId = json['email_id'];
    mobileNumber = json['mobile_number'];
    gender = json['gender'];
    password = json['password'];
    alternateContactNo = json['alternate_contact_no'];
    userType = json['user_type'];
    aadharNumber = json['aadhar_number'];
    panNumber = json['pan_number'];
    profileImage = json['profile_image'];
    maritalStatus = json['marital_status'];
    citizenship = json['citizenship'];
    failAttempt = json['fail_attempt'];
    isLock = json['is_lock'];
    address = json['address'];
    dldetails = json['dldetails'] != null ? Dldetails.fromJson(json['dldetails']) : null;
    city = json['city'];
    state = json['state'];
    pincode = json['pincode'];
    resetPassword = json['reset_password'];
    status = json['status'];
    sameAddress = json['same_address'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    dob = json['dob'];
  }
  String? id;
  String? firstName;
  String? lastName;
  String? emailId;
  String? mobileNumber;
  String? gender;
  String? password;
  String? alternateContactNo;
  String? userType;
  String? aadharNumber;
  String? panNumber;
  String? profileImage;
  String? maritalStatus;
  String? citizenship;
  String? failAttempt;
  String? isLock;
  String? address;
  Dldetails? dldetails;
  String? city;
  String? state;
  String? pincode;
  String? resetPassword;
  String? status;
  String? sameAddress;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;
  String? dob;
Data copyWith({  String? id,
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
  Dldetails? dldetails,
  String? city,
  String? state,
  String? pincode,
  String? resetPassword,
  String? status,

  String? sameAddress,
  String? createdAt,
  String? updatedAt,
  String? createdBy,
  String? updatedBy,
  String? dob,
}) => Data(  id: id ?? this.id,
  firstName: firstName ?? this.firstName,
  lastName: lastName ?? this.lastName,
  emailId: emailId ?? this.emailId,
  mobileNumber: mobileNumber ?? this.mobileNumber,
  gender: gender ?? this.gender,
  password: password ?? this.password,
  alternateContactNo: alternateContactNo ?? this.alternateContactNo,
  userType: userType ?? this.userType,
  aadharNumber: aadharNumber ?? this.aadharNumber,
  panNumber: panNumber ?? this.panNumber,
  profileImage: profileImage ?? this.profileImage,
  maritalStatus: maritalStatus ?? this.maritalStatus,
  citizenship: citizenship ?? this.citizenship,
  failAttempt: failAttempt ?? this.failAttempt,
  isLock: isLock ?? this.isLock,
  address: address ?? this.address,
  dldetails: dldetails ?? this.dldetails,
  city: city ?? this.city,
  state: state ?? this.state,
  pincode: pincode ?? this.pincode,
  resetPassword: resetPassword ?? this.resetPassword,
  status: status ?? this.status,
  sameAddress: sameAddress ?? this.sameAddress,
  createdAt: createdAt ?? this.createdAt,
  updatedAt: updatedAt ?? this.updatedAt,
  createdBy: createdBy ?? this.createdBy,
  updatedBy: updatedBy ?? this.updatedBy,
  dob: dob ?? this.dob,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['email_id'] = emailId;
    map['mobile_number'] = mobileNumber;
    map['gender'] = gender;
    map['password'] = password;
    map['alternate_contact_no'] = alternateContactNo;
    map['user_type'] = userType;
    map['aadhar_number'] = aadharNumber;
    map['pan_number'] = panNumber;
    map['profile_image'] = profileImage;
    map['marital_status'] = maritalStatus;
    map['citizenship'] = citizenship;
    map['fail_attempt'] = failAttempt;
    map['is_lock'] = isLock;
    map['address'] = address;
    if (dldetails != null) {
      map['dldetails'] = dldetails?.toJson();
    }
    map['city'] = city;
    map['state'] = state;
    map['pincode'] = pincode;
    map['reset_password'] = resetPassword;
    map['status'] = status;
    map['same_address'] = sameAddress;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['created_by'] = createdBy;
    map['updated_by'] = updatedBy;
    map['dob'] = dob;
    return map;
  }

}

Dldetails dldetailsFromJson(String str) => Dldetails.fromJson(json.decode(str));
String dldetailsToJson(Dldetails data) => json.encode(data.toJson());
class Dldetails {
  Dldetails({
      this.dlNumber, 
      this.photo, 
      this.dlExpiryDate, 
      this.dlMobileNumber, 
      this.accidentalHistory, 
      this.accidentalDiscription, 
      this.available24by7, 
      this.shiftTimeFrom, 
      this.shiftTimeTo,});

  Dldetails.fromJson(dynamic json) {
    dlNumber = json['dl_number'];
    photo = json['photo'];
    dlExpiryDate = json['dl_expiry_date'];
    dlMobileNumber = json['dl_mobile_number'];
    accidentalHistory = json['accidental_history'];
    accidentalDiscription = json['accidental_discription'];
    available24by7 = json['available24by7'];
    shiftTimeFrom = json['shift_time_from'];
    shiftTimeTo = json['shift_time_to'];
  }
  String? dlNumber;
  String? photo;
  String? dlExpiryDate;
  String? dlMobileNumber;
  String? accidentalHistory;
  String? accidentalDiscription;
  String? available24by7;
  String? shiftTimeFrom;
  String? shiftTimeTo;
Dldetails copyWith({  String? dlNumber,
  String? photo,
  String? dlExpiryDate,
  String? dlMobileNumber,
  String? accidentalHistory,
  String? accidentalDiscription,
  String? available24by7,
  String? shiftTimeFrom,
  String? shiftTimeTo,
}) => Dldetails(  dlNumber: dlNumber ?? this.dlNumber,
  photo: photo ?? this.photo,
  dlExpiryDate: dlExpiryDate ?? this.dlExpiryDate,
  dlMobileNumber: dlMobileNumber ?? this.dlMobileNumber,
  accidentalHistory: accidentalHistory ?? this.accidentalHistory,
  accidentalDiscription: accidentalDiscription ?? this.accidentalDiscription,
  available24by7: available24by7 ?? this.available24by7,
  shiftTimeFrom: shiftTimeFrom ?? this.shiftTimeFrom,
  shiftTimeTo: shiftTimeTo ?? this.shiftTimeTo,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dl_number'] = dlNumber;
    map['photo'] = photo;
    map['dl_expiry_date'] = dlExpiryDate;
    map['dl_mobile_number'] = dlMobileNumber;
    map['accidental_history'] = accidentalHistory;
    map['accidental_discription'] = accidentalDiscription;
    map['available24by7'] = available24by7;
    map['shift_time_from'] = shiftTimeFrom;
    map['shift_time_to'] = shiftTimeTo;
    return map;
  }

}