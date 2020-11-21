class PlayerRemoteModel {
  int playId;
  String nickname;
  int score;

  PlayerRemoteModel({this.playId, this.nickname, this.score});

  PlayerRemoteModel.fromJson(Map<String, dynamic> json) {
    playId = json['playId'];
    nickname = json['nickname'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['playId'] = this.playId;
    data['nickname'] = this.nickname;
    data['score'] = this.score;
    return data;
  }

  @override
  String toString() =>
      'PlayerRemoteModel(playId: $playId, nickname: $nickname, score: $score)';
}
