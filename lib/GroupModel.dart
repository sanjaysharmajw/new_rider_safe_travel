import 'dart:convert';
GroupModel groupModelFromJson(String str) => GroupModel.fromJson(json.decode(str));
String groupModelToJson(GroupModel data) => json.encode(data.toJson());
class GroupModel {
  GroupModel({
      this.status, 
      this.data,});

  GroupModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(GroupModelData.fromJson(v));
      });
    }
  }
  bool? status;
  List<GroupModelData>? data;
GroupModel copyWith({  bool? status,
  List<GroupModelData>? data,
}) => GroupModel(  status: status ?? this.status,
  data: data ?? this.data,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

GroupModelData dataFromJson(String str) => GroupModelData.fromJson(json.decode(str));
String dataToJson(GroupModelData data) => json.encode(data.toJson());
class GroupModelData {
  GroupModelData({
      this.id, 
      this.name, 
      this.address, 
      this.city, 
      this.state, 
      this.pincode, 
      this.groupType, 
      this.parentGroupId, 
      this.pickupPoint, 
      this.groupStatus,
      this.createdAt, 
      this.updatedAt, 
      this.createdBy, 
      this.updatedBy,});

  GroupModelData.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    address = json['Address'];
    city = json['city'];
    state = json['state'];
    pincode = json['pincode'];
    groupType = json['group_type'];
    parentGroupId = json['parent_group_id'];
    pickupPoint = json['pickup_point'];
    groupStatus = json['group_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
  }
  String? id;
  String? name;
  String? address;
  String? city;
  String? state;
  String? pincode;
  String? groupType;
  String? parentGroupId;
  dynamic pickupPoint;
  String? groupStatus;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;
  GroupModelData copyWith({  String? id,
  String? name,
  String? address,
  String? city,
  String? state,
  String? pincode,
  String? groupType,
  String? parentGroupId,
  dynamic pickupPoint,
  String? groupStatus,
  String? createdAt,
  String? updatedAt,
  String? createdBy,
  String? updatedBy,
}) => GroupModelData(  id: id ?? this.id,
  name: name ?? this.name,
  address: address ?? this.address,
  city: city ?? this.city,
  state: state ?? this.state,
  pincode: pincode ?? this.pincode,
  groupType: groupType ?? this.groupType,
  parentGroupId: parentGroupId ?? this.parentGroupId,
  pickupPoint: pickupPoint ?? this.pickupPoint,
    groupStatus: groupStatus ?? this.groupStatus,
  createdAt: createdAt ?? this.createdAt,
  updatedAt: updatedAt ?? this.updatedAt,
  createdBy: createdBy ?? this.createdBy,
  updatedBy: updatedBy ?? this.updatedBy,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['Address'] = address;
    map['city'] = city;
   map['state'] = state;
    map['pincode'] = pincode;
    map['group_type'] = groupType;
    map['parent_group_id'] = parentGroupId;
    map['pickup_point'] = pickupPoint;
    map['group_status'] = groupStatus;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['created_by'] = createdBy;
    map['updated_by'] = updatedBy;
    return map;
  }

}