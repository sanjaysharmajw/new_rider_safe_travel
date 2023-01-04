import 'dart:convert';

PermanentAddress permanentAddressFromJson(String str) =>
    PermanentAddress.fromJson(json.decode(str));
String permanentAddressToJson(PermanentAddress data) =>
    json.encode(data.toJson());

class PermanentAddress {
  PermanentAddress({
    this.address,
    this.city,
    this.state,
    this.pincode,
  });

  PermanentAddress.fromJson(dynamic json) {
    address = json['address'];
    city = json['city'];
    state = json['state'];
    pincode = json['pincode'];
  }
  String? address;
  String? city;
  String? state;
  String? pincode;
  PermanentAddress copyWith({
    String? address,
    String? city,
    String? state,
    String? pincode,
  }) =>
      PermanentAddress(
        address: address ?? this.address,
        city: city ?? this.city,
        state: state ?? this.state,
        pincode: pincode ?? this.pincode,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address'] = address;
    map['city'] = city;
    map['state'] = state;
    map['pincode'] = pincode;
    return map;
  }
}
