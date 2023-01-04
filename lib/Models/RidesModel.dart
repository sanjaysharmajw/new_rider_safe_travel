import 'dart:convert';

import 'RideDataModel.dart';

TripsModel tripsModelFromJson(String str) =>
    TripsModel.fromJson(json.decode(str));
String tripsModelToJson(TripsModel data) => json.encode(data.toJson());

class TripsModel {
  TripsModel({
    this.status,
    required this.data,
  });

  TripsModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(RideDataModel.fromJson(v));
      });
    }
  }
  bool? status;
  List<RideDataModel> data = [];
  TripsModel copyWith({
    bool? status,
    List<RideDataModel>? data,
  }) =>
      TripsModel(
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
