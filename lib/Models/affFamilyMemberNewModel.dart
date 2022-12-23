import 'dart:convert';
AffFamilyMemberNewModel affFamilyMemberNewModelFromJson(String str) => AffFamilyMemberNewModel.fromJson(json.decode(str));
String affFamilyMemberNewModelToJson(AffFamilyMemberNewModel data) => json.encode(data.toJson());
class AffFamilyMemberNewModel {
  AffFamilyMemberNewModel({
      this.status, 
      this.message,});

  AffFamilyMemberNewModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
  }
  bool? status;
  String? message;
AffFamilyMemberNewModel copyWith({  bool? status,
  String? message,
}) => AffFamilyMemberNewModel(  status: status ?? this.status,
  message: message ?? this.message,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    return map;
  }

}