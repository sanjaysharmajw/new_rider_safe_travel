class AcceptRejectBodyRequest {
  AcceptRejectBodyRequest({
      String? id, 
      String? status, 
      String? userId,}){
    _id = id;
    _status = status;
    _userId = userId;
}

  AcceptRejectBodyRequest.fromJson(dynamic json) {
    _id = json['id'];
    _status = json['status'];
    _userId = json['user_id'];
  }
  String? _id;
  String? _status;
  String? _userId;
AcceptRejectBodyRequest copyWith({  String? id,
  String? status,
  String? userId,
}) => AcceptRejectBodyRequest(  id: id ?? _id,
  status: status ?? _status,
  userId: userId ?? _userId,
);
  String? get id => _id;
  String? get status => _status;
  String? get userId => _userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['status'] = _status;
    map['user_id'] = _userId;
    return map;
  }

}