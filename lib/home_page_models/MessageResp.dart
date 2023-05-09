import 'Results.dart';

class MessageResp {
  MessageResp({
      required this.results,
      required this.canonicalRegistrationTokenCount,
      required this.failureCount,
      required this.successCount,
      required this.multicastId,});

  MessageResp.fromJson(dynamic json) {
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(Results.fromJson(v));
      });
    }
    canonicalRegistrationTokenCount = json['canonicalRegistrationTokenCount'];
    failureCount = json['failureCount'];
    successCount = json['successCount'];
    multicastId = json['multicastId'];
  }
  List<Results>? results;
  int? canonicalRegistrationTokenCount;
  int? failureCount;
  int? successCount;
  int? multicastId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (results != null) {
      map['results'] = results?.map((v) => v.toJson()).toList();
    }
    map['canonicalRegistrationTokenCount'] = canonicalRegistrationTokenCount;
    map['failureCount'] = failureCount;
    map['successCount'] = successCount;
    map['multicastId'] = multicastId;
    return map;
  }

}