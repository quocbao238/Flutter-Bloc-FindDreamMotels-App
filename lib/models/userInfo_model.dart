class UserInfoModel {
  String name;
  String phone;
  String email;
  String birthday;
  String photoUrl;
  String address;

  UserInfoModel(
      {this.name,
      this.phone,
      this.email,
      this.birthday,
      this.photoUrl,
      this.address});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    birthday = json['birthday'];
    photoUrl = json['photoUrl'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['birthday'] = this.birthday;
    data['photoUrl'] = this.photoUrl;
    data['address'] = this.address;
    return data;
  }
}