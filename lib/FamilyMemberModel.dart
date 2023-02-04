import 'dart:convert';

import 'FamilyMemberDataModel.dart';
FamilyMemberModel familyMemberModelFromJson(String str) => FamilyMemberModel.fromJson(json.decode(str));
String familyMemberModelToJson(FamilyMemberModel data) => json.encode(data.toJson());
class FamilyMemberModel {
  FamilyMemberModel({
      this.status, 
      this.data,});

  FamilyMemberModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(FamilyMemberDataModel.fromJson(v));
      });
    }
  }
  bool? status;
  List<FamilyMemberDataModel>? data;
FamilyMemberModel copyWith({  bool? status,
  List<FamilyMemberDataModel>? data,
}) => FamilyMemberModel(  status: status ?? this.status,
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

