class CargoListResponseModel {
  int? id;
  String? title;

  CargoListResponseModel({this.id, this.title});

  CargoListResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    return data;
  }
}
