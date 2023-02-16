import 'dart:convert';

import 'LoginModule/Map/FamilyListDataModel.dart';
Familydatamodel familydatamodelFromJson(String str) => Familydatamodel.fromJson(json.decode(str));
String familydatamodelToJson(Familydatamodel data) => json.encode(data.toJson());
class Familydatamodel {
  Familydatamodel({
      this.status, 
      this.data,});

  Familydatamodel.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(FamilyListDataModel.fromJson(v));
      });
    }
  }
  bool? status;
  List<FamilyListDataModel>? data;
Familydatamodel copyWith({  bool? status,
  List<FamilyListDataModel>? data,
}) => Familydatamodel(  status: status ?? this.status,
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

