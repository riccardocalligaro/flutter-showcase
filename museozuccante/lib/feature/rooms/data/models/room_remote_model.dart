class RoomRemoteModel {
  String title;
  int floor;
  int number;
  double pixelX;
  double pixelY;
  String id;

  RoomRemoteModel(
      {this.title, this.floor, this.number, this.pixelX, this.pixelY, this.id});

  RoomRemoteModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    floor = json['floor'];
    number = json['number'];
    pixelX = double.parse(json['pixel_x']);
    pixelY = double.parse(json['pixel_y']);
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['floor'] = floor;
    data['number'] = number;
    data['pixel_x'] = pixelX;
    data['pixel_y'] = pixelY;
    data['id'] = id;
    return data;
  }
}
