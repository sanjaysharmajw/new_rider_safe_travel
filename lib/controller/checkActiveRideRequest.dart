class CheckActiveRideRequest {
  CheckActiveRideRequest({
    String? userId,}){
    _userId = userId;
  }

  CheckActiveRideRequest.fromJson(dynamic json) {
    _userId = json['user_id'];
  }
  String? _userId;
  CheckActiveRideRequest copyWith({  String? userId,
  }) => CheckActiveRideRequest(  userId: userId ?? _userId,
  );
  String? get userId => _userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    return map;
  }

}