class Demo {
  Demo({
      String? userId, 
      String? volunteer, 
      List<VolunteerAri>? volunteerAri,}){
    _userId = userId;
    _volunteer = volunteer;
    _volunteerAri = volunteerAri;
}

  Demo.fromJson(dynamic json) {
    _userId = json['user_id'];
    _volunteer = json['volunteer'];
    if (json['volunteer_ari'] != null) {
      _volunteerAri = [];
      json['volunteer_ari'].forEach((v) {
        _volunteerAri?.add(VolunteerAri.fromJson(v));
      });
    }
  }
  String? _userId;
  String? _volunteer;
  List<VolunteerAri>? _volunteerAri;
Demo copyWith({  String? userId,
  String? volunteer,
  List<VolunteerAri>? volunteerAri,
}) => Demo(  userId: userId ?? _userId,
  volunteer: volunteer ?? _volunteer,
  volunteerAri: volunteerAri ?? _volunteerAri,
);
  String? get userId => _userId;
  String? get volunteer => _volunteer;
  List<VolunteerAri>? get volunteerAri => _volunteerAri;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['volunteer'] = _volunteer;
    if (_volunteerAri != null) {
      map['volunteer_ari'] = _volunteerAri?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

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