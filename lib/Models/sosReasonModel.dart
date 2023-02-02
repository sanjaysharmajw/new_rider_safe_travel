import 'dart:convert';
SosReasonModel sosReasonModelFromJson(String str) => SosReasonModel.fromJson(json.decode(str));
String sosReasonModelToJson(SosReasonModel data) => json.encode(data.toJson());
class SosReasonModel {
  SosReasonModel({
      this.status, 
      this.data,});

  SosReasonModel.fromJson(dynamic json) {
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
SosReasonModel copyWith({  bool? status,
  List<Data>? data,
}) => SosReasonModel(  status: status ?? this.status,
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
      this.name,});

  Data.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
  }
  String? id;
  String? name;
Data copyWith({  String? id,
  String? name,
}) => Data(  id: id ?? this.id,
  name: name ?? this.name,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    return map;
  }

}