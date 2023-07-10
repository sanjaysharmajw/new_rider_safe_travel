class GetRideLiveRequest {
  GetRideLiveRequest({
      String? rideId, 
      num? type,}){
    _rideId = rideId;
    _type = type;
}

  GetRideLiveRequest.fromJson(dynamic json) {
    _rideId = json['ride_id'];
    _type = json['type'];
  }
  String? _rideId;
  num? _type;
GetRideLiveRequest copyWith({  String? rideId,
  num? type,
}) => GetRideLiveRequest(  rideId: rideId ?? _rideId,
  type: type ?? _type,
);
  String? get rideId => _rideId;
  num? get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ride_id'] = _rideId;
    map['type'] = _type;
    return map;
  }

}