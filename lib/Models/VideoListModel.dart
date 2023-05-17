class VideoListModels {
  VideoListModels({
    bool? status,
    List<VideoData>? data,}){
    _status = status;
    _data = data;
  }

  VideoListModels.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(VideoData.fromJson(v));
      });
    }
  }
  bool? _status;
  List<VideoData>? _data;
  VideoListModels copyWith({  bool? status,
    List<VideoData>? data,
  }) => VideoListModels(  status: status ?? _status,
    data: data ?? _data,
  );
  bool? get status => _status;
  List<VideoData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class VideoData {
  VideoData({
    String? id,
    String? name,
    String? description,
    String? createdAt,
    String? updatedAt,
    String? createdBy,
    String? updatedBy,
    String? status,
    String? userType,
    String? videoLink,
    String? videoType,
    String? thumbnelImage,}){
    _id = id;
    _name = name;
    _description = description;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _createdBy = createdBy;
    _updatedBy = updatedBy;
    _status = status;
    _userType = userType;
    _videoLink = videoLink;
    _videoType = videoType;
    _thumbnelImage = thumbnelImage;
  }

  VideoData.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _description = json['description'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _createdBy = json['created_by'];
    _updatedBy = json['updated_by'];
    _status = json['status'];
    _userType = json['user_type'];
    _videoLink = json['video_link'];
    _videoType = json['video_type'];
    _thumbnelImage = json['thumbnel_image'];
  }
  String? _id;
  String? _name;
  String? _description;
  String? _createdAt;
  String? _updatedAt;
  String? _createdBy;
  String? _updatedBy;
  String? _status;
  String? _userType;
  String? _videoLink;
  String? _videoType;
  String? _thumbnelImage;
  VideoData copyWith({  String? id,
    String? name,
    String? description,
    String? createdAt,
    String? updatedAt,
    String? createdBy,
    String? updatedBy,
    String? status,
    String? userType,
    String? videoLink,
    String? videoType,
    String? thumbnelImage,
  }) => VideoData(  id: id ?? _id,
    name: name ?? _name,
    description: description ?? _description,
    createdAt: createdAt ?? _createdAt,
    updatedAt: updatedAt ?? _updatedAt,
    createdBy: createdBy ?? _createdBy,
    updatedBy: updatedBy ?? _updatedBy,
    status: status ?? _status,
    userType: userType ?? _userType,
    videoLink: videoLink ?? _videoLink,
    videoType: videoType ?? _videoType,
    thumbnelImage: thumbnelImage ?? _thumbnelImage,
  );
  String? get id => _id;
  String? get name => _name;
  String? get description => _description;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get createdBy => _createdBy;
  String? get updatedBy => _updatedBy;
  String? get status => _status;
  String? get userType => _userType;
  String? get videoLink => _videoLink;
  String? get videoType => _videoType;
  String? get thumbnelImage => _thumbnelImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['description'] = _description;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['created_by'] = _createdBy;
    map['updated_by'] = _updatedBy;
    map['status'] = _status;
    map['user_type'] = _userType;
    map['video_link'] = _videoLink;
    map['video_type'] = _videoType;
    map['thumbnel_image'] = _thumbnelImage;
    return map;
  }

}