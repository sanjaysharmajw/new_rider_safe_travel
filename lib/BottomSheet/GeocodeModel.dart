import 'dart:convert';

import 'GeocodeResultModel.dart';
GeocodeModel geocodeModelFromJson(String str) => GeocodeModel.fromJson(json.decode(str));
String geocodeModelToJson(GeocodeModel data) => json.encode(data.toJson());
class GeocodeModel {
  GeocodeModel({
      this.status, 
      this.result,});

  GeocodeModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result?.add(Result.fromJson(v));
      });
    }
  }
  bool? status;
  List<Result>? result;
GeocodeModel copyWith({  bool? status,
  List<Result>? result,
}) => GeocodeModel(  status: status ?? this.status,
  result: result ?? this.result,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (result != null) {
      map['result'] = result?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

