// To parse this JSON data, do
//
//     final countNotificationModel = countNotificationModelFromJson(jsonString);

import 'dart:convert';

CountNotificationModel countNotificationModelFromJson(String str) => CountNotificationModel.fromJson(json.decode(str));

String countNotificationModelToJson(CountNotificationModel data) => json.encode(data.toJson());

class CountNotificationModel {
  CountNotificationModel({
    required this.status,
    required this.data,
    required this.count,
  });

  bool status;
  List<Datum> data;
  Count count;

  factory CountNotificationModel.fromJson(Map<String, dynamic> json) => CountNotificationModel(
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    count: Count.fromJson(json["count"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "count": count.toJson(),
  };
}

class Count {
  Count({
    required this.totalRides,
    required this.trackingmembers,
    required this.familymemberrides,
  });

  int totalRides;
  int trackingmembers;
  int familymemberrides;

  factory Count.fromJson(Map<String, dynamic> json) => Count(
    totalRides: json["total_rides"],
    trackingmembers: json["trackingmembers"],
    familymemberrides: json["familymemberrides"],
  );

  Map<String, dynamic> toJson() => {
    "total_rides": totalRides,
    "trackingmembers": trackingmembers,
    "familymemberrides": familymemberrides,
  };
}

class Datum {
  Datum({
    required this.title,
    required this.description,
    required this.type,
    required this.status,
    required this.id,
    required this.dateor,
    required this.date,
  });

  Title title;
  String description;
  Type type;
  int status;
  String id;
  DateTime dateor;
  String date;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    title: titleValues.map[json["title"]]!,
    description: json["description"],
    type: typeValues.map[json["type"]]!,
    status: json["status"],
    id: json["_id"],
    dateor: DateTime.parse(json["dateor"]),
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "title": titleValues.reverse[title],
    "description": description,
    "type": typeValues.reverse[type],
    "status": status,
    "_id": id,
    "dateor": dateor.toIso8601String(),
    "date": date,
  };
}

enum Title { TRAVEL_SAFE_ALERT, TEST_NOTIFICATION_INDIVIDUAL_USER_1, TEST_NOTIFICATION_INDIVIDUAL_USER, ADMIN_TEST_5, ADMIN_NOTIFICATION_TEST, ADMIN_NOTIFICATION_1, ADMIN_NOTIFICATION }

final titleValues = EnumValues({
  "Admin Notification": Title.ADMIN_NOTIFICATION,
  "Admin Notification 1": Title.ADMIN_NOTIFICATION_1,
  "Admin notification test": Title.ADMIN_NOTIFICATION_TEST,
  "Admin test 5": Title.ADMIN_TEST_5,
  "test notification individual user": Title.TEST_NOTIFICATION_INDIVIDUAL_USER,
  "test notification individual user 1": Title.TEST_NOTIFICATION_INDIVIDUAL_USER_1,
  "Travel Safe Alert": Title.TRAVEL_SAFE_ALERT
});

enum Type { RIDE_SOS_ALERT, TEST, INDIVIDUAL_USER, ADMIN_TEST, ADMIN_NOTIFICATION_TEST, ADMIN_NOTIFICATION }

final typeValues = EnumValues({
  "Admin Notification": Type.ADMIN_NOTIFICATION,
  "Admin notification test": Type.ADMIN_NOTIFICATION_TEST,
  "Admin test": Type.ADMIN_TEST,
  "individual user": Type.INDIVIDUAL_USER,
  "ride sos alert": Type.RIDE_SOS_ALERT,
  "test": Type.TEST
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
