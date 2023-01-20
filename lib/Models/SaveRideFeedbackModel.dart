import 'dart:convert';
/// status : false
/// message : "Ride details not found"

SaveRideFeedbackModel saveRideFeedbackModelFromJson(String str) => SaveRideFeedbackModel.fromJson(json.decode(str));
String saveRideFeedbackModelToJson(SaveRideFeedbackModel data) => json.encode(data.toJson());
class SaveRideFeedbackModel {
  SaveRideFeedbackModel({
      bool? status, 
      String? message,}){
    _status = status;
    _message = message;
}

  SaveRideFeedbackModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
  }
  bool? _status;
  String? _message;
SaveRideFeedbackModel copyWith({  bool? status,
  String? message,
}) => SaveRideFeedbackModel(  status: status ?? _status,
  message: message ?? _message,
);
  bool? get status => _status;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    return map;
  }

}