import 'package:flutter/material.dart';

import 'package:findingmotels/config_app/sizeScreen.dart';

class DisPlayBottomMotel {
  String title;
  IconData icon;

  DisPlayBottomMotel({
    this.title,
    this.icon,
  });
}

Future<int> displayBottomSheet(
    {BuildContext context, List<DisPlayBottomMotel> list}) async {
  int indexFunction;
  await showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      backgroundColor: AppColor.whiteColor,
      builder: (bottomContext) {
        return Container(
          height: 200,
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 5.0, bottom: 15.0),
                height: 4,
                width: 60.0,
                color: Colors.black26,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: list.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          Navigator.of(context).pop(index);
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 16, right: 16),
                          height: 40.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              // Container(height: 1, color: Colors.black54),
                              Row(
                                children: <Widget>[
                                  Icon(list[index].icon, size: 24.0),
                                  SizedBox(width: 8.0),
                                  Text(
                                    list[index].title,
                                    style: StyleText.subhead18GreenMixBlue,
                                  ),
                                ],
                              ),
                              // Container(height: 1, color: Colors.transparent),
                            ],
                          ),
                        ),
                      ))
            ],
          ),
        );
      }).then((index) {
    indexFunction = index != null ? index : null;
  });
  return indexFunction;
}
