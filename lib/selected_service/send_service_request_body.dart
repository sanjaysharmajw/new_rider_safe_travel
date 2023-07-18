class SendServiceRequestBody {
  SendServiceRequestBody({
      String? serviceId, 
      String? id, 
      String? comment, 
      String? serviceProviderId, 
      num? lng, 
      num? lat, 
      String? userId,}){
    _serviceId = serviceId;
    _id = id;
    _comment = comment;
    _serviceProviderId = serviceProviderId;
    _lng = lng;
    _lat = lat;
    _userId = userId;
}

  SendServiceRequestBody.fromJson(dynamic json) {
    _serviceId = json['service_id'];
    _id = json['id'];
    _comment = json['comment'];
    _serviceProviderId = json['service_provider_id'];
    _lng = json['lng'];
    _lat = json['lat'];
    _userId = json['user_id'];
  }
  String? _serviceId;
  String? _id;
  String? _comment;
  String? _serviceProviderId;
  num? _lng;
  num? _lat;
  String? _userId;
SendServiceRequestBody copyWith({  String? serviceId,
  String? id,
  String? comment,
  String? serviceProviderId,
  num? lng,
  num? lat,
  String? userId,
}) => SendServiceRequestBody(  serviceId: serviceId ?? _serviceId,
  id: id ?? _id,
  comment: comment ?? _comment,
  serviceProviderId: serviceProviderId ?? _serviceProviderId,
  lng: lng ?? _lng,
  lat: lat ?? _lat,
  userId: userId ?? _userId,
);
  String? get serviceId => _serviceId;
  String? get id => _id;
  String? get comment => _comment;
  String? get serviceProviderId => _serviceProviderId;
  num? get lng => _lng;
  num? get lat => _lat;
  String? get userId => _userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['service_id'] = _serviceId;
    map['id'] = _id;
    map['comment'] = _comment;
    map['service_provider_id'] = _serviceProviderId;
    map['lng'] = _lng;
    map['lat'] = _lat;
    map['user_id'] = _userId;
    return map;
  }

}