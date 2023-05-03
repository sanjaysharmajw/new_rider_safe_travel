class CompleteServiceRequestModel {
  CompleteServiceRequestModel({
      bool? status, 
      String? message,}){
    _status = status;
    _message = message;
}

  CompleteServiceRequestModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
  }
  bool? _status;
  String? _message;
CompleteServiceRequestModel copyWith({  bool? status,
  String? message,
}) => CompleteServiceRequestModel(  status: status ?? _status,
  message: message ?? _message,
);
  bool? get status => _status;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    return map;
  }

}