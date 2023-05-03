class GetRideRequestBody {
  GetRideRequestBody({
      String? rideId,}){
    _rideId = rideId;
}

  GetRideRequestBody.fromJson(dynamic json) {
    _rideId = json['ride_id'];
  }
  String? _rideId;
GetRideRequestBody copyWith({  String? rideId,
}) => GetRideRequestBody(  rideId: rideId ?? _rideId,
);
  String? get rideId => _rideId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ride_id'] = _rideId;
    return map;
  }

}