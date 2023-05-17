import 'dart:convert';
SosReasonModel sosReasonModelFromJson(String str) => SosReasonModel.fromJson(json.decode(str));
String sosReasonModelToJson(SosReasonModel data) => json.encode(data.toJson());
class SosReasonModel {
  SosReasonModel({
      bool? status, 
      List<ReasonMasterData>? data,}){
    _status = status;
    _data = data;
}

  SosReasonModel.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ReasonMasterData.fromJson(v));
      });
    }
  }
  bool? _status;
  List<ReasonMasterData>? _data;
SosReasonModel copyWith({  bool? status,
  List<ReasonMasterData>? data,
}) => SosReasonModel(  status: status ?? _status,
  data: data ?? _data,
);
  bool? get status => _status;
  List<ReasonMasterData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

ReasonMasterData dataFromJson(String str) => ReasonMasterData.fromJson(json.decode(str));
String dataToJson(ReasonMasterData data) => json.encode(data.toJson());
class ReasonMasterData {
  ReasonMasterData({
      String? id, 
      String? name,}){
    _id = id;
    _name = name;
}

  ReasonMasterData.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
  }
  String? _id;
  String? _name;
  ReasonMasterData copyWith({  String? id,
  String? name,
}) => ReasonMasterData(  id: id ?? _id,
  name: name ?? _name,
);
  String? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    return map;
  }

}