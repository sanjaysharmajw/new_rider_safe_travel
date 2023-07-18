class SearchServiceReqestBody {
  SearchServiceReqestBody({
      String? serviceId, 
      num? lat, 
      num? lng,}){
    _serviceId = serviceId;
    _lat = lat;
    _lng = lng;
}

  SearchServiceReqestBody.fromJson(dynamic json) {
    _serviceId = json['service_id'];
    _lat = json['lat'];
    _lng = json['lng'];
  }
  String? _serviceId;
  num? _lat;
  num? _lng;
SearchServiceReqestBody copyWith({  String? serviceId,
  num? lat,
  num? lng,
}) => SearchServiceReqestBody(  serviceId: serviceId ?? _serviceId,
  lat: lat ?? _lat,
  lng: lng ?? _lng,
);
  String? get serviceId => _serviceId;
  num? get lat => _lat;
  num? get lng => _lng;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['service_id'] = _serviceId;
    map['lat'] = _lat;
    map['lng'] = _lng;
    return map;
  }

}