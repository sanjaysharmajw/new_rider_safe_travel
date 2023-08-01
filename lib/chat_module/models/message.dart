/// msg : "ssss"
/// userName : "sanjay"
/// fromMe : true

class Message {
  Message({
      String? msg, 
      String? userName, 
      bool? fromMe=false}){
    _msg = msg;
    _userName = userName;
    _fromMe = fromMe;
}

  Message.fromJson(dynamic json) {
    _msg = json['msg'];
    _userName = json['userName'];
    _fromMe = false;
  }
  String? _msg;
  String? _userName;
  bool? _fromMe=false;
Message copyWith({  String? msg,
  String? userName,
  bool? fromMe,
}) => Message(  msg: msg ?? _msg,
  userName: userName ?? _userName,
  fromMe: fromMe ?? _fromMe,
);
  String? get msg => _msg;
  String? get userName => _userName;
  bool? get fromMe => _fromMe;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['msg'] = _msg;
    map['userName'] = _userName;
    map['fromMe'] = _fromMe;
    return map;
  }

}