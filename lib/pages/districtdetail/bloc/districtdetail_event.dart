part of 'districtdetail_bloc.dart';

abstract class DistrictdetailEvent extends Equatable {
  const DistrictdetailEvent();
  @override
  List<Object> get props => [];
}

class GoToDetailEvent extends DistrictdetailEvent {
  final MotelModel model;
  GoToDetailEvent(this.model);
}

class OnTapDirectionEvent extends DistrictdetailEvent {
  final MotelModel model;
  OnTapDirectionEvent(this.model);
}


class FeatchMotelDistrict extends DistrictdetailEvent {
  final String id;
  FeatchMotelDistrict(this.id);
}
