import 'dart:convert';
ServiceTypeModel serviceTypeModelFromJson(String str) => ServiceTypeModel.fromJson(json.decode(str));
String serviceTypeModelToJson(ServiceTypeModel data) => json.encode(data.toJson());
class ServiceTypeModel {
  ServiceTypeModel({
      this.status, 
      this.data,});

  ServiceTypeModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ServiceTypeData.fromJson(v));
      });
    }
  }
  bool? status;
  List<ServiceTypeData>? data;
ServiceTypeModel copyWith({  bool? status,
  List<ServiceTypeData>? data,
}) => ServiceTypeModel(  status: status ?? this.status,
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

ServiceTypeData dataFromJson(String str) => ServiceTypeData.fromJson(json.decode(str));
String dataToJson(ServiceTypeData data) => json.encode(data.toJson());
class ServiceTypeData {
  ServiceTypeData({
      this.id, 
      this.name, 
      this.status, 
      this.createdAt, 
      this.updatedAt, 
      this.createdBy, 
      this.updatedBy,});

  ServiceTypeData.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
  }
  String? id;
  String? name;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;
  ServiceTypeData copyWith({  String? id,
  String? name,
  String? status,
  String? createdAt,
  String? updatedAt,
  String? createdBy,
  String? updatedBy,
}) => ServiceTypeData(  id: id ?? this.id,
  name: name ?? this.name,
  status: status ?? this.status,
  createdAt: createdAt ?? this.createdAt,
  updatedAt: updatedAt ?? this.updatedAt,
  createdBy: createdBy ?? this.createdBy,
  updatedBy: updatedBy ?? this.updatedBy,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['created_by'] = createdBy;
    map['updated_by'] = updatedBy;
    return map;
  }

}