import 'dart:convert';
/// status : true
/// message : "Thank you your feedback has been submitted successfully"

SaveUserFeedback saveUserFeedbackFromJson(String str) => SaveUserFeedback.fromJson(json.decode(str));
String saveUserFeedbackToJson(SaveUserFeedback data) => json.encode(data.toJson());
class SaveUserFeedback {
  SaveUserFeedback({
      bool? status, 
      String? message,}){
    _status = status;
    _message = message;
}

  SaveUserFeedback.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
  }
  bool? _status;
  String? _message;
SaveUserFeedback copyWith({  bool? status,
  String? message,
}) => SaveUserFeedback(  status: status ?? _status,
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