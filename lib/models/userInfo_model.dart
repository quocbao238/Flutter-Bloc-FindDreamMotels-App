/*
  Role 0 -> user 
  Role 1    -> leaser
  Role 2    -> admin
 */

class UserInfoModel {
  String name;
  String phone;
  String email;
  String birthday;
  String photoUrl;
  String address;
  String role;

  UserInfoModel(
      {this.name,
      this.role,
      this.phone,
      this.email,
      this.birthday,
      this.photoUrl,
      this.address});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    role = json['role'];
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
    data['role'] = this.role;
    data['birthday'] = this.birthday;
    data['photoUrl'] = this.photoUrl;
    data['address'] = this.address;
    return data;
  }
}
