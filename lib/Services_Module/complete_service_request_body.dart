class CompleteServiceRequestBody {
  CompleteServiceRequestBody({
      String? serviceId, 
      String? userId, 
      String? feedback,}){
    _serviceId = serviceId;
    _userId = userId;
    _feedback = feedback;
}

  CompleteServiceRequestBody.fromJson(dynamic json) {
    _serviceId = json['service_id'];
    _userId = json['user_id'];
    _feedback = json['feedback'];
  }
  String? _serviceId;
  String? _userId;
  String? _feedback;
CompleteServiceRequestBody copyWith({  String? serviceId,
  String? userId,
  String? feedback,
}) => CompleteServiceRequestBody(  serviceId: serviceId ?? _serviceId,
  userId: userId ?? _userId,
  feedback: feedback ?? _feedback,
);
  String? get serviceId => _serviceId;
  String? get userId => _userId;
  String? get feedback => _feedback;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['service_id'] = _serviceId;
    map['user_id'] = _userId;
    map['feedback'] = _feedback;
    return map;
  }

}