import 'MessageResp.dart';

class SosControllerModel {
  SosControllerModel({
      required this.status,
      required this.messageResp,
      required this.message,});

  SosControllerModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['message_resp'] != null) {
      messageResp = [];
      json['message_resp'].forEach((v) {
        messageResp?.add(MessageResp.fromJson(v));
      });
    }
    message = json['message'];
  }
  bool? status;
  List<MessageResp>? messageResp;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (messageResp != null) {
      map['message_resp'] = messageResp?.map((v) => v.toJson()).toList();
    }
    map['message'] = message;
    return map;
  }

}