/// status : true
/// data : [{"title":"Travel Safe Alert","description":"Hi Sanjay, your family member  Prathamesh b 8286566801 requested for help Please contact.","type":"ride sos alert","status":1,"_id":"63b955a2f8621f00ecd77c14","date":"07-01-2023"},{"title":"Travel Safe Alert","description":"Hi Sanjay, your family member  Prathamesh b 8286566801 requested for help Please contact.","type":"ride sos alert","status":0,"_id":"63b95880779e70c6799a18d8","date":"07-01-2023"},{"title":"Travel Safe Alert","description":"Hi Sanjay, your family member  Prathamesh b 8286566801 requested for help Please contact.","type":"ride sos alert","status":0,"_id":"63b95f006bc686ec22ccc926","date":"07-01-2023"},{"title":"Travel Safe Alert","description":"Hi Sanjay, your family member  Prathamesh b 8286566801 requested for help Please contact.","type":"ride sos alert","status":0,"_id":"63b961311100877bffde699f","date":"07-01-2023"},{"title":"Travel Safe Alert","description":"Hi Sanjay, your family member  Prathamesh b 8286566801 requested for help Please contact.","type":"ride sos alert","status":0,"_id":"63b96d541b82d78607a39ebf","date":"07-01-2023"},{"title":"Travel Safe Alert","description":"Hi Sanjay, your family member  Prathamesh b 8286566801 requested for help Please contact.","type":"ride sos alert","status":0,"_id":"63b96f866cf7e4e359b7b101","date":"07-01-2023"},{"title":"Travel Safe Alert","description":"Hi Sanjay, your family member  Prathamesh b 8286566801 requested for help Please contact.","type":"ride sos alert","status":0,"_id":"63bbb5671e37ef2eb647619f","date":"09-01-2023"},{"title":"Travel Safe Alert","description":"Hi Sanjay, your family member  Prathamesh b 8286566801 requested for help Please contact.","type":"ride sos alert","status":0,"_id":"63bbb5ace1460fbbdfb1fdc4","date":"09-01-2023"},{"title":"Travel Safe Alert","description":"Hi Sanjay, your family member  Prathamesh b 8286566801 requested for help Please contact.","type":"ride sos alert","status":0,"_id":"63bbb8669ba6eb3be3b41b56","date":"09-01-2023"},{"title":"Travel Safe Alert","description":"Hi Sanjay, your family member  Prathamesh b 8286566801 requested for help Please contact.","type":"ride sos alert","status":0,"_id":"63bbba28847a6ebafcd82bcb","date":"09-01-2023"},{"title":"Travel Safe Alert","description":"Hi Sanjay, your family member  Prathamesh b 8286566801 requested for help Please contact.","type":"ride sos alert","status":0,"_id":"63bbbc03be7eb778d46ad187","date":"09-01-2023"},{"title":"Travel Safe Alert","description":"Hi Sanjay, your family member  Prathamesh b 8286566801 requested for help Please contact.","type":"ride sos alert","status":0,"_id":"63bbbc15ab3fb1f2f36ab8cf","date":"09-01-2023"},{"title":"Travel Safe Alert","description":"Hi Sanjay, your family member  Prathamesh b 8286566801 requested for help Please contact.","type":"ride sos alert","status":0,"_id":"63bbc23ed381d16b4280cd4b","date":"09-01-2023"},{"title":"Travel Safe Alert","description":"Hi Sanjay, your family member  Prathamesh b 8286566801 requested for help Please contact.","type":"ride sos alert","status":0,"_id":"63bbc386e18571094310d833","date":"09-01-2023"},{"title":"Travel Safe Alert","description":"Hi Sanjay, your family member  Prathamesh b 8286566801 requested for help Please contact.","type":"ride sos alert","status":0,"_id":"63bbc3a38e4b14609c2d32f0","date":"09-01-2023"},{"title":"Travel Safe Alert","description":"Hi Sanjay, your family member  Prathamesh b 8286566801 requested for help Please contact.","type":"ride sos alert","status":0,"_id":"63bbc3d611c5e5b337235d34","date":"09-01-2023"},{"title":"Travel Safe Alert","description":"Hi Sanjay, your family member  Prathamesh b 8286566801 requested for help Please contact.","type":"ride sos alert","status":0,"_id":"63bbcd68d97cb707d005796f","date":"09-01-2023"},{"title":"Travel Safe Alert","description":"Hi Sanjay, your family member  Prathamesh b 8286566801 requested for help Please contact.","type":"ride sos alert","status":0,"_id":"63bbcd8bd97cb707d0057978","date":"09-01-2023"},{"title":"Travel Safe Alert","description":"Hi sanjay, your family member  Sanjay 1010101010 requested for help Please contact.","type":"ride sos alert","status":0,"_id":"63bc18e6a96d933636cec31a","date":"09-01-2023"},{"title":"Travel Safe Alert","description":"Hi sanjay, your family member  Sanjay 1010101010 requested for help Please contact.","type":"ride sos alert","status":0,"_id":"63bc1909a96d933636cec31d","date":"09-01-2023"},{"title":"Travel Safe Alert","description":"Hi sanjay, your family member  Sanjay 1010101010 requested for help Please contact.","type":"ride sos alert","status":0,"_id":"63bc1909a96d933636cec320","date":"09-01-2023"},{"title":"Travel Safe Alert","description":"Hi sanjay, your family member  Sanjay 1010101010 requested for help Please contact.","type":"ride sos alert","status":0,"_id":"63bcf33b902f603551e3f290","date":"10-01-2023"},{"title":"Travel Safe Alert","description":"Hi sanjay, your family member  Sanjay 1010101010 requested for help Please contact.","type":"ride sos alert","status":0,"_id":"63bd416e9cb96a9952b278cf","date":"10-01-2023"}]

