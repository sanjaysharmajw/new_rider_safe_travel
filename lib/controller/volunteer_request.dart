class VolunteerRequest {
  VolunteerRequest({
      String? userId, 
      String? volunteer, 
      String? lat, 
      String? lng, 
      List<String>? volunteerAri,}){
    _userId = userId;
    _volunteer = volunteer;
    _lat = lat;
    _lng = lng;
    _volunteerAri = volunteerAri;
}

  VolunteerRequest.fromJson(dynamic json) {
    _userId = json['user_id'];
    _volunteer = json['volunteer'];
    _lat = json['lat'];
    _lng = json['lng'];
    _volunteerAri = json['volunteer_ari'] != null ? json['volunteer_ari'].cast<String>() : [];
  }
  String? _userId;
  String? _volunteer;
  String? _lat;
  String? _lng;
  List<String>? _volunteerAri;
VolunteerRequest copyWith({  String? userId,
  String? volunteer,
  String? lat,
  String? lng,
  List<String>? volunteerAri,
}) => VolunteerRequest(  userId: userId ?? _userId,
  volunteer: volunteer ?? _volunteer,
  lat: lat ?? _lat,
  lng: lng ?? _lng,
  volunteerAri: volunteerAri ?? _volunteerAri,
);
  String? get userId => _userId;
  String? get volunteer => _volunteer;
  String? get lat => _lat;
  String? get lng => _lng;
  List<String>? get volunteerAri => _volunteerAri;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['volunteer'] = _volunteer;
    map['lat'] = _lat;
    map['lng'] = _lng;
    map['volunteer_ari'] = _volunteerAri;
    return map;
  }

}