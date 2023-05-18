class GetVolunteerRequestBody {
  GetVolunteerRequestBody({
    String? userId,
    String? status,
    String? lat,
    String? lng,}){
    _userId = userId;
    _status = status;
    _lat = lat;
    _lng = lng;
  }

  GetVolunteerRequestBody.fromJson(dynamic json) {
    _userId = json['user_id'];
    _status = json['status'];
    _lat = json['lat'];
    _lng = json['lng'];
  }
  String? _userId;
  String? _status;
  String? _lat;
  String? _lng;
  GetVolunteerRequestBody copyWith({  String? userId,
    String? status,
    String? lat,
    String? lng,
  }) => GetVolunteerRequestBody(  userId: userId ?? _userId,
    status: status ?? _status,
    lat: lat ?? _lat,
    lng: lng ?? _lng,
  );
  String? get userId => _userId;
  String? get status => _status;
  String? get lat => _lat;
  String? get lng => _lng;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['status'] = _status;
    map['lat'] = _lat;
    map['lng'] = _lng;
    return map;
  }

}