class RequestedList {
  RequestedList({
      required this.date,
      required this.serviceId,
      required this.serviceProviderId,
      required this.feedback,
      required this.rating,
      required this.userId,
      required this.customerStatus,
      required this.dist,
      required this.id,
      required this.serviceStatus,
      required this.userlng,
      required this.userlat,
      required this.username,
      required this.usermobilenumber,
      required this.userprofileimage,
      required this.servicetype,});

  RequestedList.fromJson(dynamic json) {
    date = json['date'];
    serviceId = json['service_id'];
    serviceProviderId = json['service_provider_id'];

    rating = json['rating'];
    userId = json['user_id'];
    customerStatus = json['customer_status'];
    dist = json['dist'];
    id = json['_id'];
    serviceStatus = json['service_status'];
    userlng = json['userlng'];
    userlat = json['userlat'];
    username = json['username'];
    usermobilenumber = json['usermobilenumber'];
    userprofileimage = json['userprofileimage'];
    servicetype = json['servicetype'];
  }
  String? date;
  String? serviceId;
  String? serviceProviderId;
  List<dynamic>? feedback;
  String? rating;
  String? userId;
  String? customerStatus;
  double? dist;
  String? id;
  String? serviceStatus;
  double? userlng;
  double? userlat;
  String? username;
  String? usermobilenumber;
  String? userprofileimage;
  String? servicetype;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = date;
    map['service_id'] = serviceId;
    map['service_provider_id'] = serviceProviderId;
    if (feedback != null) {
      map['feedback'] = feedback?.map((v) => v.toJson()).toList();
    }
    map['rating'] = rating;
    map['user_id'] = userId;
    map['customer_status'] = customerStatus;
    map['dist'] = dist;
    map['_id'] = id;
    map['service_status'] = serviceStatus;
    map['userlng'] = userlng;
    map['userlat'] = userlat;
    map['username'] = username;
    map['usermobilenumber'] = usermobilenumber;
    map['userprofileimage'] = userprofileimage;
    map['servicetype'] = servicetype;
    return map;
  }

}