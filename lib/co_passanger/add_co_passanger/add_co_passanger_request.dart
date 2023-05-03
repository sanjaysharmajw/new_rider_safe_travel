class AddCoPassangerRequest {
  AddCoPassangerRequest({
      String? rideId,
      String? userId,
      String? name,
      num? age,
      String? gender,
      String? bloodgroup,}){
    _rideId = rideId;
    _userId = userId;
    _name = name;
    _age = age;
    _gender = gender;
    _bloodgroup = bloodgroup;
}

  AddCoPassangerRequest.fromJson(dynamic json) {
    _rideId = json['ride_id'];
    _userId = json['user_id'];
    _name = json['name'];
    _age = json['age'];
    _gender = json['gender'];
    _bloodgroup = json['bloodgroup'];
  }
  String? _rideId;
  String? _userId;
  String? _name;
  num? _age;
  String? _gender;
  String? _bloodgroup;
AddCoPassangerRequest copyWith({  String? rideId,
  String? userId,
  String? name,
  num? age,
  String? gender,
  String? bloodgroup,
}) => AddCoPassangerRequest(  rideId: rideId ?? _rideId,
  userId: userId ?? _userId,
  name: name ?? _name,
  age: age ?? _age,
  gender: gender ?? _gender,
  bloodgroup: bloodgroup ?? _bloodgroup,
);
  String? get rideId => _rideId;
  String? get userId => _userId;
  String? get name => _name;
  num? get age => _age;
  String? get gender => _gender;
  String? get bloodgroup => _bloodgroup;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ride_id'] = _rideId;
    map['user_id'] = _userId;
    map['name'] = _name;
    map['age'] = _age;
    map['gender'] = _gender;
    map['bloodgroup'] = _bloodgroup;
    return map;
  }

}