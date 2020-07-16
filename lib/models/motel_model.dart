// To parse this JSON data, do
//
//     final motelModel = motelModelFromJson(jsonString);

import 'dart:convert';

MotelModel motelModelFromJson(String str) => MotelModel.fromJson(json.decode(str));

String motelModelToJson(MotelModel data) => json.encode(data.toJson());

class MotelModel {
    MotelModel({
        this.motelId,
        this.userIdCreate,
        this.districtId,
        this.name,
        this.email,
        this.timeUpdate,
        this.address,
        this.rating,
        this.price,
        this.phoneNumber,
        this.amenities,
        this.description,
        this.location,
    });

    int motelId;
    String userIdCreate;
    int districtId;
    String name;
    String email;
    double timeUpdate;
    String address;
    double rating;
    String price;
    String phoneNumber;
    Amenities amenities;
    String description;
    Location location;

    factory MotelModel.fromJson(Map<String, dynamic> json) => MotelModel(
        motelId: json["motelId"] == null ? null : json["motelId"],
        userIdCreate: json["userIdCreate"] == null ? null : json["userIdCreate"],
        districtId: json["districtId"] == null ? null : json["districtId"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        timeUpdate: json["timeUpdate"] == null ? null : json["timeUpdate"].toDouble(),
        address: json["address"] == null ? null : json["address"],
        rating: json["rating"] == null ? null : json["rating"].toDouble(),
        price: json["price"] == null ? null : json["price"],
        phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
        amenities: json["amenities"] == null ? null : Amenities.fromJson(json["amenities"]),
        description: json["description"] == null ? null : json["description"],
        location: json["location"] == null ? null : Location.fromJson(json["location"]),
    );

    Map<String, dynamic> toJson() => {
        "motelId": motelId == null ? null : motelId,
        "userIdCreate": userIdCreate == null ? null : userIdCreate,
        "districtId": districtId == null ? null : districtId,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "timeUpdate": timeUpdate == null ? null : timeUpdate,
        "address": address == null ? null : address,
        "rating": rating == null ? null : rating,
        "price": price == null ? null : price,
        "phoneNumber": phoneNumber == null ? null : phoneNumber,
        "amenities": amenities == null ? null : amenities.toJson(),
        "description": description == null ? null : description,
        "location": location == null ? null : location.toJson(),
    };
}

class Amenities {
    Amenities({
        this.freeWifi,
        this.bed,
        this.airCondition,
        this.bathRoom,
        this.televison,
    });

    bool freeWifi;
    bool bed;
    bool airCondition;
    bool bathRoom;
    bool televison;

    factory Amenities.fromJson(Map<String, dynamic> json) => Amenities(
        freeWifi: json["freeWifi"] == null ? null : json["freeWifi"],
        bed: json["bed"] == null ? null : json["bed"],
        airCondition: json["airCondition"] == null ? null : json["airCondition"],
        bathRoom: json["bathRoom"] == null ? null : json["bathRoom"],
        televison: json["televison"] == null ? null : json["televison"],
    );

    Map<String, dynamic> toJson() => {
        "freeWifi": freeWifi == null ? null : freeWifi,
        "bed": bed == null ? null : bed,
        "airCondition": airCondition == null ? null : airCondition,
        "bathRoom": bathRoom == null ? null : bathRoom,
        "televison": televison == null ? null : televison,
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
