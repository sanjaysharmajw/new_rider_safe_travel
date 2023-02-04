import 'dart:convert';

FamilyMemberDataModel dataFromJson(String str) => FamilyMemberDataModel.fromJson(json.decode(str));
String dataToJson(FamilyMemberDataModel data) => json.encode(data.toJson());
class FamilyMemberDataModel {
  FamilyMemberDataModel({
    this.name,
    this.id,
    this.userId,
    this.memberId,
    this.memberFName,
    this.memberLName,
    this.memberEmailId,
    this.memberMobileNumber,
    this.memberProfileImage,
    this.relation,
    this.memberStatus,});

  FamilyMemberDataModel.fromJson(dynamic json) {
    name = json['name'];
    id = json['_id'];
    userId = json['user_id'];
    memberId = json['member_id'];
    memberFName = json['member_f_name'];
    memberLName = json['member_l_name'];
    memberEmailId = json['member_email_id'];
    memberMobileNumber = json['member_mobile_number'];
    memberProfileImage = json['member_profile_image'];
    relation = json['relation'];
    memberStatus = json['member_status'];
  }
  String? name;
  String? id;
  String? userId;
  String? memberId;
  String? memberFName;
  String? memberLName;
  String? memberEmailId;
  String? memberMobileNumber;
  String? memberProfileImage;
  String? relation;
  String? memberStatus;
  FamilyMemberDataModel copyWith({  String? name,
    String? id,
    String? userId,
    String? memberId,
    String? memberFName,
    String? memberLName,
    String? memberEmailId,
    String? memberMobileNumber,
    String? memberProfileImage,
    String? relation,
    String? memberStatus,
  }) => FamilyMemberDataModel(  name: name ?? this.name,
    id: id ?? this.id,
    userId: userId ?? this.userId,
    memberId: memberId ?? this.memberId,
    memberFName: memberFName ?? this.memberFName,
    memberLName: memberLName ?? this.memberLName,
    memberEmailId: memberEmailId ?? this.memberEmailId,
    memberMobileNumber: memberMobileNumber ?? this.memberMobileNumber,
    memberProfileImage: memberProfileImage ?? this.memberProfileImage,
    relation: relation ?? this.relation,
    memberStatus: memberStatus ?? this.memberStatus,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['_id'] = id;
    map['user_id'] = userId;
    map['member_id'] = memberId;
    map['member_f_name'] = memberFName;
    map['member_l_name'] = memberLName;
    map['member_email_id'] = memberEmailId;
    map['member_mobile_number'] = memberMobileNumber;
    map['member_profile_image'] = memberProfileImage;
    map['relation'] = relation;
    map['member_status'] = memberStatus;
    return map;
  }

}