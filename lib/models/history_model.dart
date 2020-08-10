import 'dart:convert';
import 'package:findingmotels/models/motel_model.dart';

HistoryModel historyModelFromJson(String str) =>
    HistoryModel.fromJson(json.decode(str));

String historyModelToJson(HistoryModel data) => json.encode(data.toJson());

class HistoryModel {
  HistoryModel({
    this.type,
    this.userBookingName,
    this.timeBooking,
    this.detailBooking,
    this.userBookingId,
    this.motelBooking,
  });

  final int type;
  final String userBookingName;
  final String timeBooking;
  final DetailBooking detailBooking;
  final String userBookingId;
  final MotelModel motelBooking;

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
        type: json["type"] == null ? null : json["type"],
        userBookingName:
            json["userBookingName"] == null ? null : json["userBookingName"],
        timeBooking: json["timeBooking"] == null ? null : json["timeBooking"],
        userBookingId:
            json["userBookingId"] == null ? null : json["userBookingId"],
        detailBooking: json["detailBooking"] == null
            ? null
            : DetailBooking.fromJson(json["detailBooking"]),
        motelBooking: json["motelBooking"] == null
            ? null
            : MotelModel.fromJson(json["motelBooking"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "userBookingName": userBookingName == null ? null : userBookingName,
        "timeBooking": timeBooking == null ? null : timeBooking,
        "userBookingId": userBookingId == null ? null : userBookingId,
        "detailBooking": detailBooking == null ? null : detailBooking.toJson(),
        "motelBooking": motelBooking == null ? null : motelBooking.toJson(),
      };
}

class DetailBooking {
  bool travelWork;
  bool lookingFor;
  double totalPrice;
  String gustName;
  String checkIn;
  String checkOut;
  List<Availability> availability;
  DetailBooking(
      {this.travelWork,
      this.lookingFor,
      this.gustName,
      this.checkIn,
      this.checkOut,
      this.totalPrice,
      this.availability});

  factory DetailBooking.fromJson(Map<String, dynamic> json) => DetailBooking(
        travelWork: json["travelWork"] == null ? null : json["travelWork"],
        lookingFor: json["lookingFor"] == null ? null : json["lookingFor"],
        gustName: json["gustName"] == null ? null : json["gustName"],
        checkIn: json["checkIn"] == null ? null : json["checkIn"],
        totalPrice:
            json["totalPrice"] == null ? null : json["totalPrice"].toDouble(),
        checkOut: json["checkOut"] == null ? null : json["checkOut"],
        availability: json["availability"] == null
            ? null
            : List<Availability>.from(
                json["availability"].map((x) => Availability.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "travelWork": travelWork == null ? null : travelWork,
        "lookingFor": lookingFor == null ? null : lookingFor,
        "gustName": gustName == null ? null : gustName,
        "checkIn": checkIn == null ? null : checkIn,
        "totalPrice": totalPrice == null ? null : totalPrice,
        "checkOut": checkOut == null ? null : checkOut,
        "availability": availability == null
            ? null
            : List<dynamic>.from(availability.map((x) => x.toJson())),
      };
}

class Availability {
  List<String> listDropbox;
  int total;
  String typeRoom;
  double price;
  double totalPrice;

  Availability(
      {this.listDropbox,
      this.total,
      this.typeRoom,
      this.price,
      this.totalPrice = 0});

  factory Availability.fromJson(Map<String, dynamic> json) => Availability(
        listDropbox: json["listDropbox"] == null
            ? null
            : List<String>.from(json["listDropbox"].map((x) => x)),
        total: json["total"] == null ? null : json["total"],
        typeRoom: json["typeRoom"] == null ? null : json["typeRoom"],
        price: json["price"] == null ? null : json["price"].toDouble(),
        totalPrice:
            json["totalPrice"] == null ? null : json["totalPrice"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "listDropbox": listDropbox == null
            ? null
            : List<dynamic>.from(listDropbox.map((x) => x)),
        "total": total == null ? null : total,
        "typeRoom": typeRoom == null ? null : typeRoom,
        "price": price == null ? null : price,
        "totalPrice": totalPrice == null ? null : totalPrice,
      };
}

List<Availability> getListAvailabiity(MotelModel motelModel) {
  List<Availability> listAvailability = [
    Availability(
        listDropbox: [
          '0',
          '1  (${(double.parse(motelModel.price)).toStringAsFixed(1)}\$)',
          '2  (${(double.parse(motelModel.price) * 2.0 ).toStringAsFixed(1)}\$)',
          '3  (${(double.parse(motelModel.price) * 3.0 ).toStringAsFixed(1)}\$)',
          '4  (${(double.parse(motelModel.price) * 4.0).toStringAsFixed(1)}\$)',
          '5  (${(double.parse(motelModel.price) * 5.0 ).toStringAsFixed(1)}\$)'
        ],
        price: double.parse(motelModel.price) * 1,
        typeRoom: 'Standard  Room',
        total: 0),
    Availability(
        listDropbox: [
          '0',
          '1  (${(double.parse(motelModel.price)).toStringAsFixed(1)}\$)',
          '2  (${(double.parse(motelModel.price) * 2.0 * 1.25).toStringAsFixed(1)}\$)',
          '3  (${(double.parse(motelModel.price) * 3.0 * 1.25).toStringAsFixed(1)}\$)',
          '4  (${(double.parse(motelModel.price) * 4.0 * 1.25).toStringAsFixed(1)}\$)',
          '5  (${(double.parse(motelModel.price) * 5.0 * 1.25).toStringAsFixed(1)}\$)'
        ],
        price: double.parse(motelModel.price) * 1.25,
        typeRoom: 'Superior Room',
        total: 0),
    Availability(
        listDropbox: [
          '0',
          '1  (${(double.parse(motelModel.price)).toStringAsFixed(1)}\$)',
          '2  (${(double.parse(motelModel.price) * 2.0 * 1.35).toStringAsFixed(1)}\$)',
          '3  (${(double.parse(motelModel.price) * 3.0 * 1.35).toStringAsFixed(1)}\$)',
          '4  (${(double.parse(motelModel.price) * 4.0 * 1.35).toStringAsFixed(1)}\$)',
          '5  (${(double.parse(motelModel.price) * 5.0 * 1.35).toStringAsFixed(1)}\$)'
        ],
        price: double.parse(motelModel.price) * 1.35,
        typeRoom: 'Deluxe Room',
        total: 0),
    Availability(
        listDropbox: [
          '0',
          '1  (${(double.parse(motelModel.price)).toStringAsFixed(1)}\$)',
          '2  (${(double.parse(motelModel.price) * 2.0 * 1.45).toStringAsFixed(1)}\$)',
          '3  (${(double.parse(motelModel.price) * 3.0 * 1.45).toStringAsFixed(1)}\$)',
          '4  (${(double.parse(motelModel.price) * 4.0 * 1.45).toStringAsFixed(1)}\$)',
          '5  (${(double.parse(motelModel.price) * 5.0 * 1.45).toStringAsFixed(1)}\$)'
        ],
        price: double.parse(motelModel.price) * 1.45,
        typeRoom: 'Suite Room',
        total: 0),
  ];
  return listAvailability;
}
