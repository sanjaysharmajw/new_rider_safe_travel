import 'dart:convert';

import 'package:ride_safe_travel/permanentAddress.dart';
import 'package:ride_safe_travel/presentAddress.dart';

import 'DriverVehicleList.dart';

RiderData dataFromJson(String str) => RiderData.fromJson(json.decode(str));
String dataToJson(RiderData data) => json.encode(data.toJson());

class RiderData {
  RiderData({
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
    this.dlNumber,
    this.shiftType,
    this.documents,
    this.accidentalHistory,
    this.accidentalDiscription,
    this.maritalStatus,
    this.citizenship,
    this.failAttempt,
    this.isLock,
    this.resetPassword,
    this.status,
    this.city,
    this.state,
    this.permanentAddress,
    this.presentAddress,
    this.sameAddress,
    this.pincode,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.dob,
    this.profileImage,
    this.dldetails,
    this.address,
    this.emergencyContact,
  });

  RiderData.fromJson(dynamic json) {
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
    dlNumber = json['dl_number'];
    shiftType = json['shift_type'];
    emergencyContact = json['emergency_contact_no'];

    accidentalHistory = json['accidental_history'];
    accidentalDiscription = json['accidental_discription'];
    maritalStatus = json['marital_status'];
    citizenship = json['citizenship'];
    failAttempt = json['fail_attempt'];
    isLock = json['is_lock'];
    resetPassword = json['reset_password'];
    status = json['status'];
    city = json['city'];
    state = json['state'];
    permanentAddress = json['permanent_address'] != null
        ? PermanentAddress.fromJson(json['permanent_address'])
        : null;
    presentAddress = json['present_address'] != null
        ? PresentAddress.fromJson(json['present_address'])
        : null;
    sameAddress = json['same_address'];
    pincode = json['pincode'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    dob = json['dob'];
    profileImage = json['profile_image'];
    dldetails = json['dldetails'] != null
        ? Dldetails.fromJson(json['dldetails'])
        : null;
    address = json['address'];
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
  dynamic aadharNumber;
  dynamic panNumber;
  String? dlNumber;
  String? shiftType;
  List<dynamic>? documents;
  String? accidentalHistory;
  String? accidentalDiscription;
  String? maritalStatus;
  String? citizenship;
  String? failAttempt;
  String? isLock;
  String? resetPassword;
  String? status;
  String? city;
  String? state;
  PermanentAddress? permanentAddress;
  PresentAddress? presentAddress;
  String? sameAddress;
  String? pincode;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;
  String? dob;
  String? profileImage;
  Dldetails? dldetails;
  String? address;
  String? emergencyContact;
  RiderData copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? emailId,
    String? mobileNumber,
    String? gender,
    String? password,
    String? alternateContactNo,
    String? userType,
    dynamic aadharNumber,
    dynamic panNumber,
    String? dlNumber,
    String? shiftType,
    List<dynamic>? documents,
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
    String? emergencyContact,
  }) =>
      RiderData(
        id: id ?? this.id,
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
        dlNumber: dlNumber ?? this.dlNumber,
        shiftType: shiftType ?? this.shiftType,
        documents: documents ?? this.documents,
        accidentalHistory: accidentalHistory ?? this.accidentalHistory,
        accidentalDiscription:
            accidentalDiscription ?? this.accidentalDiscription,
        maritalStatus: maritalStatus ?? this.maritalStatus,
        citizenship: citizenship ?? this.citizenship,
        failAttempt: failAttempt ?? this.failAttempt,
        isLock: isLock ?? this.isLock,
        resetPassword: resetPassword ?? this.resetPassword,
        status: status ?? this.status,
        city: city ?? this.city,
        state: state ?? this.state,
        permanentAddress: permanentAddress ?? this.permanentAddress,
        presentAddress: presentAddress ?? this.presentAddress,
        sameAddress: sameAddress ?? this.sameAddress,
        pincode: pincode ?? this.pincode,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        createdBy: createdBy ?? this.createdBy,
        updatedBy: updatedBy ?? this.updatedBy,
        dob: dob ?? this.dob,
        profileImage: profileImage ?? this.profileImage,
        dldetails: dldetails ?? this.dldetails,
        address: address ?? this.address,
          emergencyContact: emergencyContact ?? this.emergencyContact,
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
    map['dl_number'] = dlNumber;
    map['shift_type'] = shiftType;
    if (documents != null) {
      map['documents'] = documents?.map((v) => v.toJson()).toList();
    }
    map['accidental_history'] = accidentalHistory;
    map['accidental_discription'] = accidentalDiscription;
    map['marital_status'] = maritalStatus;
    map['citizenship'] = citizenship;
    map['fail_attempt'] = failAttempt;
    map['is_lock'] = isLock;
    map['reset_password'] = resetPassword;
    map['status'] = status;
    map['city'] = city;
    map['state'] = state;
    if (permanentAddress != null) {
      map['permanent_address'] = permanentAddress?.toJson();
    }
    if (presentAddress != null) {
      map['present_address'] = presentAddress?.toJson();
    }
    map['same_address'] = sameAddress;
    map['pincode'] = pincode;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['created_by'] = createdBy;
    map['updated_by'] = updatedBy;
    map['dob'] = dob;
    map['profile_image'] = profileImage;
    if (dldetails != null) {
      map['dldetails'] = dldetails?.toJson();
    }
    map['address'] = address;
    map['emergency_contact_no'] = emergencyContact;
    return map;
  }
}

