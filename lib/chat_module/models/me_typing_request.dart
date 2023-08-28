class MeTypingRequest {
  MeTypingRequest({
      bool? isTyping,}){
    _isTyping = isTyping;
}

  MeTypingRequest.fromJson(dynamic json) {
    _isTyping = json['isTyping'];
  }
  bool? _isTyping;
MeTypingRequest copyWith({  bool? isTyping,
}) => MeTypingRequest(  isTyping: isTyping ?? _isTyping,
);
  bool? get isTyping => _isTyping;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isTyping'] = _isTyping;
    return map;
  }

}