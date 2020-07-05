part of 'drawer_bloc.dart';

abstract class DrawerEvent extends Equatable {
  @override
  List<Object> get props => null;
}

class MenuEvent extends DrawerEvent {
  final bool isCollapsed;
  MenuEvent(this.isCollapsed);
}
