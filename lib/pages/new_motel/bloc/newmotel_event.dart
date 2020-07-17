part of 'newmotel_bloc.dart';

abstract class NewmotelEvent extends Equatable {
  const NewmotelEvent();
  @override
  List<Object> get props => throw UnimplementedError();
}

class OnTapSelectDistrictEvent extends NewmotelEvent {
  final String district;
  final BuildContext context;
  OnTapSelectDistrictEvent({this.context, this.district});
}

class OnTapSelectAmenitiesEvent extends NewmotelEvent {
  final BuildContext context;
  final List<Amenity> listAmenity;
  OnTapSelectAmenitiesEvent({this.context, this.listAmenity});
}

class OnTapSelectImgEvent extends NewmotelEvent {
  final List<Asset> image;
  OnTapSelectImgEvent(this.image);
}

class OnTapCreateEvent extends NewmotelEvent {
  final int districtId;
  final String title;
  final String address;
  final String price;
  final String phoneNumber;
  final List<Asset> listImg;
  final List<Amenity> amenities;
  final String description;
  final Location location;

  OnTapCreateEvent(
      {this.districtId,
      this.title,
      this.address,
      this.price,
      this.phoneNumber,
      this.listImg,
      this.amenities,
      this.description,
      this.location});
}
