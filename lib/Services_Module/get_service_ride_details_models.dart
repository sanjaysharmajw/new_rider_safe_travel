class GetServiceRideDetailsModels {
  GetServiceRideDetailsModels({
      bool? status, 
      String? message, 
      List<ServiceRideData>? data,
      String? token,}){
    _status = status;
    _message = message;
    _data = data;
    _token = token;
}

  GetServiceRideDetailsModels.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ServiceRideData.fromJson(v));
      });
    }
    _token = json['token'];
  }
  bool? _status;
  String? _message;
  List<ServiceRideData>? _data;
  String? _token;
GetServiceRideDetailsModels copyWith({  bool? status,
  String? message,
  List<ServiceRideData>? data,
  String? token,
}) => GetServiceRideDetailsModels(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
  token: token ?? _token,
);
  bool? get status => _status;
  String? get message => _message;
  List<ServiceRideData>? get data => _data;
  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['token'] = _token;
    return map;
  }

}

class ServiceRideData {
  ServiceRideData({
      String? id, 
      String? userId, 
      String? driverId, 
      String? date, 
      dynamic fromDestination, 
      dynamic toDestination, 
      StartPoint? startPoint, 
      dynamic endPoint, 
      List<StartPointDetails>? startPointDetails, 
      List<dynamic>? endPointDetails, 
      List<dynamic>? stops, 
      dynamic distance, 
      dynamic totalTime, 
      String? customerFeedback, 
      String? driverFeedback, 
      String? rating, 
      String? status, 
      String? createdAt, 
      String? updatedAt, 
      String? createdBy, 
      String? updatedBy, 
      dynamic groupId, 
      dynamic detailsMatchCheck, 
      dynamic detailsMatchComment, 
      num? rideStartOtp, 
      String? verifyStartOtp, 
      String? serviceId,}){
    _id = id;
    _userId = userId;
    _driverId = driverId;
    _date = date;
    _fromDestination = fromDestination;
    _toDestination = toDestination;
    _startPoint = startPoint;
    _endPoint = endPoint;
    _startPointDetails = startPointDetails;
    _endPointDetails = endPointDetails;
    _stops = stops;
    _distance = distance;
    _totalTime = totalTime;
    _customerFeedback = customerFeedback;
    _driverFeedback = driverFeedback;
    _rating = rating;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _createdBy = createdBy;
    _updatedBy = updatedBy;
    _groupId = groupId;
    _detailsMatchCheck = detailsMatchCheck;
    _detailsMatchComment = detailsMatchComment;
    _rideStartOtp = rideStartOtp;
    _verifyStartOtp = verifyStartOtp;
    _serviceId = serviceId;
}

