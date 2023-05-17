import 'dart:convert';


VolunteerRequest volunteerRequestFromJson(String str) => VolunteerRequest.fromJson(json.decode(str));
String volunteerRequestToJson(VolunteerRequest data) => json.encode(data.toJson());


class VolunteerRequest {
  VolunteerRequest({
      String? userId, 
      String? volunteer, 
      List<VolunteerAri>? volunteerAri, 
      dynamic lat, 
      dynamic lng,}){
    _userId = userId;
    _volunteer = volunteer;
    _volunteerAri = volunteerAri;
    _lat = lat;
    _lng = lng;
}

  VolunteerRequest.fromJson(dynamic json) {
    _userId = json['user_id'];
    _volunteer = json['volunteer'];
    if (json['volunteer_ari'] != null) {
      _volunteerAri = [];
      json['volunteer_ari'].forEach((v) {
        _volunteerAri?.add(VolunteerAri.fromJson(v));
      });
    }
    _lat = json['lat'];
    _lng = json['lng'];
  }
  String? _userId;
  String? _volunteer;
  List<VolunteerAri>? _volunteerAri;
  dynamic _lat;
  dynamic _lng;
VolunteerRequest copyWith({  String? userId,
  String? volunteer,
  List<VolunteerAri>? volunteerAri,
  dynamic lat,
  dynamic lng,
}) => VolunteerRequest(  userId: userId ?? _userId,
  volunteer: volunteer ?? _volunteer,
  volunteerAri: volunteerAri ?? _volunteerAri,
  lat: lat ?? _lat,
  lng: lng ?? _lng,
);
  String? get userId => _userId;
  String? get volunteer => _volunteer;
  List<VolunteerAri>? get volunteerAri => _volunteerAri;
  dynamic get lat => _lat;
  dynamic get lng => _lng;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['volunteer'] = _volunteer;
    if (_volunteerAri != null) {
      map['volunteer_ari'] = _volunteerAri?.map((v) => v.toJson()).toList();
    }
    map['lat'] = _lat;
    map['lng'] = _lng;
    return map;
  }

}

VolunteerAri volunteerAriFromJson(String str) => VolunteerAri.fromJson(json.decode(str));
String volunteerAriToJson(VolunteerAri data) => json.encode(data.toJson());
class VolunteerAri {
  VolunteerAri({
      String? id, 
      String? name,}){
    _id = id;
    _name = name;
}

  VolunteerAri.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  String? _id;
  String? _name;
VolunteerAri copyWith({  String? id,
  String? name,
}) => VolunteerAri(  id: id ?? _id,
  name: name ?? _name,
);
  String? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }

}