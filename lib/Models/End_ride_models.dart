class EndRideModels {
  EndRideModels({
      this.status, 
      this.message,});

  EndRideModels.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
  }
  bool status;
  String message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    return map;
  }

}