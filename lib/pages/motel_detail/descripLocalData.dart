import 'package:findingmotels/config_app/setting.dart';

class Amenities {
  final String name;
  final String urlIcon;
  final bool isHave;

  Amenities({this.name, this.urlIcon, this.isHave});
}

List<Amenities> listAmenities = [
  Amenities(name: "Free Wifi", urlIcon: AppSetting.wifiIcon, isHave: true),
  Amenities(name: "Bed", urlIcon: AppSetting.bedIcon, isHave: true),
  Amenities(name: "Air\nCondition", urlIcon: AppSetting.airIcon, isHave: true),
  Amenities(name: "BathRoom", urlIcon: AppSetting.bathIcon, isHave: true),
];
