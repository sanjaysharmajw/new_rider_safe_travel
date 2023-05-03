import 'dart:convert';
RequestedListModel requestedListModelFromJson(String str) => RequestedListModel.fromJson(json.decode(str));
String requestedListModelToJson(RequestedListModel data) => json.encode(data.toJson());
class RequestedListModel {
  RequestedListModel({
      bool? status, 
      List<requestedListData>? data,}){
    _status = status;
    _data = data;
}

  RequestedListModel.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(requestedListData.fromJson(v));
      });
    }
  }
  bool? _status;
  List<requestedListData>? _data;
RequestedListModel copyWith({  bool? status,
  List<requestedListData>? data,
}) => RequestedListModel(  status: status ?? _status,
  data: data ?? _data,
);
  bool? get status => _status;
  List<requestedListData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

requestedListData dataFromJson(String str) => requestedListData.fromJson(json.decode(str));
String dataToJson(requestedListData data) => json.encode(data.toJson());
class requestedListData {
  requestedListData({
      String? date, 
      String? serviceId, 
      String? serviceProviderId, 
      List<dynamic>? feedback, 
      String? rating, 
      String? userId, 
      String? customerStatus, 
      String? id, 
      num? dist, 
      String? serviceStatus, 
      num? userlng, 
      num? userlat, 
      String? username, 
      String? usermobilenumber, 
      String? userprofileimage, 
      String? providername, 
      String? providermobilenumber, 
      String? providerprofileimage, 
      String? servicetype,}){
    _date = date;
    _serviceId = serviceId;
    _serviceProviderId = serviceProviderId;
    _feedback = feedback;
    _rating = rating;
    _userId = userId;
    _customerStatus = customerStatus;
    _id = id;
    _dist = dist;
    _serviceStatus = serviceStatus;
    _userlng = userlng;
    _userlat = userlat;
    _username = username;
    _usermobilenumber = usermobilenumber;
    _userprofileimage = userprofileimage;
    _providername = providername;
    _providermobilenumber = providermobilenumber;
    _providerprofileimage = providerprofileimage;
    _servicetype = servicetype;
}

  requestedListData.fromJson(dynamic json) {
    _date = json['date'];
    _serviceId = json['service_id'];
    _serviceProviderId = json['service_provider_id'];

    _rating = json['rating'];
    _userId = json['user_id'];
    _customerStatus = json['customer_status'];
    _id = json['_id'];
    _dist = json['dist'];
    _serviceStatus = json['service_status'];
    _userlng = json['userlng'];
    _userlat = json['userlat'];
    _username = json['username'];
    _usermobilenumber = json['usermobilenumber'];
    _userprofileimage = json['userprofileimage'];
    _providername = json['providername'];
    _providermobilenumber = json['providermobilenumber'];
    _providerprofileimage = json['providerprofileimage'];
    _servicetype = json['servicetype'];
  }
  String? _date;
  String? _serviceId;
  String? _serviceProviderId;
  List<dynamic>? _feedback;
  String? _rating;
  String? _userId;
  String? _customerStatus;
  String? _id;
  num? _dist;
  String? _serviceStatus;
  num? _userlng;
  num? _userlat;
  String? _username;
  String? _usermobilenumber;
  String? _userprofileimage;
  String? _providername;
  String? _providermobilenumber;
  String? _providerprofileimage;
  String? _servicetype;
  requestedListData copyWith({  String? date,
  String? serviceId,
  String? serviceProviderId,
  List<dynamic>? feedback,
  String? rating,
  String? userId,
  String? customerStatus,
  String? id,
  num? dist,
  String? serviceStatus,
  num? userlng,
  num? userlat,
  String? username,
  String? usermobilenumber,
  String? userprofileimage,
  String? providername,
  String? providermobilenumber,
  String? providerprofileimage,
  String? servicetype,
}) => requestedListData(  date: date ?? _date,
  serviceId: serviceId ?? _serviceId,
  serviceProviderId: serviceProviderId ?? _serviceProviderId,
  feedback: feedback ?? _feedback,
  rating: rating ?? _rating,
  userId: userId ?? _userId,
  customerStatus: customerStatus ?? _customerStatus,
  id: id ?? _id,
  dist: dist ?? _dist,
  serviceStatus: serviceStatus ?? _serviceStatus,
  userlng: userlng ?? _userlng,
  userlat: userlat ?? _userlat,
  username: username ?? _username,
  usermobilenumber: usermobilenumber ?? _usermobilenumber,
  userprofileimage: userprofileimage ?? _userprofileimage,
  providername: providername ?? _providername,
  providermobilenumber: providermobilenumber ?? _providermobilenumber,
  providerprofileimage: providerprofileimage ?? _providerprofileimage,
  servicetype: servicetype ?? _servicetype,
);
  String? get date => _date;
  String? get serviceId => _serviceId;
  String? get serviceProviderId => _serviceProviderId;
  List<dynamic>? get feedback => _feedback;
  String? get rating => _rating;
  String? get userId => _userId;
  String? get customerStatus => _customerStatus;
  String? get id => _id;
  num? get dist => _dist;
  String? get serviceStatus => _serviceStatus;
  num? get userlng => _userlng;
  num? get userlat => _userlat;
  String? get username => _username;
  String? get usermobilenumber => _usermobilenumber;
  String? get userprofileimage => _userprofileimage;
  String? get providername => _providername;
  String? get providermobilenumber => _providermobilenumber;
  String? get providerprofileimage => _providerprofileimage;
  String? get servicetype => _servicetype;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = _date;
    map['service_id'] = _serviceId;
    map['service_provider_id'] = _serviceProviderId;
    if (_feedback != null) {
      map['feedback'] = _feedback?.map((v) => v.toJson()).toList();
    }
    map['rating'] = _rating;
    map['user_id'] = _userId;
    map['customer_status'] = _customerStatus;
    map['_id'] = _id;
    map['dist'] = _dist;
    map['service_status'] = _serviceStatus;
    map['userlng'] = _userlng;
    map['userlat'] = _userlat;
    map['username'] = _username;
    map['usermobilenumber'] = _usermobilenumber;
    map['userprofileimage'] = _userprofileimage;
    map['providername'] = _providername;
    map['providermobilenumber'] = _providermobilenumber;
    map['providerprofileimage'] = _providerprofileimage;
    map['servicetype'] = _servicetype;
    return map;
  }

}