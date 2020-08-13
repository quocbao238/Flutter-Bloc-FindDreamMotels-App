import 'dart:convert';

UserFacebookModel userFacebookModelFromJson(String str) => UserFacebookModel.fromJson(json.decode(str));

String userFacebookModelToJson(UserFacebookModel data) => json.encode(data.toJson());

class UserFacebookModel {
    UserFacebookModel({
        this.name,
        this.picture,
        this.email,
    });

    final String name;
    final Picture picture;
    final String email;

    factory UserFacebookModel.fromJson(Map<String, dynamic> json) => UserFacebookModel(
        name: json["name"] == null ? null : json["name"],
        picture: json["picture"] == null ? null : Picture.fromJson(json["picture"]),
        email: json["email"] == null ? null : json["email"],
    );

    Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "picture": picture == null ? null : picture.toJson(),
        "email": email == null ? null : email,
    };
}

class Picture {
    Picture({
        this.data,
    });

    final Data data;

    factory Picture.fromJson(Map<String, dynamic> json) => Picture(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? null : data.toJson(),
    };
}

class Data {
    Data({
        this.height,
        this.isSilhouette,
        this.url,
        this.width,
    });

    final int height;
    final bool isSilhouette;
    final String url;
    final int width;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        height: json["height"] == null ? null : json["height"],
        isSilhouette: json["is_silhouette"] == null ? null : json["is_silhouette"],
        url: json["url"] == null ? null : json["url"],
        width: json["width"] == null ? null : json["width"],
    );

    Map<String, dynamic> toJson() => {
        "height": height == null ? null : height,
        "is_silhouette": isSilhouette == null ? null : isSilhouette,
        "url": url == null ? null : url,
        "width": width == null ? null : width,
    };
}
