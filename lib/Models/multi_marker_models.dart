class MultiMarkerModels {
  MultiMarkerModels({
      bool? status, 
      List<MarkerData>? data,}){
    _status = status;
    _data = data;
}

  MultiMarkerModels.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(MarkerData.fromJson(v));
      });
    }
  }
  bool? _status;
  List<MarkerData>? _data;
MultiMarkerModels copyWith({  bool? status,
  List<MarkerData>? data,
}) => MultiMarkerModels(  status: status ?? _status,
  data: data ?? _data,
);
  bool? get status => _status;
  List<MarkerData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class MarkerData {
  Data({
      String? stopName, 
      Locationdetails? locationdetails,}){
    _stopName = stopName;
    _locationdetails = locationdetails;
}

  MarkerData.fromJson(dynamic json) {
    _stopName = json['stop_name'];
    _locationdetails = json['locationdetails'] != null ? Locationdetails.fromJson(json['locationdetails']) : null;
  }
  String? _stopName;
  Locationdetails? _locationdetails;
  MarkerData copyWith({  String? stopName,
  Locationdetails? locationdetails,
}) => Data(  stopName: stopName ?? _stopName,
  locationdetails: locationdetails ?? _locationdetails,
);
  String? get stopName => _stopName;
  Locationdetails? get locationdetails => _locationdetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['stop_name'] = _stopName;
    if (_locationdetails != null) {
      map['locationdetails'] = _locationdetails?.toJson();
    }
    return map;
  }

}

class Locationdetails {
  Locationdetails({
      num? lat, 
      num? lng, 
      String? label, 
      String? municipality, 
      String? neighborhood, 
      String? postalCode, 
      String? region, 
      String? subRegion,}){
    _lat = lat;
    _lng = lng;
    _label = label;
    _municipality = municipality;
    _neighborhood = neighborhood;
    _postalCode = postalCode;
    _region = region;
    _subRegion = subRegion;
}

  Locationdetails.fromJson(dynamic json) {
    _lat = json['lat'];
    _lng = json['lng'];
    _label = json['Label'];
    _municipality = json['Municipality'];
    _neighborhood = json['Neighborhood'];
    _postalCode = json['PostalCode'];
    _region = json['Region'];
    _subRegion = json['SubRegion'];
  }
  num? _lat;
  num? _lng;
  String? _label;
  String? _municipality;
  String? _neighborhood;
  String? _postalCode;
  String? _region;
  String? _subRegion;
Locationdetails copyWith({  num? lat,
  num? lng,
  String? label,
  String? municipality,
  String? neighborhood,
  String? postalCode,
  String? region,
  String? subRegion,
}) => Locationdetails(  lat: lat ?? _lat,
  lng: lng ?? _lng,
  label: label ?? _label,
  municipality: municipality ?? _municipality,
  neighborhood: neighborhood ?? _neighborhood,
  postalCode: postalCode ?? _postalCode,
  region: region ?? _region,
  subRegion: subRegion ?? _subRegion,
);
  num? get lat => _lat;
  num? get lng => _lng;
  String? get label => _label;
  String? get municipality => _municipality;
  String? get neighborhood => _neighborhood;
  String? get postalCode => _postalCode;
  String? get region => _region;
  String? get subRegion => _subRegion;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = _lat;
    map['lng'] = _lng;
    map['Label'] = _label;
    map['Municipality'] = _municipality;
    map['Neighborhood'] = _neighborhood;
    map['PostalCode'] = _postalCode;
    map['Region'] = _region;
    map['SubRegion'] = _subRegion;
    return map;
  }

}