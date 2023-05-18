class UserDetailsRequestBody {
  UserDetailsRequestBody({
      String? mobileNumber, 
      String? userType,}){
    _mobileNumber = mobileNumber;
    _userType = userType;
}

  UserDetailsRequestBody.fromJson(dynamic json) {
    _mobileNumber = json['mobile_number'];
    _userType = json['user_type'];
  }
  String? _mobileNumber;
  String? _userType;
UserDetailsRequestBody copyWith({  String? mobileNumber,
  String? userType,
}) => UserDetailsRequestBody(  mobileNumber: mobileNumber ?? _mobileNumber,
  userType: userType ?? _userType,
);
  String? get mobileNumber => _mobileNumber;
  String? get userType => _userType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mobile_number'] = _mobileNumber;
    map['user_type'] = _userType;
    return map;
  }

}