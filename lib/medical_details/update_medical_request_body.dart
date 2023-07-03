class UpdateMedicalRequestBody {
  UpdateMedicalRequestBody({
      String? userId, 
      String? medicalCondition, 
      String? medicalNotes, 
      String? allergiesAndReactions, 
      String? medications, 
      String? organDonar, 
      String? weight, 
      String? height, 
      String? primaryLanguage,
    String? dob,

  }){
    _userId = userId;
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

  UpdateMedicalRequestBody.fromJson(dynamic json) {
    _userId = json['user_id'];
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
  String? _userId;
  String? _medicalCondition;
  String? _medicalNotes;
  String? _allergiesAndReactions;
  String? _medications;
  String? _organDonar;
  String? _weight;
  String? _height;
  String? _primaryLanguage;
  String? _dob;
UpdateMedicalRequestBody copyWith({  String? userId,
  String? medicalCondition,
  String? medicalNotes,
  String? allergiesAndReactions,
  String? medications,
  String? organDonar,
  String? weight,
  String? height,
  String? primaryLanguage,
  String? dob,
}) => UpdateMedicalRequestBody(  userId: userId ?? _userId,
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
  String? get userId => _userId;
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
    map['user_id'] = _userId;
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