  ServiceRideData.fromJson(dynamic json) {
    _id = json['_id'];
    _userId = json['user_id'];
    _driverId = json['driver_id'];
    _date = json['date'];
    _fromDestination = json['from_destination'];
    _toDestination = json['to_destination'];
    _startPoint = json['start_point'] != null ? StartPoint.fromJson(json['start_point']) : null;
    _endPoint = json['end_point'];
    if (json['start_point_details'] != null) {
      _startPointDetails = [];
      json['start_point_details'].forEach((v) {
        _startPointDetails?.add(StartPointDetails.fromJson(v));
      });
    }
    _distance = json['distance'];
    _totalTime = json['total_time'];
    _customerFeedback = json['customer_feedback'];
    _driverFeedback = json['driver_feedback'];
    _rating = json['rating'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _createdBy = json['created_by'];
    _updatedBy = json['updated_by'];
    _groupId = json['group_id'];
    _detailsMatchCheck = json['details_match_check'];
    _detailsMatchComment = json['details_match_comment'];
    _rideStartOtp = json['ride_start_otp'];
    _verifyStartOtp = json['verify_start_otp'];
    _serviceId = json['service_id'];
  }
  String? _id;
  String? _userId;
  String? _driverId;
  String? _date;
  dynamic _fromDestination;
  dynamic _toDestination;
  StartPoint? _startPoint;
  dynamic _endPoint;
  List<StartPointDetails>? _startPointDetails;
  List<dynamic>? _endPointDetails;
  List<dynamic>? _stops;
  dynamic _distance;
  dynamic _totalTime;
  String? _customerFeedback;
  String? _driverFeedback;
  String? _rating;
  String? _status;
  String? _createdAt;
  String? _updatedAt;
  String? _createdBy;
  String? _updatedBy;
  dynamic _groupId;
  dynamic _detailsMatchCheck;
  dynamic _detailsMatchComment;
  num? _rideStartOtp;
  String? _verifyStartOtp;
  String? _serviceId;
  ServiceRideData copyWith({  String? id,
  String? userId,
  String? driverId,
  String? date,
  dynamic fromDestination,
  dynamic toDestination,
  StartPoint? startPoint,
  dynamic endPoint,
  List<StartPointDetails>? startPointDetails,
  List<dynamic>? endPointDetails,
  List<dynamic>? stops,
  dynamic distance,
  dynamic totalTime,
  String? customerFeedback,
  String? driverFeedback,
  String? rating,
  String? status,
  String? createdAt,
  String? updatedAt,
  String? createdBy,
  String? updatedBy,
  dynamic groupId,
  dynamic detailsMatchCheck,
  dynamic detailsMatchComment,
  num? rideStartOtp,
  String? verifyStartOtp,
  String? serviceId,
}) => ServiceRideData(  id: id ?? _id,
  userId: userId ?? _userId,
  driverId: driverId ?? _driverId,
  date: date ?? _date,
  fromDestination: fromDestination ?? _fromDestination,
  toDestination: toDestination ?? _toDestination,
  startPoint: startPoint ?? _startPoint,
  endPoint: endPoint ?? _endPoint,
  startPointDetails: startPointDetails ?? _startPointDetails,
  endPointDetails: endPointDetails ?? _endPointDetails,
  stops: stops ?? _stops,
  distance: distance ?? _distance,
  totalTime: totalTime ?? _totalTime,
  customerFeedback: customerFeedback ?? _customerFeedback,
  driverFeedback: driverFeedback ?? _driverFeedback,
  rating: rating ?? _rating,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  createdBy: createdBy ?? _createdBy,
  updatedBy: updatedBy ?? _updatedBy,
  groupId: groupId ?? _groupId,
  detailsMatchCheck: detailsMatchCheck ?? _detailsMatchCheck,
  detailsMatchComment: detailsMatchComment ?? _detailsMatchComment,
  rideStartOtp: rideStartOtp ?? _rideStartOtp,
  verifyStartOtp: verifyStartOtp ?? _verifyStartOtp,
  serviceId: serviceId ?? _serviceId,
);
  String? get id => _id;
  String? get userId => _userId;
  String? get driverId => _driverId;
  String? get date => _date;
  dynamic get fromDestination => _fromDestination;
  dynamic get toDestination => _toDestination;
  StartPoint? get startPoint => _startPoint;
  dynamic get endPoint => _endPoint;
  List<StartPointDetails>? get startPointDetails => _startPointDetails;
  List<dynamic>? get endPointDetails => _endPointDetails;
  List<dynamic>? get stops => _stops;
  dynamic get distance => _distance;
  dynamic get totalTime => _totalTime;
  String? get customerFeedback => _customerFeedback;
  String? get driverFeedback => _driverFeedback;
  String? get rating => _rating;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get createdBy => _createdBy;
  String? get updatedBy => _updatedBy;
  dynamic get groupId => _groupId;
  dynamic get detailsMatchCheck => _detailsMatchCheck;
  dynamic get detailsMatchComment => _detailsMatchComment;
  num? get rideStartOtp => _rideStartOtp;
  String? get verifyStartOtp => _verifyStartOtp;
  String? get serviceId => _serviceId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['user_id'] = _userId;
    map['driver_id'] = _driverId;
    map['date'] = _date;
    map['from_destination'] = _fromDestination;
    map['to_destination'] = _toDestination;
    if (_startPoint != null) {
      map['start_point'] = _startPoint?.toJson();
    }
    map['end_point'] = _endPoint;
    if (_startPointDetails != null) {
      map['start_point_details'] = _startPointDetails?.map((v) => v.toJson()).toList();
    }
    if (_endPointDetails != null) {
      map['end_point_details'] = _endPointDetails?.map((v) => v.toJson()).toList();
    }
    if (_stops != null) {
      map['stops'] = _stops?.map((v) => v.toJson()).toList();
    }
    map['distance'] = _distance;
    map['total_time'] = _totalTime;
    map['customer_feedback'] = _customerFeedback;
    map['driver_feedback'] = _driverFeedback;
    map['rating'] = _rating;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['created_by'] = _createdBy;
    map['updated_by'] = _updatedBy;
    map['group_id'] = _groupId;
    map['details_match_check'] = _detailsMatchCheck;
    map['details_match_comment'] = _detailsMatchComment;
    map['ride_start_otp'] = _rideStartOtp;
    map['verify_start_otp'] = _verifyStartOtp;
    map['service_id'] = _serviceId;
    return map;
  }

}

class StartPointDetails {
  StartPointDetails({
      num? distance, 
      Place? place, 
      String? placeId,}){
    _distance = distance;
    _place = place;
    _placeId = placeId;
}

  StartPointDetails.fromJson(dynamic json) {
    _distance = json['Distance'];
    _place = json['Place'] != null ? Place.fromJson(json['Place']) : null;
    _placeId = json['PlaceId'];
  }
  num? _distance;
  Place? _place;
  String? _placeId;
StartPointDetails copyWith({  num? distance,
  Place? place,
  String? placeId,
}) => StartPointDetails(  distance: distance ?? _distance,
  place: place ?? _place,
  placeId: placeId ?? _placeId,
);
  num? get distance => _distance;
  Place? get place => _place;
  String? get placeId => _placeId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Distance'] = _distance;
    if (_place != null) {
      map['Place'] = _place?.toJson();
    }
    map['PlaceId'] = _placeId;
    return map;
  }

}

