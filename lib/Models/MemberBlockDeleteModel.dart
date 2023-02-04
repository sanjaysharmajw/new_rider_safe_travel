import 'dart:convert';
MemberBlockDeleteModel memberBlockDeleteModelFromJson(String str) => MemberBlockDeleteModel.fromJson(json.decode(str));
String memberBlockDeleteModelToJson(MemberBlockDeleteModel data) => json.encode(data.toJson());
class MemberBlockDeleteModel {
  MemberBlockDeleteModel({
      this.status, 
      this.message,});

  MemberBlockDeleteModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
  }
  bool? status;
  String? message;
MemberBlockDeleteModel copyWith({  bool? status,
  String? message,
}) => MemberBlockDeleteModel(  status: status ?? this.status,
  message: message ?? this.message,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    return map;
  }

}