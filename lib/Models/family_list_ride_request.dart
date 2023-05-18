class FamilyListRideRequest {
  FamilyListRideRequest({
      String? userId, 
      String? mobileNumber,}){
    _userId = userId;
    _mobileNumber = mobileNumber;
}

  FamilyListRideRequest.fromJson(dynamic json) {
    _userId = json['user_id'];
    _mobileNumber = json['mobile_number'];
  }
  String? _userId;
  String? _mobileNumber;
FamilyListRideRequest copyWith({  String? userId,
  String? mobileNumber,
}) => FamilyListRideRequest(  userId: userId ?? _userId,
  mobileNumber: mobileNumber ?? _mobileNumber,
);
  String? get userId => _userId;
  String? get mobileNumber => _mobileNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['mobile_number'] = _mobileNumber;
    return map;
  }

}