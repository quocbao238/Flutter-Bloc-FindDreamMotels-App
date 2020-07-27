import 'package:findingmotels/config_app/sizeScreen.dart';
import 'package:findingmotels/package/roundCheckbox/round_check_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:findingmotels/config_app/sizeScreen.dart' as app;

class ReserveModal extends StatefulWidget {
  final ScrollController scrollController;
  const ReserveModal({Key key, this.scrollController}) : super(key: key);

  @override
  _ReserveModalState createState() => _ReserveModalState();
}

class _ReserveModalState extends State<ReserveModal> {
  bool isCheck;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(top: app.Size.getHeight * 0.24 - app.Size.statusBar),
      color: Colors.transparent,
      child: NestedScrollView(
          controller: ScrollController(),
          physics: ScrollPhysics(parent: PageScrollPhysics()),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Material(
                      color: Colors.transparent,
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          color: app.AppColor.colorClipPath,
                        ),
                        child: Center(
                          child: Text(
                            'Enter your details',
                            style: app.StyleText.header24BWhite,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ];
          },
          body: Material(
            color: app.AppColor.backgroundColor,
            child: ListView(
              controller: widget.scrollController,
              padding: EdgeInsets.only(left: 10, right: 10, top: 8),
              children: <Widget>[
                _title('Are you traveling for work ?'),
                Padding(
                  padding: EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0),
                  child: Row(
                    children: <Widget>[
                      roundCheck(true),
                      SizedBox(width: 16.0),
                      roundCheck(false)
                    ],
                  ),
                ),
                Placeholder(),
                Placeholder(),
                Placeholder(),
                Placeholder(),
                Placeholder(),
              ],
            ),
          )),
    );
  }

  Widget roundCheck(bool isYes) {
    return Row(
      children: <Widget>[
        RoundCheckBox(
          size: 30.0,
          onTap: (v) {
            setState(() {
              isCheck != null
                  ? isCheck = !isCheck
                  : isYes ? isCheck = true : isCheck = false;
            });
          },
          isChecked: isYes
              ? isCheck != null ? isCheck = !isCheck : isCheck = isCheck
              : null,
        ),
        SizedBox(width: 8.0),
        Text('${isYes ? 'Yes' : 'No'}', style: StyleText.subhead18Black87w400),
      ],
    );
  }

  Widget _title(String title) => Text(
        title,
        style: StyleText.header20BlackNormal,
      );
}
