import 'dart:convert';

RateModel rateModelFromJson(String str) => RateModel.fromJson(json.decode(str));

String rateModelToJson(RateModel data) => json.encode(data.toJson());

class RateModel {
    RateModel({
        this.userId,
        this.userName,
        this.comment,
        this.rating,
    });

    String userId;
    String userName;
    String comment;
    double rating;

    factory RateModel.fromJson(Map<String, dynamic> json) => RateModel(
        userId: json["userId"] == null ? null : json["userId"],
        userName: json["userName"] == null ? null : json["userName"],
        comment: json["comment"] == null ? null : json["comment"],
        rating: json["rating"] == null ? null : json["rating"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "userId": userId == null ? null : userId,
        "userName": userName == null ? null : userName,
        "comment": comment == null ? null : comment,
        "rating": rating == null ? null : rating,
    };
}
