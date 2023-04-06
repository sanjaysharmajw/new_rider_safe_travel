import 'Count.dart';

class CountModel {
  CountModel({
      required this.status,
      required this.data,
      required this.count,});

  CountModel.fromJson(dynamic json) {
    status = json['status'];
    data = json['data'];
    count = json['count'] != null ? Count.fromJson(json['count']) : null;
  }
  bool? status;
  int? data;
  Count? count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['data'] = data;
    if (count != null) {
      map['count'] = count?.toJson();
    }
    return map;
  }

}