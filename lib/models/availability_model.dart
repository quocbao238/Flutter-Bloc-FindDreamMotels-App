import 'package:findingmotels/models/motel_model.dart';

class Availability {
  List<String> listDropbox;
  int value;
  String typeRoom;
  double price;
  Availability({this.listDropbox, this.value, this.typeRoom, this.price});
}

List<Availability> getListAvailabiity(MotelModel motelModel) {
  List<Availability> listAvailability = [
    Availability(
        listDropbox: [
          '0',
          '1  (${double.parse(motelModel.price)}\$)',
          '2  (${double.parse(motelModel.price) * 2}\$)',
          '3  (${double.parse(motelModel.price) * 3}\$)',
          '4  (${double.parse(motelModel.price) * 4}\$)',
          '5  (${double.parse(motelModel.price) * 5}\$)'
        ],
        price: double.parse(motelModel.price) * 1,
        typeRoom: 'Deluxe Double Room',
        value: 0),
    Availability(
        listDropbox: [
          '0',
          '1  (${double.parse(motelModel.price)}\$)',
          '2  (${double.parse(motelModel.price) * 2}\$)',
          '3  (${double.parse(motelModel.price) * 3}\$)',
          '4  (${double.parse(motelModel.price) * 4}\$)',
          '5  (${double.parse(motelModel.price) * 5}\$)'
        ],
        price: double.parse(motelModel.price) * 1.25,
        typeRoom: 'Deluxe Double or Twin Room',
        value: 0),
    Availability(
        listDropbox: [
          '0',
          '1  (${double.parse(motelModel.price)}\$)',
          '2  (${double.parse(motelModel.price) * 2}\$)',
          '3  (${double.parse(motelModel.price) * 3}\$)',
          '4  (${double.parse(motelModel.price) * 4}\$)',
          '5  (${double.parse(motelModel.price) * 5}\$)'
        ],
        price: double.parse(motelModel.price) * 1.35,
        typeRoom: 'Large Double or Twin Room',
        value: 0),
  ];
  return listAvailability;
}
