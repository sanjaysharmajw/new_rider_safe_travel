class MultiMarkerRequest {
  MultiMarkerRequest({
      String? userId, 
      String? rideId, 
      bool? showstops,}){
    _userId = userId;
    _rideId = rideId;
    _showstops = showstops;
}

  MultiMarkerRequest.fromJson(dynamic json) {
    _userId = json['user_id'];
    _rideId = json['ride_id'];
    _showstops = json['showstops'];
  }
  String? _userId;
  String? _rideId;
  bool? _showstops;
MultiMarkerRequest copyWith({  String? userId,
  String? rideId,
  bool? showstops,
}) => MultiMarkerRequest(  userId: userId ?? _userId,
  rideId: rideId ?? _rideId,
  showstops: showstops ?? _showstops,
);
  String? get userId => _userId;
  String? get rideId => _rideId;
  bool? get showstops => _showstops;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['ride_id'] = _rideId;
    map['showstops'] = _showstops;
    return map;
  }

}