class MedicalDetailsModel {
  MedicalDetailsModel({
      bool? status, 
      List<MedicalData>? data,}){
    _status = status;
    _data = data;
}

  MedicalDetailsModel.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(MedicalData.fromJson(v));
      });
    }
  }
  bool? _status;
  List<MedicalData>? _data;
MedicalDetailsModel copyWith({  bool? status,
  List<MedicalData>? data,
}) => MedicalDetailsModel(  status: status ?? _status,
  data: data ?? _data,
);
  bool? get status => _status;
  List<MedicalData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class MedicalData {
  MedicalData({
      String? id, 
      String? medicalCondition, 
      String? medicalNotes, 
      String? allergiesAndReactions, 
      String? medications, 
      String? organDonar, 
      String? weight, 
      String? height, 
      String? primaryLanguage, 
      String? dob,}){
    _id = id;
    _medicalCondition = medicalCondition;
    _medicalNotes = medicalNotes;
    _allergiesAndReactions = allergiesAndReactions;
    _medications = medications;
    _organDonar = organDonar;
    _weight = weight;
    _height = height;
    _primaryLanguage = primaryLanguage;
    _dob = dob;
}

  MedicalData.fromJson(dynamic json) {
    _id = json['_id'];
    _medicalCondition = json['medical_condition'];
    _medicalNotes = json['medical_notes'];
    _allergiesAndReactions = json['allergies_and_reactions'];
    _medications = json['medications'];
    _organDonar = json['organ_donar'];
    _weight = json['weight'];
    _height = json['height'];
    _primaryLanguage = json['primary_language'];
    _dob = json['dob'];
  }
  String? _id;
  String? _medicalCondition;
  String? _medicalNotes;
  String? _allergiesAndReactions;
  String? _medications;
  String? _organDonar;
  String? _weight;
  String? _height;
  String? _primaryLanguage;
  String? _dob;
  MedicalData copyWith({  String? id,
  String? medicalCondition,
  String? medicalNotes,
  String? allergiesAndReactions,
  String? medications,
  String? organDonar,
  String? weight,
  String? height,
  String? primaryLanguage,
  String? dob,
}) => MedicalData(  id: id ?? _id,
  medicalCondition: medicalCondition ?? _medicalCondition,
  medicalNotes: medicalNotes ?? _medicalNotes,
  allergiesAndReactions: allergiesAndReactions ?? _allergiesAndReactions,
  medications: medications ?? _medications,
  organDonar: organDonar ?? _organDonar,
  weight: weight ?? _weight,
  height: height ?? _height,
  primaryLanguage: primaryLanguage ?? _primaryLanguage,
  dob: dob ?? _dob,
);
  String? get id => _id;
  String? get medicalCondition => _medicalCondition;
  String? get medicalNotes => _medicalNotes;
  String? get allergiesAndReactions => _allergiesAndReactions;
  String? get medications => _medications;
  String? get organDonar => _organDonar;
  String? get weight => _weight;
  String? get height => _height;
  String? get primaryLanguage => _primaryLanguage;
  String? get dob => _dob;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['medical_condition'] = _medicalCondition;
    map['medical_notes'] = _medicalNotes;
    map['allergies_and_reactions'] = _allergiesAndReactions;
    map['medications'] = _medications;
    map['organ_donar'] = _organDonar;
    map['weight'] = _weight;
    map['height'] = _height;
    map['primary_language'] = _primaryLanguage;
    map['dob'] = _dob;
    return map;
  }

}