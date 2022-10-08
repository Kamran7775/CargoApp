class DeliveryCreateRequestModel {
  List<String>? existingImages;
  List<String>? newImages;
  int? packageCount;
  int? status;
  int? cargoCompany;
  int? courier;

  DeliveryCreateRequestModel(
      {this.existingImages,
      this.newImages,
      this.packageCount,
      this.status,
      this.cargoCompany,
      this.courier});

  DeliveryCreateRequestModel.fromJson(Map<String, dynamic> json) {
    existingImages = json['existing_images'].cast<String>();
    newImages = json['new_images'].cast<String>();
    packageCount = json['package_count'];
    status = json['status'];
    cargoCompany = json['cargo_company'];
    courier = json['courier'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['existing_images'] = existingImages;
    data['new_images'] = newImages;
    data['package_count'] = packageCount;
    data['status'] = status;
    data['cargo_company'] = cargoCompany;
    data['courier'] = courier;
    return data;
  }
}