Dldetails dldetailsFromJson(String str) => Dldetails.fromJson(json.decode(str));
String dldetailsToJson(Dldetails data) => json.encode(data.toJson());

class Dldetails {
  Dldetails({
    this.dlNumber,
    this.dlImage,
    this.dlExpiryDate,
    this.dlMobileNumber,
    this.accidentalHistory,
    this.accidentalDiscription,
    this.available24by7,
    this.shiftTimeFrom,
    this.shiftTimeTo,
  });

  Dldetails.fromJson(dynamic json) {
    dlNumber = json['dl_number'];
    dlImage = json['dl_image'];
    dlExpiryDate = json['dl_expiry_date'];
    dlMobileNumber = json['dl_mobile_number'];
    accidentalHistory = json['accidental_history'];
    accidentalDiscription = json['accidental_discription'];
    available24by7 = json['available24by7'];
    shiftTimeFrom = json['shift_time_from'];
    shiftTimeTo = json['shift_time_to'];
  }
  String? dlNumber;
  String? dlImage;
  String? dlExpiryDate;
  String? dlMobileNumber;
  String? accidentalHistory;
  String? accidentalDiscription;
  String? available24by7;
  String? shiftTimeFrom;
  String? shiftTimeTo;
  Dldetails copyWith({
    String? dlNumber,
    String? dlImage,
    String? dlExpiryDate,
    String? dlMobileNumber,
    String? accidentalHistory,
    String? accidentalDiscription,
    String? available24by7,
    String? shiftTimeFrom,
    String? shiftTimeTo,
  }) =>
      Dldetails(
        dlNumber: dlNumber ?? this.dlNumber,
        dlImage: dlImage ?? this.dlImage,
        dlExpiryDate: dlExpiryDate ?? this.dlExpiryDate,
        dlMobileNumber: dlMobileNumber ?? this.dlMobileNumber,
        accidentalHistory: accidentalHistory ?? this.accidentalHistory,
        accidentalDiscription:
            accidentalDiscription ?? this.accidentalDiscription,
        available24by7: available24by7 ?? this.available24by7,
        shiftTimeFrom: shiftTimeFrom ?? this.shiftTimeFrom,
        shiftTimeTo: shiftTimeTo ?? this.shiftTimeTo,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dl_number'] = dlNumber;
    map['dl_image'] = dlImage;
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
