class UserDetailsRequestBody {
  UserDetailsRequestBody({
      String? mobileNumber,}){
    _mobileNumber = mobileNumber;
}

  UserDetailsRequestBody.fromJson(dynamic json) {
    _mobileNumber = json['mobile_number'];
  }
  String? _mobileNumber;
UserDetailsRequestBody copyWith({  String? mobileNumber,
}) => UserDetailsRequestBody(  mobileNumber: mobileNumber ?? _mobileNumber,
);
  String? get mobileNumber => _mobileNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mobile_number'] = _mobileNumber;
    return map;
  }

}