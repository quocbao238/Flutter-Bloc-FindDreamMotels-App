// To parse this JSON data, do
//
//     final motelModel = motelModelFromJson(jsonString);

import 'dart:convert';

MotelModel motelModelFromJson(String str) => MotelModel.fromJson(json.decode(str));

String motelModelToJson(MotelModel data) => json.encode(data.toJson());

class MotelModel {
    MotelModel({
        this.userIdCreate,
        // this.oneSignalId,
        this.districtId,
        this.title,
        this.name,
        this.documentId,
        this.email,
        this.timeUpdate,
        this.address,
        this.rating,
        this.price,
        this.phoneNumber,
        this.imageMotel,
        this.amenities,
        this.description,
        this.location,
    });

    String userIdCreate;
    int districtId;
    // String oneSignalId;
    String title;
    String name;
    String documentId;
    String email;
    double timeUpdate;
    String address;
    double rating;
    String price;
    String phoneNumber;
    List<ImageMotel> imageMotel;
    List<Amenity> amenities;
    String description;
    Location location;

    factory MotelModel.fromJson(Map<String, dynamic> json) => MotelModel(
        userIdCreate: json["userIdCreate"] == null ? null : json["userIdCreate"],
        districtId: json["districtId"] == null ? null : json["districtId"],
        title: json["title"] == null ? null : json["title"],
        name: json["name"] == null ? null : json["name"],
        documentId: json["documentId"] == null ? null : json["documentId"],
        // oneSignalId: json["oneSignalId"] == null ? null : json["oneSignalId"],
        email: json["email"] == null ? null : json["email"],
        timeUpdate: json["timeUpdate"] == null ? null : json["timeUpdate"].toDouble(),
        address: json["address"] == null ? null : json["address"],
        rating: json["rating"] == null ? null : json["rating"].toDouble(),
        price: json["price"] == null ? null : json["price"],
        phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
        imageMotel: json["imageMotel"] == null ? null : List<ImageMotel>.from(json["imageMotel"].map((x) => ImageMotel.fromJson(x))),
        amenities: json["amenities"] == null ? null : List<Amenity>.from(json["amenities"].map((x) => Amenity.fromJson(x))),
        description: json["description"] == null ? null : json["description"],
        location: json["location"] == null ? null : Location.fromJson(json["location"]),
    );

    Map<String, dynamic> toJson() => {
        "userIdCreate": userIdCreate == null ? null : userIdCreate,
        "districtId": districtId == null ? null : districtId,
        "title": title == null ? null : title,
        "name": name == null ? null : name,
        "documentId": documentId == null ? null : documentId,
        "email": email == null ? null : email,
        // "oneSignalId": oneSignalId == null ? null : oneSignalId,
        "timeUpdate": timeUpdate == null ? null : timeUpdate,
        "address": address == null ? null : address,
        "rating": rating == null ? null : rating,
        "price": price == null ? null : price,
        "phoneNumber": phoneNumber == null ? null : phoneNumber,
        "imageMotel": imageMotel == null ? null : List<dynamic>.from(imageMotel.map((x) => x.toJson())),
        "amenities": amenities == null ? null : List<dynamic>.from(amenities.map((x) => x.toJson())),
        "description": description == null ? null : description,
        "location": location == null ? null : location.toJson(),
    };
}

class Amenity {
    Amenity({
        this.name,
        this.isHave,
    });

    String name;
    bool isHave;

    factory Amenity.fromJson(Map<String, dynamic> json) => Amenity(
        name: json["name"] == null ? null : json["name"],
        isHave: json["isHave"] == null ? null : json["isHave"],
    );

    Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "isHave": isHave == null ? null : isHave,
    };
}

class ImageMotel {
    ImageMotel({
        this.imageUrl,
        this.name,
    });

    String imageUrl;
    String name;

    factory ImageMotel.fromJson(Map<String, dynamic> json) => ImageMotel(
        imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
        name: json["name"] == null ? null : json["name"],
    );

    Map<String, dynamic> toJson() => {
        "imageUrl": imageUrl == null ? null : imageUrl,
        "name": name == null ? null : name,
    };
}

class Location {
    Location({
        this.lat,
        this.lng,
    });

    double lat;
    double lng;

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"] == null ? null : json["lat"].toDouble(),
        lng: json["lng"] == null ? null : json["lng"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "lat": lat == null ? null : lat,
        "lng": lng == null ? null : lng,
    };
}
