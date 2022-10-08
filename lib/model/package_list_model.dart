class PackageModel {
  int? id;
  bool? imagesFilled;
  int? clientId;
  String? createdAt;
  int? status;
  int? delivery;

  PackageModel(
      {this.id,
      this.imagesFilled,
      this.clientId,
      this.createdAt,
      this.status,
      this.delivery});

  PackageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imagesFilled = json['images_filled'];
    clientId = 1;
    createdAt = json['created_at'];
    status = json['status'];
    delivery = json['delivery'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['images_filled'] = imagesFilled;
    data['client_id'] = clientId;
    data['created_at'] = createdAt;
    data['status'] = status;
    data['delivery'] = delivery;
    return data;
  }
}
