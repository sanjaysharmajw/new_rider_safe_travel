class Results {
  Results({
      required this.messageId,});

  Results.fromJson(dynamic json) {
    messageId = json['messageId'];
  }
  String? messageId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['messageId'] = messageId;
    return map;
  }

}