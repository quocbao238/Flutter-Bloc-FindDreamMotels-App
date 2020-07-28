import 'package:findingmotels/config_app/sizeScreen.dart';
import 'package:flutter/material.dart';

class RoundCheckBox extends StatelessWidget {
  final Function onTap;
  final String title;
  final bool isChecked;
  const RoundCheckBox({this.onTap, this.title, this.isChecked});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        InkWell(
          onTap: () {
            if (onTap != null) onTap();
          },
          child: Ink(
            color: Colors.transparent,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 600),
              curve: Curves.easeInOut,
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 1, color: Colors.grey),
                color: isChecked ? Colors.green : Colors.transparent,
              ),
              child: Center(
                  child: Icon(
                Icons.check,
                color: isChecked ? Colors.white : Colors.transparent,
              )),
            ),
          ),
        ),
        SizedBox(width: 8.0),
        Text(title, style: StyleText.subhead18Black87w400),
      ],
    );
  }
}
