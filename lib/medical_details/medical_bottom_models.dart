class MedicalBottomModels {
  MedicalBottomModels({
      bool? status, 
      List<MedicalBottomData>? data,}){
    _status = status;
    _data = data;
}

  MedicalBottomModels.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(MedicalBottomData.fromJson(v));
      });
    }
  }
  bool? _status;
  List<MedicalBottomData>? _data;
MedicalBottomModels copyWith({  bool? status,
  List<MedicalBottomData>? data,
}) => MedicalBottomModels(  status: status ?? _status,
  data: data ?? _data,
);
  bool? get status => _status;
  List<MedicalBottomData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class MedicalBottomData {
  MedicalBottomData({
      String? value,}){
    _value = value;
}

  MedicalBottomData.fromJson(dynamic json) {
    _value = json['value'];
  }
  String? _value;
  MedicalBottomData copyWith({  String? value,
}) => MedicalBottomData(  value: value ?? _value,
);
  String? get value => _value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['value'] = _value;
    return map;
  }

}