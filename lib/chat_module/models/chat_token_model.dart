/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiPFJpZGVyIE5hbWU-Iiwicm9vbU5hbWUiOiIzYWU5NmQ5Zi0xM2NjLTQ2ZGYtOTY4MS01MjE3ODk5M2QyZGMiLCJyb2xlIjoiUmlkZXIiLCJ1c2VySWQiOiI8dXNlciBpZCBvZiB0aGUgcmlkZXIgL2RyaXZlcj4iLCJpYXQiOjE2OTA3ODgyOTR9.5Q_WP8sALH3rMslexhbNLqtJr6q6b8SuxaQB1Q1mSR8"

class ChatTokenModel {
  ChatTokenModel({
      String? token,}){
    _token = token;
}

  ChatTokenModel.fromJson(dynamic json) {
    _token = json['token'];
  }
  String? _token;
ChatTokenModel copyWith({  String? token,
}) => ChatTokenModel(  token: token ?? _token,
);
  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = _token;
    return map;
  }

}