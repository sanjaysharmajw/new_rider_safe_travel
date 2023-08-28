class EventModels {
  EventModels({
      bool? status, 
      List<EventListData>? data,}){
    _status = status;
    _data = data;
}

  EventModels.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(EventListData.fromJson(v));
      });
    }
  }
  bool? _status;
  List<EventListData>? _data;
EventModels copyWith({  bool? status,
  List<EventListData>? data,
}) => EventModels(  status: status ?? _status,
  data: data ?? _data,
);
  bool? get status => _status;
  List<EventListData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class EventListData {
  EventListData({
      String? id, 
      String? name, 
      String? description, 
      String? city, 
      String? state, 
      String? pincode, 
      String? imageUrl, 
      String? fromDate, 
      String? toDate, 
      String? time, 
      String? status, 
      String? address, 
      num? views,}){
    _id = id;
    _name = name;
    _description = description;
    _city = city;
    _state = state;
    _pincode = pincode;
    _imageUrl = imageUrl;
    _fromDate = fromDate;
    _toDate = toDate;
    _time = time;
    _status = status;
    _address = address;
    _views = views;
}

  EventListData.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _description = json['description'];
    _city = json['city'];
    _state = json['state'];
    _pincode = json['pincode'];
    _imageUrl = json['image_url'];
    _fromDate = json['from_date'];
    _toDate = json['to_date'];
    _time = json['time'];
    _status = json['status'];
    _address = json['address'];
    _views = json['views'];
  }
  String? _id;
  String? _name;
  String? _description;
  String? _city;
  String? _state;
  String? _pincode;
  String? _imageUrl;
  String? _fromDate;
  String? _toDate;
  String? _time;
  String? _status;
  String? _address;
  num? _views;
  EventListData copyWith({  String? id,
  String? name,
  String? description,
  String? city,
  String? state,
  String? pincode,
  String? imageUrl,
  String? fromDate,
  String? toDate,
  String? time,
  String? status,
  String? address,
  num? views,
}) => EventListData(  id: id ?? _id,
  name: name ?? _name,
  description: description ?? _description,
  city: city ?? _city,
  state: state ?? _state,
  pincode: pincode ?? _pincode,
  imageUrl: imageUrl ?? _imageUrl,
  fromDate: fromDate ?? _fromDate,
  toDate: toDate ?? _toDate,
  time: time ?? _time,
  status: status ?? _status,
  address: address ?? _address,
  views: views ?? _views,
);
  String? get id => _id;
  String? get name => _name;
  String? get description => _description;
  String? get city => _city;
  String? get state => _state;
  String? get pincode => _pincode;
  String? get imageUrl => _imageUrl;
  String? get fromDate => _fromDate;
  String? get toDate => _toDate;
  String? get time => _time;
  String? get status => _status;
  String? get address => _address;
  num? get views => _views;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['description'] = _description;
    map['city'] = _city;
    map['state'] = _state;
    map['pincode'] = _pincode;
    map['image_url'] = _imageUrl;
    map['from_date'] = _fromDate;
    map['to_date'] = _toDate;
    map['time'] = _time;
    map['status'] = _status;
    map['address'] = _address;
    map['views'] = _views;
    return map;
  }

}