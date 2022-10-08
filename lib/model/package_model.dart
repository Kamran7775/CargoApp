class PackageResponseModel {
  int? id;
  String? clientId;
  String? createdAt;
  int? status;
  int? delivery;

  PackageResponseModel(
      {this.id, this.clientId, this.createdAt, this.status, this.delivery});

  PackageResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    createdAt = json['created_at'];
    status = json['status'];
    delivery = json['delivery'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['client_id'] = clientId;
    data['created_at'] = createdAt;
    data['status'] = status;
    data['delivery'] = delivery;
    return data;
  }
}
