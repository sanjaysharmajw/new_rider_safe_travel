import 'dart:convert';
/// status : true
/// message : "User profile has been updated successfully"

UpdateRiderProfileModel updateRiderProfileModelFromJson(String str) => UpdateRiderProfileModel.fromJson(json.decode(str));
String updateRiderProfileModelToJson(UpdateRiderProfileModel data) => json.encode(data.toJson());
class UpdateRiderProfileModel {
  UpdateRiderProfileModel({
    bool? status,
    String? message,}){
    _status = status;
    _message = message;
  }

  UpdateRiderProfileModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
  }
  bool? _status;
  String? _message;
  UpdateRiderProfileModel copyWith({  bool? status,
    String? message,
  }) => UpdateRiderProfileModel(  status: status ?? _status,
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