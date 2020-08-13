import 'dart:convert';

RateModel rateModelFromJson(String str) => RateModel.fromJson(json.decode(str));

String rateModelToJson(RateModel data) => json.encode(data.toJson());

class RateModel {
    RateModel({
        this.userId,
        this.userName,
        this.comment,
        this.rating,
        this.avatar,
    });

    String userId;
    String userName;
    String comment;
    String avatar;
    double rating;

    factory RateModel.fromJson(Map<String, dynamic> json) => RateModel(
        userId: json["userId"] == null ? null : json["userId"],
        userName: json["userName"] == null ? null : json["userName"],
        comment: json["comment"] == null ? null : json["comment"],
        avatar: json["avatar"] == null ? null : json["avatar"],
        rating: json["rating"] == null ? null : json["rating"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "userId": userId == null ? null : userId,
        "userName": userName == null ? null : userName,
        "comment": comment == null ? null : comment,
        "avatar": comment == null ? null : avatar,
        "rating": rating == null ? null : rating,
    };
}
