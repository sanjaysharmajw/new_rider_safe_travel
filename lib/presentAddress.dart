import 'dart:convert';

PresentAddress presentAddressFromJson(String str) =>
    PresentAddress.fromJson(json.decode(str));
String presentAddressToJson(PresentAddress data) => json.encode(data.toJson());

class PresentAddress {
  PresentAddress({
    this.address,
    this.city,
    this.state,
    this.pincode,
  });

  PresentAddress.fromJson(dynamic json) {
    address = json['address'];
    city = json['city'];
    state = json['state'];
    pincode = json['pincode'];
  }
  String? address;
  String? city;
  String? state;
  String? pincode;
  PresentAddress copyWith({
    String? address,
    String? city,
    String? state,
    String? pincode,
  }) =>
      PresentAddress(
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
