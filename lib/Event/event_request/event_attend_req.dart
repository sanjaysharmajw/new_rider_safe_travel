class EventAttendReq {
  EventAttendReq({
      String? userId, 
      String? eventId, 
      String? status,}){
    _userId = userId;
    _eventId = eventId;
    _status = status;
}

  EventAttendReq.fromJson(dynamic json) {
    _userId = json['user_id'];
    _eventId = json['event_id'];
    _status = json['status'];
  }
  String? _userId;
  String? _eventId;
  String? _status;
EventAttendReq copyWith({  String? userId,
  String? eventId,
  String? status,
}) => EventAttendReq(  userId: userId ?? _userId,
  eventId: eventId ?? _eventId,
  status: status ?? _status,
);
  String? get userId => _userId;
  String? get eventId => _eventId;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['event_id'] = _eventId;
    map['status'] = _status;
    return map;
  }

}