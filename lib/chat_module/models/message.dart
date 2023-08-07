import 'package:ride_safe_travel/Utils/utils_class.dart';

/// msg : "cdcd"
/// userName : "css"
/// chatTime : "01:02"
/// fromMe : false

class Message {
  Message({
      String? msg, 
      String? userName, 
      String? chatTime, 
      bool? fromMe}){
    _msg = msg;
    _userName = userName;
    _chatTime = chatTime;
    _fromMe = fromMe;
}

  Message.fromJson(dynamic json) {
    _msg = json['msg'];
    _userName = json['userName'];
    _chatTime = MyUtils.getFormattedTimeEvent(DateTime.now().millisecondsSinceEpoch);
    _fromMe = false;
  }
  String? _msg;
  String? _userName;
  String? _chatTime;
  bool? _fromMe;
Message copyWith({  String? msg,
  String? userName,
  String? chatTime,
  bool? fromMe,
}) => Message(  msg: msg ?? _msg,
  userName: userName ?? _userName,
  chatTime: chatTime ?? _chatTime,
  fromMe: fromMe ?? _fromMe,
);
  String? get msg => _msg;
  String? get userName => _userName;
  String? get chatTime => _chatTime;
  bool? get fromMe => _fromMe;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['msg'] = _msg;
    map['userName'] = _userName;
    map['chatTime'] = _chatTime;
    map['fromMe'] = _fromMe;
    return map;
  }

}