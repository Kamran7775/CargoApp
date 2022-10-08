class CouriersListResponseModel {
  int? id;
  String? firstName;
  String? lastName;
  String? phoneNumber;

  CouriersListResponseModel(
      {this.id, this.firstName, this.lastName, this.phoneNumber});

  CouriersListResponseModel.fromJson(Map<String, dynamic> json) {
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
