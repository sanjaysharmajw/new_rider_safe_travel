class CompleteServiceRequestBody {
  CompleteServiceRequestBody({
      String? serviceId, 
      String? userId, 
      String? feedback,
  double? rating}){
    _serviceId = serviceId;
    _userId = userId;
    _feedback = feedback;
    _rating = rating;
}

  CompleteServiceRequestBody.fromJson(dynamic json) {
    _serviceId = json['service_id'];
    _userId = json['user_id'];
    _feedback = json['feedback'];
    _rating = json['rating'];
  }
  String? _serviceId;
  String? _userId;
  String? _feedback;
  double? _rating;
CompleteServiceRequestBody copyWith({  String? serviceId,
  String? userId,
  String? feedback,
  double? rating,
}) => CompleteServiceRequestBody(  serviceId: serviceId ?? _serviceId,
  userId: userId ?? _userId,
  feedback: feedback ?? _feedback,
  rating: rating ?? _rating,
);
  String? get serviceId => _serviceId;
  String? get userId => _userId;
  String? get feedback => _feedback;
  double? get rating => _rating;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['service_id'] = _serviceId;
    map['user_id'] = _userId;
    map['feedback'] = _feedback;
    map['rating'] = _rating;
    return map;
  }

}