class CoPassangerModels {
  CoPassangerModels({
    bool? status,
    List<Data>? data,
  }) {
    _status = status;
    _data = data;
  }

  CoPassangerModels.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _status;
  List<Data>? _data;
  CoPassangerModels copyWith({
    bool? status,
    List<Data>? data,
  }) =>
      CoPassangerModels(
        status: status ?? _status,
        data: data ?? _data,
      );
  bool? get status => _status;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Data {
  Data({
    String? id,
    List<Copassenger>? copassenger,
  }) {
    _id = id;
    _copassenger = copassenger;
  }

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    if (json['copassenger'] != null) {
      _copassenger = [];
      json['copassenger'].forEach((v) {
        _copassenger?.add(Copassenger.fromJson(v));
      });
    }
  }
  String? _id;
  List<Copassenger>? _copassenger;
  Data copyWith({
    String? id,
    List<Copassenger>? copassenger,
  }) =>
      Data(
        id: id ?? _id,
        copassenger: copassenger ?? _copassenger,
      );
  String? get id => _id;
  List<Copassenger>? get copassenger => _copassenger;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    if (_copassenger != null) {
      map['copassenger'] = _copassenger?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Copassenger {
  Copassenger({
    String? name,
    int? age,
    String? gender,
    String? bloodgroup,
    String? userId,
  }) {
    _name = name;
    _age = age;
    _gender = gender;
    _bloodgroup = bloodgroup;
    _userId = userId;
  }

  Copassenger.fromJson(dynamic json) {
    _name = json['name'];
    _age = json['age'];
    _gender = json['gender'];
    _bloodgroup = json['bloodgroup'];
    _userId = json['user_id'];
  }
  String? _name;
  int? _age;
  String? _gender;
  String? _bloodgroup;
  String? _userId;
  Copassenger copyWith({
    String? name,
    int? age,
    String? gender,
    String? bloodgroup,
    String? userId,
  }) =>
      Copassenger(
        name: name ?? _name,
        age: age ?? _age,
        gender: gender ?? _gender,
        bloodgroup: bloodgroup ?? _bloodgroup,
        userId: userId ?? _userId,
      );
  String? get name => _name;
  int? get age => _age;
  String? get gender => _gender;
  String? get bloodgroup => _bloodgroup;
  String? get userId => _userId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['age'] = _age;
    map['gender'] = _gender;
    map['bloodgroup'] = _bloodgroup;
    map['user_id'] = _userId;
    return map;
  }
}
