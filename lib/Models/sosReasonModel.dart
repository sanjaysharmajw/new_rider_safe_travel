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
        data?.add(sosReasonData.fromJson(v));
      });
    }
  }
  bool? status;
  List<sosReasonData>? data;
SosReasonModel copyWith({  bool? status,
  List<sosReasonData>? data,
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

sosReasonData dataFromJson(String str) => sosReasonData.fromJson(json.decode(str));
String dataToJson(sosReasonData data) => json.encode(data.toJson());
class sosReasonData {
  sosReasonData({
      this.id, 
      this.name,});

  sosReasonData.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
  }
  String? id;
  String? name;
  sosReasonData copyWith({  String? id,
  String? name,
}) => sosReasonData(  id: id ?? this.id,
  name: name ?? this.name,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    return map;
  }

}