class Count {
  Count({
      required this.totalRides,
      required this.trackingmembers,
      required this.familymemberrides});

  Count.fromJson(dynamic json) {
    totalRides = json['total_rides'];
    trackingmembers = json['trackingmembers'];
    familymemberrides = json['familymemberrides'];
  }
  int? totalRides;
  int? trackingmembers;
  int? familymemberrides;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total_rides'] = totalRides;
    map['trackingmembers'] = trackingmembers;
    map['familymemberrides'] = familymemberrides;
    return map;
  }

}