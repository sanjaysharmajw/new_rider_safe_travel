class EventRequestBody {
  EventRequestBody({
      String? userId, 
      num? pageNo, 
      num? limit, 
      String? status,}){
    _userId = userId;
    _pageNo = pageNo;
    _limit = limit;
    _status = status;
}

  EventRequestBody.fromJson(dynamic json) {
    _userId = json['user_id'];
    _pageNo = json['page_no'];
    _limit = json['limit'];
    _status = json['status'];
  }
  String? _userId;
  num? _pageNo;
  num? _limit;
  String? _status;
EventRequestBody copyWith({  String? userId,
  num? pageNo,
  num? limit,
  String? status,
}) => EventRequestBody(  userId: userId ?? _userId,
  pageNo: pageNo ?? _pageNo,
  limit: limit ?? _limit,
  status: status ?? _status,
);
  String? get userId => _userId;
  num? get pageNo => _pageNo;
  num? get limit => _limit;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['page_no'] = _pageNo;
    map['limit'] = _limit;
    map['status'] = _status;
    return map;
  }

}