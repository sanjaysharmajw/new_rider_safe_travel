import 'dart:convert';

import 'package:ride_safe_travel/permanentAddress.dart';
import 'package:ride_safe_travel/presentAddress.dart';
import 'package:ride_safe_travel/riderData.dart';

RiderUserListData riderUserListDataFromJson(String str) =>
    RiderUserListData.fromJson(json.decode(str));
String riderUserListDataToJson(RiderUserListData data) =>
    json.encode(data.toJson());

class RiderUserListData {
  RiderUserListData({
    this.status,
    this.data,
  });

  RiderUserListData.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(RiderData.fromJson(v));
      });
    }
  }
  bool? status;
  List<RiderData>? data;
  RiderUserListData copyWith({
    bool? status,
    List<RiderData>? data,
  }) =>
      RiderUserListData(
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
