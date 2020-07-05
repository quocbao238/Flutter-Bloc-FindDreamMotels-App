class Amenities {
  final String name;
  final String urlIcon;
  final bool isHave;

  Amenities({this.name, this.urlIcon, this.isHave});
}

List<Amenities> listAmenities = [
  Amenities(name: "Free Wifi", urlIcon: 'assets/icon/wifiIcon.png', isHave: true),
  Amenities(name: "Bed", urlIcon: 'assets/icon/bedIcon.png', isHave: true),
  Amenities(name: "Air\nCondition", urlIcon: 'assets/icon/airIcon.png', isHave: true),
  Amenities(name: "BathRoom", urlIcon: 'assets/icon/bathIcon.png', isHave: true),
];