class Place {
  Place({
      String? country, 
      Geometry? geometry, 
      bool? interpolated, 
      String? label, 
      String? municipality, 
      String? neighborhood, 
      String? postalCode, 
      String? region, 
      String? street, 
      String? subRegion, 
      TimeZone? timeZone,}){
    _country = country;
    _geometry = geometry;
    _interpolated = interpolated;
    _label = label;
    _municipality = municipality;
    _neighborhood = neighborhood;
    _postalCode = postalCode;
    _region = region;
    _street = street;
    _subRegion = subRegion;
    _timeZone = timeZone;
}

  Place.fromJson(dynamic json) {
    _country = json['Country'];
    _geometry = json['Geometry'] != null ? Geometry.fromJson(json['Geometry']) : null;
    _interpolated = json['Interpolated'];
    _label = json['Label'];
    _municipality = json['Municipality'];
    _neighborhood = json['Neighborhood'];
    _postalCode = json['PostalCode'];
    _region = json['Region'];
    _street = json['Street'];
    _subRegion = json['SubRegion'];
    _timeZone = json['TimeZone'] != null ? TimeZone.fromJson(json['TimeZone']) : null;
  }
  String? _country;
  Geometry? _geometry;
  bool? _interpolated;
  String? _label;
  String? _municipality;
  String? _neighborhood;
  String? _postalCode;
  String? _region;
  String? _street;
  String? _subRegion;
  TimeZone? _timeZone;
Place copyWith({  String? country,
  Geometry? geometry,
  bool? interpolated,
  String? label,
  String? municipality,
  String? neighborhood,
  String? postalCode,
  String? region,
  String? street,
  String? subRegion,
  TimeZone? timeZone,
}) => Place(  country: country ?? _country,
  geometry: geometry ?? _geometry,
  interpolated: interpolated ?? _interpolated,
  label: label ?? _label,
  municipality: municipality ?? _municipality,
  neighborhood: neighborhood ?? _neighborhood,
  postalCode: postalCode ?? _postalCode,
  region: region ?? _region,
  street: street ?? _street,
  subRegion: subRegion ?? _subRegion,
  timeZone: timeZone ?? _timeZone,
);
  String? get country => _country;
  Geometry? get geometry => _geometry;
  bool? get interpolated => _interpolated;
  String? get label => _label;
  String? get municipality => _municipality;
  String? get neighborhood => _neighborhood;
  String? get postalCode => _postalCode;
  String? get region => _region;
  String? get street => _street;
  String? get subRegion => _subRegion;
  TimeZone? get timeZone => _timeZone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Country'] = _country;
    if (_geometry != null) {
      map['Geometry'] = _geometry?.toJson();
    }
    map['Interpolated'] = _interpolated;
    map['Label'] = _label;
    map['Municipality'] = _municipality;
    map['Neighborhood'] = _neighborhood;
    map['PostalCode'] = _postalCode;
    map['Region'] = _region;
    map['Street'] = _street;
    map['SubRegion'] = _subRegion;
    if (_timeZone != null) {
      map['TimeZone'] = _timeZone?.toJson();
    }
    return map;
  }

}

class TimeZone {
  TimeZone({
      String? name, 
      num? offset,}){
    _name = name;
    _offset = offset;
}

  TimeZone.fromJson(dynamic json) {
    _name = json['Name'];
    _offset = json['Offset'];
  }
  String? _name;
  num? _offset;
TimeZone copyWith({  String? name,
  num? offset,
}) => TimeZone(  name: name ?? _name,
  offset: offset ?? _offset,
);
  String? get name => _name;
  num? get offset => _offset;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Name'] = _name;
    map['Offset'] = _offset;
    return map;
  }

}

class Geometry {
  Geometry({
      List<num>? point,}){
    _point = point;
}

  Geometry.fromJson(dynamic json) {
    _point = json['Point'] != null ? json['Point'].cast<num>() : [];
  }
  List<num>? _point;
Geometry copyWith({  List<num>? point,
}) => Geometry(  point: point ?? _point,
);
  List<num>? get point => _point;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Point'] = _point;
    return map;
  }

}

class StartPoint {
  StartPoint({
      String? time, 
      num? latitude, 
      num? longitude, 
      String? location,}){
    _time = time;
    _latitude = latitude;
    _longitude = longitude;
    _location = location;
}

  StartPoint.fromJson(dynamic json) {
    _time = json['time'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _location = json['location'];
  }
  String? _time;
  num? _latitude;
  num? _longitude;
  String? _location;
StartPoint copyWith({  String? time,
  num? latitude,
  num? longitude,
  String? location,
}) => StartPoint(  time: time ?? _time,
  latitude: latitude ?? _latitude,
  longitude: longitude ?? _longitude,
  location: location ?? _location,
);
  String? get time => _time;
  num? get latitude => _latitude;
  num? get longitude => _longitude;
  String? get location => _location;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['time'] = _time;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['location'] = _location;
    return map;
  }

}