class NotificationModels {
  NotificationModels({
      bool? status,
      List<NotificationData>? data,}){
    _status = status;
    _data = data;
}

  NotificationModels.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(NotificationData.fromJson(v));
      });
    }
  }
  bool? _status;
  List<NotificationData>? _data;
NotificationModels copyWith({  bool? status,
  List<NotificationData>? data,
}) => NotificationModels(  status: status ?? _status,
  data: data ?? _data,
);
  bool? get status => _status;
  List<NotificationData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// title : "Travel Safe Alert"
/// description : "Hi Sanjay, your family member  Prathamesh b 8286566801 requested for help Please contact."
/// type : "ride sos alert"
/// status : 1
/// _id : "63b955a2f8621f00ecd77c14"
/// date : "07-01-2023"

class NotificationData {
  NotificationData({
      String? title, 
      String? description, 
      String? type, 
      num? status, 
      String? id, 
      String? date,}){
    _title = title;
    _description = description;
    _type = type;
    _status = status;
    _id = id;
    _date = date;
}

  NotificationData.fromJson(dynamic json) {
    _title = json['title'];
    _description = json['description'];
    _type = json['type'];
    _status = json['status'];
    _id = json['_id'];
    _date = json['date'];
  }
  String? _title;
  String? _description;
  String? _type;
  num? _status;
  String? _id;
  String? _date;
  NotificationData copyWith({  String? title,
  String? description,
  String? type,
  num? status,
  String? id,
  String? date,
}) => NotificationData(  title: title ?? _title,
  description: description ?? _description,
  type: type ?? _type,
  status: status ?? _status,
  id: id ?? _id,
  date: date ?? _date,
);
  String? get title => _title;
  String? get description => _description;
  String? get type => _type;
  num? get status => _status;
  String? get id => _id;
  String? get date => _date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['description'] = _description;
    map['type'] = _type;
    map['status'] = _status;
    map['_id'] = _id;
    map['date'] = _date;
    return map;
  }

}