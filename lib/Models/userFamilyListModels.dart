import 'dart:convert';

UserFamilyListModels userFamilyListModelsFromJson(String str) =>
    UserFamilyListModels.fromJson(json.decode(str));
String userFamilyListModelsToJson(UserFamilyListModels data) =>
    json.encode(data.toJson());

class UserFamilyListModels {
  UserFamilyListModels({
    this.status,
    this.data,
  });

  UserFamilyListModels.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(familyListData.fromJson(v));
      });
    }
  }
  bool? status;
  List<familyListData>? data;
  UserFamilyListModels copyWith({
    bool? status,
    List<familyListData>? data,
  }) =>
      UserFamilyListModels(
        status: status ?? this.status,
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

familyListData dataFromJson(String str) =>
    familyListData.fromJson(json.decode(str));
String dataToJson(familyListData data) => json.encode(data.toJson());

class familyListData {
  familyListData({
    this.id,
    this.userId,
    this.memberId,
    this.relation,
  });

  familyListData.fromJson(dynamic json) {
    id = json['_id'];
    userId = json['user_id'];
    memberId = json['member_id'];
    relation = json['relation'];
  }
  String? id;
  String? userId;
  String? memberId;
  String? relation;
  familyListData copyWith({
    String? id,
    String? userId,
    String? memberId,
    String? relation,
  }) =>
      familyListData(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        memberId: memberId ?? this.memberId,
        relation: relation ?? this.relation,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['user_id'] = userId;
    map['member_id'] = memberId;
    map['relation'] = relation;
    return map;
  }
}
