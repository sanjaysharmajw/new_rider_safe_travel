class VideoRequest {
  VideoRequest({
    String? type,
    String? userType,}){
    _type = type;
    _userType = userType;
  }

  VideoRequest.fromJson(dynamic json) {
    _type = json['type'];
    _userType = json['user_type'];
  }
  String? _type;
  String? _userType;
  VideoRequest copyWith({  String? type,
    String? userType,
  }) => VideoRequest(  type: type ?? _type,
    userType: userType ?? _userType,
  );
  String? get type => _type;
  String? get userType => _userType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    map['user_type'] = _userType;
    return map;
  }

}