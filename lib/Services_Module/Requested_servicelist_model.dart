import 'RequestedListModel.dart';

class RequestedServicelistModel {
  RequestedServicelistModel({
      this.status, 
      this.data,});

  RequestedServicelistModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(RequestedList.fromJson(v));
      });
    }
  }
  bool? status;
  List<RequestedList>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}