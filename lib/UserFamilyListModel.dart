import 'dart:convert';
/// status : true
/// data : [{"_id":"63a543d6cea0f8621f2f2fcf","user_id":"63a53ff62d5c8578577872cf","member_id":"639c6caae0aa678e9f6de543","member_f_name":"Sanjay ","member_l_name":"Sharma","member_email_id":"sanjay@gmail.com","member_mobile_number":"9167410084","member_profile_image":"","relation":"BROTHER"},{"_id":"63a5892d338deea55d93dcb6","user_id":"63a53ff62d5c8578577872cf","member_id":"63a587de8d21f72821ea5178","member_f_name":"","member_l_name":"","member_email_id":"","member_mobile_number":"9764543424","member_profile_image":"","relation":"PRATHAMESH "},{"_id":"63a93edaf7daa0f521018100","user_id":"63a53ff62d5c8578577872cf","member_id":"63a93ebeb13ea7f99be8fabe","member_f_name":"","member_l_name":"","member_email_id":"","member_mobile_number":"9876543210","member_profile_image":"","relation":"BROTHER"},{"_id":"63a94195728480114a50f963","user_id":"63a53ff62d5c8578577872cf","member_id":"63a9416c7ed69013c7fa2be3","member_f_name":"","member_l_name":"","member_email_id":"","member_mobile_number":"9876543211","member_profile_image":"","relation":"BROTHER"}]

UserFamilyListModel userFamilyListModelFromJson(String str) => UserFamilyListModel.fromJson(json.decode(str));
String userFamilyListModelToJson(UserFamilyListModel data) => json.encode(data.toJson());
class UserFamilyListModel {
  UserFamilyListModel({
      bool? status,
      List<FamilyMembersData>? data,}){
    _status = status;
    _data = data;
}

  UserFamilyListModel.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(FamilyMembersData.fromJson(v));
      });
    }
  }
  bool? _status;
  List<FamilyMembersData>? _data;
UserFamilyListModel copyWith({  bool? status,
  List<FamilyMembersData>? data,
}) => UserFamilyListModel(  status: status ?? _status,
  data: data ?? _data,
);
  bool? get status => _status;
  List<FamilyMembersData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "63a543d6cea0f8621f2f2fcf"
/// user_id : "63a53ff62d5c8578577872cf"
/// member_id : "639c6caae0aa678e9f6de543"
/// member_f_name : "Sanjay "
/// member_l_name : "Sharma"
/// member_email_id : "sanjay@gmail.com"
/// member_mobile_number : "9167410084"
/// member_profile_image : ""
/// relation : "BROTHER"

FamilyMembersData dataFromJson(String str) => FamilyMembersData.fromJson(json.decode(str));
String dataToJson(FamilyMembersData data) => json.encode(data.toJson());
class FamilyMembersData {
  FamilyMembersData({
      String? id,
      String? userId,
      String? memberId,
      String? memberFName,
      String? memberLName,
      String? memberEmailId,
      String? memberMobileNumber,
      String? memberProfileImage,
      String? relation,}){
    _id = id;
    _userId = userId;
    _memberId = memberId;
    _memberFName = memberFName;
    _memberLName = memberLName;
    _memberEmailId = memberEmailId;
    _memberMobileNumber = memberMobileNumber;
    _memberProfileImage = memberProfileImage;
    _relation = relation;
}

  FamilyMembersData.fromJson(dynamic json) {
    _id = json['_id'];
    _userId = json['user_id'];
    _memberId = json['member_id'];
    _memberFName = json['member_f_name'];
    _memberLName = json['member_l_name'];
    _memberEmailId = json['member_email_id'];
    _memberMobileNumber = json['member_mobile_number'];
    _memberProfileImage = json['member_profile_image'];
    _relation = json['relation'];
  }
  String? _id;
  String? _userId;
  String? _memberId;
  String? _memberFName;
  String? _memberLName;
  String? _memberEmailId;
  String? _memberMobileNumber;
  String? _memberProfileImage;
  String? _relation;
  FamilyMembersData copyWith({  String? id,
  String? userId,
  String? memberId,
  String? memberFName,
  String? memberLName,
  String? memberEmailId,
  String? memberMobileNumber,
  String? memberProfileImage,
  String? relation,
}) => FamilyMembersData(  id: id ?? _id,
  userId: userId ?? _userId,
  memberId: memberId ?? _memberId,
  memberFName: memberFName ?? _memberFName,
  memberLName: memberLName ?? _memberLName,
  memberEmailId: memberEmailId ?? _memberEmailId,
  memberMobileNumber: memberMobileNumber ?? _memberMobileNumber,
  memberProfileImage: memberProfileImage ?? _memberProfileImage,
  relation: relation ?? _relation,
);
  String? get id => _id;
  String? get userId => _userId;
  String? get memberId => _memberId;
  String? get memberFName => _memberFName;
  String? get memberLName => _memberLName;
  String? get memberEmailId => _memberEmailId;
  String? get memberMobileNumber => _memberMobileNumber;
  String? get memberProfileImage => _memberProfileImage;
  String? get relation => _relation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['user_id'] = _userId;
    map['member_id'] = _memberId;
    map['member_f_name'] = _memberFName;
    map['member_l_name'] = _memberLName;
    map['member_email_id'] = _memberEmailId;
    map['member_mobile_number'] = _memberMobileNumber;
    map['member_profile_image'] = _memberProfileImage;
    map['relation'] = _relation;
    return map;
  }

}