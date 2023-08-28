/// msg : true
/// userName : ""

class IsTypingModel {
  IsTypingModel({
      bool? msg, 
      String? userName,}){
    _msg = msg;
    _userName = userName;
}

  IsTypingModel.fromJson(dynamic json) {
    _msg = json['msg'];
    _userName = json['userName'];
  }
  bool? _msg;
  String? _userName;
IsTypingModel copyWith({  bool? msg,
  String? userName,
}) => IsTypingModel(  msg: msg ?? _msg,
  userName: userName ?? _userName,
);
  bool? get msg => _msg;
  String? get userName => _userName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['msg'] = _msg;
    map['userName'] = _userName;
    return map;
  }

}