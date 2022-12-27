import 'dart:convert';
StateModel stateModelFromJson(String str) => StateModel.fromJson(json.decode(str));
String stateModelToJson(StateModel data) => json.encode(data.toJson());
class StateModel {
  StateModel({
      this.status, 
      this.data,});

  StateModel.fromJson(dynamic json) {
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
StateModel copyWith({  bool? status,
  List<Data>? data,
}) => StateModel(  status: status ?? this.status,
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
      this.name, 
      this.stateId, 
      this.status, 
      this.createdAt, 
      this.updatedAt, 
      this.createdBy, 
      this.updatedBy,});

  Data.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    stateId = json['state_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
  }
  String? id;
  String? name;
  num? stateId;
  String? status;
  String? createdAt;
  String? updatedAt;
  num? createdBy;
  num? updatedBy;
Data copyWith({  String? id,
  String? name,
  num? stateId,
  String? status,
  String? createdAt,
  String? updatedAt,
  num? createdBy,
  num? updatedBy,
}) => Data(  id: id ?? this.id,
  name: name ?? this.name,
  stateId: stateId ?? this.stateId,
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
    map['state_id'] = stateId;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['created_by'] = createdBy;
    map['updated_by'] = updatedBy;
    return map;
  }

}