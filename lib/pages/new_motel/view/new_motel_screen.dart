import 'package:cached_network_image/cached_network_image.dart';
import 'package:findingmotels/config_app/configApp.dart';
import 'package:findingmotels/config_app/sizeScreen.dart';
import 'package:findingmotels/widgets/clip_path_custom/loginClipPath.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewMotelPage extends StatefulWidget {
  @override
  _NewMotelPageState createState() => _NewMotelPageState();
}

class _NewMotelPageState extends State<NewMotelPage> {
  TextEditingController titleTextEditingController;
  TextEditingController descriptionTextEditingController;
  TextEditingController phoneTextEditingController;
  TextEditingController addresasTextEditingController;
  String district;

  @override
  void initState() {
    super.initState();
    titleTextEditingController = TextEditingController();
    descriptionTextEditingController = TextEditingController();
    phoneTextEditingController =
        TextEditingController(text: ConfigUserInfo.phone);
    phoneTextEditingController =
        TextEditingController(text: ConfigUserInfo.address);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Stack(children: <Widget>[buildBackground(0.06), _body()]),
    );
  }

  Widget _body() {
    return Positioned.fill(
      child: Column(
        children: <Widget>[
          _appBar(),
          _content(),
        ],
      ),
    );
  }

  Widget _appBar() {
    return Container(
      padding: EdgeInsets.only(top: 16.0),
      height: Size.getHeight * 0.11,
      width: Size.getWidth,
      color: AppColor.colorClipPath,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Text('New Post',
              textAlign: TextAlign.center,
              style: GoogleFonts.vidaloka(
                  color: Colors.white, fontSize: 24 * Size.scaleTxt)),
          IconButton(
            icon: Icon(
              Icons.fiber_new,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget buildBackground(double height) => Positioned.fill(
        child: ClipPath(
          child: Container(
            color: AppColor.colorClipPath,
          ),
          clipper: HomeClipPath(height),
        ),
      );

  Widget _content() => Expanded(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 16, 0, 8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _profile(),
                _customTextField(
                    title: "Title",
                    hintext: "Write a title",
                    textStyle: StyleText.header20BlackW500,
                    textEditingController: titleTextEditingController,
                    topMargin: 20.0),
                _customTextField(
                    title: "Description",
                    hintext: "Write a description",
                    maxLines: 4,
                    textEditingController: descriptionTextEditingController,
                    topMargin: 10.0),
                _customTextField(
                    hintext: "PhoneNumber",
                    keyboardStyle: TextInputType.phone,
                    iconData: Icons.phone,
                    textEditingController: phoneTextEditingController,
                    topMargin: 10.0),
                _customTextField(
                    hintext: "Address",
                    readOnly: true,
                    keyboardStyle: TextInputType.phone,
                    iconData: Icons.location_city,
                    textEditingController: addresasTextEditingController,
                    topMargin: 10.0),
                _districtPrice(),
                _getImage()
              ],
            ),
          ),
        ),
      );

  Widget _getImage() {
    return Row(
      children: <Widget>[
        InkWell(
          onTap: () {},
          child: Container(
            padding:
                EdgeInsets.only(left: 16.0, top: 8, bottom: 8, right: 16.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: AppColor.colorClipPath),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.image, color: Colors.white),
                SizedBox(width: 4.0),
                Text(
                  district != null ? district : 'Add Photo',
                  style: StyleText.subhead16White500,
                ),
              ],
            ),
          ),
        ),
        Spacer(),
      ],
    );
  }

  Widget _districtPrice() {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Row(
        children: <Widget>[_getDistrict(), Spacer(), _price()],
      ),
    );
  }

  Widget _price() {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('Price ', style: StyleText.subhead18Black500),
          Container(
            child: IntrinsicWidth(
              child: TextField(
                maxLines: 1,
                keyboardType: TextInputType.number,
                style: StyleText.subhead18GreenMixBlue,
                decoration: InputDecoration(
                    hintText: '....',
                    hintStyle: StyleText.subhead18Grey400,
                    border: InputBorder.none),
              ),
            ),
          ),
          Text(' \$', style: StyleText.subhead16Red500),
        ],
      ),
    );
  }

  Widget _getDistrict() {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: AppColor.colorClipPath),
        child: Text(
          district != null ? district : 'Select District',
          style: StyleText.subhead16White500,
        ),
      ),
    );
  }

  Widget _customTextField(
          {double topMargin = 10,
          bool readOnly = false,
          TextStyle textStyle,
          TextInputType keyboardStyle = TextInputType.text,
          IconData iconData,
          String title,
          String hintext,
          int maxLines,
          TextEditingController textEditingController}) =>
      Container(
        margin: EdgeInsets.only(top: topMargin, right: 8.0),
        child: TextField(
            style: textStyle != null ? textStyle : StyleText.subhead16Black,
            keyboardType: keyboardStyle,
            readOnly: readOnly,
            onTap: () {
              if (readOnly) {
                print('onTap');
              }
            },
            decoration: InputDecoration(
                prefixIcon: iconData != null ? Icon(iconData) : null,
                enabledBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide:
                      BorderSide(width: 2, color: AppColor.colorClipPath),
                ),
                hintText: "$hintext",
                hintStyle: StyleText.subhead16GreenMixBlue,
                alignLabelWithHint: true,
                labelText: title != null ? '$title' : null,
                labelStyle: StyleText.subhead16GreenMixBlue),
            maxLines: maxLines != null ? maxLines : 1,
            controller: textEditingController),
      );

  Widget _profile() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 40.0,
          width: 40.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(60.0),
            child: CachedNetworkImage(
                imageUrl: ConfigApp.fbuser.photoUrl,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress)),
                errorWidget: (context, url, error) =>
                    Center(child: Icon(Icons.error))),
          ),
        ),
        SizedBox(width: 10.0),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              ConfigApp.fbuser.displayName,
              style: StyleText.subhead16Black,
            ),
            Text(
              ConfigApp.fbuser.email,
              style: StyleText.content14Black400,
            )
          ],
        )
      ],
    );
  }
}
