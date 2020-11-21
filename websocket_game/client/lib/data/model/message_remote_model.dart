class MessageRemoteModel {
  String nickname;
  int timestamp;
  String content;

  MessageRemoteModel({this.nickname, this.timestamp, this.content});

  MessageRemoteModel.fromJson(Map<String, dynamic> json) {
    nickname = json['nickname'];
    timestamp = json['timestamp'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['nickname'] = this.nickname;
    data['timestamp'] = this.timestamp;
    data['content'] = this.content;
    return data;
  }
}
