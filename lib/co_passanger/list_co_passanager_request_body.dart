class ListCoPassanagerRequestBody {
  ListCoPassanagerRequestBody({
      String? rideId,}){
    _rideId = rideId;
}

  ListCoPassanagerRequestBody.fromJson(dynamic json) {
    _rideId = json['ride_id'];
  }
  String? _rideId;
ListCoPassanagerRequestBody copyWith({  String? rideId,
}) => ListCoPassanagerRequestBody(  rideId: rideId ?? _rideId,
);
  String? get rideId => _rideId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ride_id'] = _rideId;
    return map;
  }

}