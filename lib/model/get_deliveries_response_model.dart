class GetDeliveriesResponseModel {
  int? id;
  List<Images>? images;
  Courier? courier;
  CargoCompany? cargoCompany;
  bool? imagesField;
  int? packageCount;
  String? createdAt;
  int? status;

  GetDeliveriesResponseModel({
    this.id,
    this.images,
    this.courier,
    this.cargoCompany,
    this.imagesField,
    this.packageCount,
    this.createdAt,
    this.status,
  });

  GetDeliveriesResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    courier =
        json['courier'] != null ? Courier.fromJson(json['courier']) : null;
    cargoCompany = json['cargo_company'] != null
        ? CargoCompany.fromJson(json['cargo_company'])
        : null;
    imagesField = json['images_field'];
    packageCount = json['package_count'];
    createdAt = json['created_at'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    if (courier != null) {
      data['courier'] = courier!.toJson();
    }
    if (cargoCompany != null) {
      data['cargo_company'] = cargoCompany!.toJson();
    }
    data['images_field'] = imagesField;
    data['package_count'] = packageCount;
    data['created_at'] = createdAt;
    data['status'] = status;
    return data;
  }
}

class Images {
  int? id;
  String? image;
  String? imageAddedAt;

  Images({this.id, this.image, this.imageAddedAt});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    imageAddedAt = json['image_added_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['image'] = image;
    data['image_added_at'] = imageAddedAt;
    return data;
  }
}

class Courier {
  int? id;
  String? firstName;
  String? lastName;
  String? phoneNumber;

  Courier({this.id, this.firstName, this.lastName, this.phoneNumber});

  Courier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phoneNumber = json['phone_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['phone_number'] = phoneNumber;
    return data;
  }
}

class CargoCompany {
  int? id;
  String? title;

  CargoCompany({this.id, this.title});

  CargoCompany.fromJson(Map<String, dynamic> json) {
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
