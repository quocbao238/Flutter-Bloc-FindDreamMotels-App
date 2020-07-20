import 'package:cached_network_image/cached_network_image.dart';
import 'package:findingmotels/config_app/configApp.dart';
import 'package:findingmotels/config_app/sizeScreen.dart';
import 'package:findingmotels/models/motel_model.dart';
import 'package:findingmotels/pages/new_motel/bloc/newmotel_bloc.dart';
import 'package:findingmotels/widgets/clip_path_custom/loginClipPath.dart';
import 'package:findingmotels/widgets/loadingWidget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:oktoast/oktoast.dart';

class NewMotelPage extends StatefulWidget {
  @override
  _NewMotelPageState createState() => _NewMotelPageState();
}

class _NewMotelPageState extends State<NewMotelPage> {
  TextEditingController titleTextEditingController;
  TextEditingController descriptionTextEditingController;
  TextEditingController priceTextEditingController;
  TextEditingController phoneTextEditingController;
  TextEditingController addressTextEditingController;

  String district;
  int totalPhoto;
  GlobalKey _globalKey;
  List<Asset> _listImg;
  List<Amenity> _listAmenity;
  Location location;

  @override
  void initState() {
    super.initState();
    print('NewMotelScreen');
    location = Location(lng: 123.123, lat: 123.123);
    _globalKey = GlobalKey();
    titleTextEditingController = TextEditingController();
    descriptionTextEditingController = TextEditingController();
    phoneTextEditingController =
        TextEditingController(text: ConfigUserInfo.phone);
    addressTextEditingController =
        TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => NewmotelBloc(),
        child: BlocListener<NewmotelBloc, NewmotelState>(
            listener: (context, state) => blocListener(state, context),
            child: BlocBuilder<NewmotelBloc, NewmotelState>(
                builder: (context, state) => _scaffold(state))));
  }

  void blocListener(NewmotelState state, BuildContext context) {
    if (state is OnTapSelectDistrictSucessState) {
      district = state.district;
    } else if (state is OnTapSelectImgSucessState) {
      _listImg = state.listImg;
      totalPhoto = _listImg.length;
    } else if (state is OnTapSelectAmenitiesSucessState) {
      _listAmenity = state.lstamenities;
    } else if (state is OnTapCreatePostFailState) {
      showToast(state.errorMessage);
    } else if (state is OnTapCreatePostSucessState) {
      Navigator.of(context).pop();
    }
  }

  Widget _scaffold(NewmotelState state) {
    return Stack(
      children: <Widget>[
        Scaffold(
          key: _globalKey,
          backgroundColor: AppColor.backgroundColor,
          body: Stack(children: <Widget>[
            buildBackground(0.06),
            _body(),
          ]),
        ),
        state is LoadingState ? LoadingWidget() : SizedBox(),
      ],
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
      padding: EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
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
              Icons.edit,
              color: Colors.white,
            ),
            onPressed: () {
              BlocProvider.of<NewmotelBloc>(_globalKey.currentContext).add(
                OnTapCreateEvent(
                  address: addressTextEditingController.text.trim(),
                  description: descriptionTextEditingController.text.trim(),
                  districtId: districList.indexOf(district) >= 0
                      ? districList.indexOf(district)
                      : null,
                  amenities: _listAmenity,
                  price: priceTextEditingController.text.trim(),
                  phoneNumber: ConfigUserInfo.phone ?? "",
                  location: location,
                  title: titleTextEditingController.text.trim(),
                  listImg: _listImg,
                  // location: location,
                ),
              );
            },
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
        child: Container(
          // color: AppColor.backgroundColor,
          color: Colors.transparent,
          padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
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
                    // readOnly: false,
                    keyboardStyle: TextInputType.text,
                    iconData: Icons.location_city,
                    textEditingController: addressTextEditingController,
                    topMargin: 10.0),
                _districtAmenities(),
                _getImagePrice(),
                _listImg != null
                    ? Container(
                        color: AppColor.backgroundColor,
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _listImg.length,
                          itemBuilder: (context, index) => Container(
                            color: AppColor.backgroundColor,
                            margin: EdgeInsets.fromLTRB(0, 8, 8, 8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: AssetThumb(
                                asset: _listImg[index],
                                width: Size.getWidth.toInt(),
                                height: (Size.getHeight * 0.3).toInt(),
                              ),
                            ),
                          ),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ),
      );

  Widget _getImagePrice() {
    return Container(
      color: AppColor.backgroundColor,
      child: Row(
        children: <Widget>[
          _selectButton(
              name: 'Add Photo',
              iconData: Icons.add_a_photo,
              enableName: totalPhoto != null ? '$totalPhoto Photo' : null,
              enableColor: totalPhoto != null ? AppColor.colorClipPath : null,
              function: () {
                BlocProvider.of<NewmotelBloc>(_globalKey.currentContext)
                    .add(OnTapSelectImgEvent(_listImg));
              }),
          Spacer(),
          _price()
        ],
      ),
    );
  }

  Widget _districtAmenities() {
    return Container(
      padding: EdgeInsets.only(top: 10.0, right: 15.0),
      color: AppColor.backgroundColor,
      child: Row(
        children: <Widget>[
          _selectButton(
              name: 'Select District',
              iconData: Icons.my_location,
              enableName: district,
              enableColor: district != null ? AppColor.colorClipPath : null,
              function: () {
                BlocProvider.of<NewmotelBloc>(_globalKey.currentContext).add(
                    OnTapSelectDistrictEvent(
                        context: _globalKey.currentContext,
                        district: district));
              }),
          Spacer(),
          _selectButton(
              name: 'Select Amenities',
              iconData: Icons.ac_unit,
              enableColor: _listAmenity != null ? AppColor.colorClipPath : null,
              function: () {
                BlocProvider.of<NewmotelBloc>(_globalKey.currentContext).add(
                    OnTapSelectAmenitiesEvent(
                        listAmenity: _listAmenity,
                        context: _globalKey.currentContext));
              }),
        ],
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
                controller: priceTextEditingController,
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

  Widget _selectButton({
    Color enableColor,
    dynamic varible,
    String name,
    String enableName,
    IconData iconData,
    Function function,
  }) {
    return InkWell(
      onTap: () {
        if (function != null) function();
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
        // width: 160,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: enableColor != null ? enableColor : AppColor.selectColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              // Icons.add_location,
              iconData,
              size: 20.0,
              color: Colors.white,
            ),
            SizedBox(width: 4.0),
            Text(
              enableName != null ? enableName : name,
              style: StyleText.subhead16White500,
            ),
          ],
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
        color: AppColor.backgroundColor,
        padding: EdgeInsets.only(top: topMargin, right: 8.0),
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
    return Container(
      padding: EdgeInsets.only(top: 16.0),
      color: Colors.transparent,
      child: Row(
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
      ),
    );
  }
}
