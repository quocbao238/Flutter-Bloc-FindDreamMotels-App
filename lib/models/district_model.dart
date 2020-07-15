class DistrictModel {
  String districtId;
  String name;

  DistrictModel({this.districtId, this.name});

  DistrictModel.fromJson(Map<String, dynamic> json) {
    districtId = json['districtId'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['districtId'] = this.districtId;
    data['name'] = this.name;
    return data;
  }
}