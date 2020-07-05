import 'package:flutter/material.dart';

class MyDrawer
 extends StatelessWidget {
  final bool isCollapsed;
  final double screenWidth;
  final Duration duration;
  final Animation<double> scaleAnimation;
  final Function onMenuTap;
  final Widget child;

  const MyDrawer(
      {Key key,
      this.isCollapsed,
      this.screenWidth,
      this.duration,
      this.scaleAnimation,
      this.onMenuTap,
      this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
        duration: duration,
        top: 0,
        bottom: 0,
        left: isCollapsed ? 0 : 0.45 * screenWidth,
        right:isCollapsed ? 0 : -0.35 * screenWidth,
        child: ScaleTransition(
            scale: scaleAnimation,
            child: Material(
              animationDuration: duration,
              borderRadius: BorderRadius.all(Radius.circular(40)),
              elevation: 0,
              child: child,
            )));
  }
}
