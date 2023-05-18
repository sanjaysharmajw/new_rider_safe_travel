class VolunteerStatusRequestBody {
  VolunteerStatusRequestBody({
    String? id,
    String? status,}){
    _id = id;
    _status = status;
  }

  VolunteerStatusRequestBody.fromJson(dynamic json) {
    _id = json['id'];
    _status = json['status'];
  }
  String? _id;
  String? _status;
  VolunteerStatusRequestBody copyWith({  String? id,
    String? status,
  }) => VolunteerStatusRequestBody(  id: id ?? _id,
    status: status ?? _status,
  );
  String? get id => _id;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['status'] = _status;
    return map;
  }

}