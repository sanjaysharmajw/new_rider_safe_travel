/// userName : "<Rider Name>"
/// userId : "<user id of the rider /driver>"
/// userRole : "Rider"

class GetTokenRequestBody {
  GetTokenRequestBody({
      String? userName, 
      String? userId, 
      String? userRole,}){
    _userName = userName;
    _userId = userId;
    _userRole = userRole;
}

  GetTokenRequestBody.fromJson(dynamic json) {
    _userName = json['userName'];
    _userId = json['userId'];
    _userRole = json['userRole'];
  }
  String? _userName;
  String? _userId;
  String? _userRole;
GetTokenRequestBody copyWith({  String? userName,
  String? userId,
  String? userRole,
}) => GetTokenRequestBody(  userName: userName ?? _userName,
  userId: userId ?? _userId,
  userRole: userRole ?? _userRole,
);
  String? get userName => _userName;
  String? get userId => _userId;
  String? get userRole => _userRole;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userName'] = _userName;
    map['userId'] = _userId;
    map['userRole'] = _userRole;
    return map;
  }

}