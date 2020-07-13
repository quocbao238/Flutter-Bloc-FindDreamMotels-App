import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  final bool filter;
  LoadingWidget({this.filter = true});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        filter
            ? Container(
                width: double.infinity,
                height: double.infinity,
                child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                    child: Container(color: Colors.black.withOpacity(0.4))))
            : SizedBox(),
        Center(
            child: SpinKitFoldingCube(
                duration: Duration(milliseconds: 800),
                itemBuilder: (BuildContext context, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                        color: index.isEven ? Colors.red : Colors.green),
                  );
                }))
      ],
    );
  }
}
