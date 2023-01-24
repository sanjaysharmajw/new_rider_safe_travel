import 'dart:convert';

Result resultFromJson(String str) => Result.fromJson(json.decode(str));
String resultToJson(Result data) => json.encode(data.toJson());
class Result {
  Result({
    this.placeId,
    this.text,});

  Result.fromJson(dynamic json) {
    placeId = json['PlaceId'];
    text = json['Text'];
  }
  String? placeId;
  String? text;
  Result copyWith({  String? placeId,
    String? text,
  }) => Result(  placeId: placeId ?? this.placeId,
    text: text ?? this.text,
  );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['PlaceId'] = placeId;
    map['Text'] = text;
    return map;
  }

}