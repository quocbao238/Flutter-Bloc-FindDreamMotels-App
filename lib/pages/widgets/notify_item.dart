import 'package:findingmotels/config_app/setting.dart';
import 'package:findingmotels/config_app/sizeScreen.dart';
import 'package:findingmotels/helper/ulti.dart';
import 'package:findingmotels/models/history_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class NotifyItem extends StatelessWidget {
  final int index;
  final HistoryModel historyModel;
  final Function onTap;

  NotifyItem({this.historyModel, this.onTap, this.index});
  @override
  Widget build(BuildContext context) {
    return _item();
  }

  Widget _item() => Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(index == 0 ? 30.0 : 0.0)),
          color: AppColor.backgroundColor,
        ),
        child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: AppColor.whiteColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _itemImage(),
              Expanded(child: _itemMessage()),
              // Spacer(),
              _itemArrow(),
            ],
          ),
        ),
      );
  Widget _itemArrow() => InkWell(
        onTap: () => onTap(),
        child: Container(
          margin: EdgeInsets.only(left: 20.0),
          padding: EdgeInsets.all(10.0),
          height: 48.0,
          width: 48.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColor.colorClipPath.withOpacity(0.2),
          ),
          child: Center(
            child: Icon(
              Icons.arrow_forward,
              size: 24.0,
              color: AppColor.colorClipPath,
            ),
          ),
        ),
      );

  Widget _itemMessage() => Container(
        margin: EdgeInsets.only(left: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Text('${historyModel.motelBooking.title}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: StyleText.subhead16GreenMixBlue),
                ),
                Text(historyModel.type == 1 ? "Booking" : "History",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: StyleText.content14Grey400),
              ],
            ),
            SizedBox(height: 2.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(Helper.getTypeRoom(historyModel),
                    style: StyleText.content14Grey400),
                Text(
                    '${DateFormat('HH:mm dd-MM-yyyy').format(DateTime.fromMillisecondsSinceEpoch(int.parse(historyModel.timeBooking)))}',
                    style: StyleText.content14Grey400),
              ],
            ),
          ],
        ),
      );

  Widget _itemImage() => Container(
        height: 48.0,
        width: 48.0,
        child: SvgPicture.asset(historyModel.type == 0
            ? AppSetting.historyIconSvg
            : AppSetting.messageIconSvg),
      );
}
