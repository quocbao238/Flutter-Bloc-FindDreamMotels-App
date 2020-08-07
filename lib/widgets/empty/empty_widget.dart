import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EmptyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: Duration(milliseconds: 4000),
        curve: Curves.easeInOutQuint,
        child: Center(child: SvgPicture.asset('assets/images/empty.svg')));
  }
}
