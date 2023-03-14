import 'dart:convert';
/// status : true
/// message : "Otp Verified"
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2Nzg4NTc2NzgsImRhdGEiOnsiX2lkIjoiODM1NTgzMTk3MCJ9LCJpYXQiOjE2Nzg3NzEyNzh9.N70xXAzjfkQjnFcFh2jhE23n0i8-5bNyOl9HOeBMwak"

OtpModel otpModelFromJson(String str) => OtpModel.fromJson(json.decode(str));
String otpModelToJson(OtpModel data) => json.encode(data.toJson());
class OtpModel {
  OtpModel({
      bool? status, 
      String? message, 
      String? token,}){
    _status = status;
    _message = message;
    _token = token;
}

  OtpModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _token = json['token'];
  }
  bool? _status;
  String? _message;
  String? _token;
OtpModel copyWith({  bool? status,
  String? message,
  String? token,
}) => OtpModel(  status: status ?? _status,
  message: message ?? _message,
  token: token ?? _token,
);
  bool? get status => _status;
  String? get message => _message;
  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['token'] = _token;
    return map;
  }

}