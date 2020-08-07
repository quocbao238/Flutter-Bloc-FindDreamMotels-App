// To parse this JSON data, do
//
//     final historyModel = historyModelFromJson(jsonString);

import 'dart:convert';

import 'package:findingmotels/models/motel_model.dart';

HistoryModel historyModelFromJson(String str) => HistoryModel.fromJson(json.decode(str));

String historyModelToJson(HistoryModel data) => json.encode(data.toJson());

class HistoryModel {
    HistoryModel({
        this.type,
        this.userBookingName,
        this.timeBooking,
        this.userBookingId,
        this.motelBooking,
    });

    final int type;
    final String userBookingName;
    final String timeBooking;
    final String userBookingId;
    final MotelModel motelBooking;

    factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
        type: json["type"] == null ? null : json["type"],
        userBookingName: json["userBookingName"] == null ? null : json["userBookingName"],
        timeBooking: json["timeBooking"] == null ? null : json["timeBooking"],
        userBookingId: json["userBookingId"] == null ? null : json["userBookingId"],
        motelBooking: json["motelBooking"] == null ? null : MotelModel.fromJson(json["motelBooking"]),
    );

    Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "userBookingName": userBookingName == null ? null : userBookingName,
        "timeBooking": timeBooking == null ? null : timeBooking,
        "userBookingId": userBookingId == null ? null : userBookingId,
        "motelBooking": motelBooking == null ? null : motelBooking.toJson(),
    };
}
