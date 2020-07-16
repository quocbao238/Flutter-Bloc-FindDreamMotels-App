import 'package:findingmotels/config_app/configApp.dart';
import 'package:findingmotels/config_app/sizeScreen.dart' as app;
import 'package:findingmotels/models/userInfo_model.dart';
import 'package:findingmotels/pages/user_edit/bloc/user_edit_bloc.dart';
import 'package:findingmotels/widgets/clip_path_custom/loginClipPath.dart';
import 'package:findingmotels/widgets/customcatch_image/customcatch_image.dart';
import 'package:findingmotels/widgets/loadingWidget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oktoast/oktoast.dart';
import 'package:intl/intl.dart';

class UserEditPage extends StatefulWidget {
  @override
  _UserEditPageState createState() => _UserEditPageState();
}

class _UserEditPageState extends State<UserEditPage> {
  GlobalKey globalKey;
  TextEditingController _nameController,
      _phoneController,
      _birthdayController,
      _emailController,
      _addressController;
  bool isEdit;

  @override
  void initState() {
    isEdit = false;
    globalKey = GlobalKey();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _addressController = TextEditingController();
    _birthdayController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => UserEditBloc()..add(FeatchDataEvent()),
        child: BlocListener<UserEditBloc, UserEditState>(
            listener: (context, state) => blocListener(state, context),
            child: BlocBuilder<UserEditBloc, UserEditState>(
                builder: (context, state) => _scaffold(state))));
  }

  void blocListener(UserEditState state, BuildContext context) {
    if (state is FeatchDataSucessState) {
      _nameController = TextEditingController(text: state.userInfo.name);
      _phoneController = TextEditingController(text: state.userInfo.phone);
      _emailController = TextEditingController(text: state.userInfo.email);
      _addressController = TextEditingController(text: state.userInfo.address);
      _birthdayController =
          TextEditingController(text: state.userInfo.birthday);
    } else if (state is ChangeStatusEditState) {
      isEdit = state.isEdit;
    } else if (state is EditProfileSucessState) {
      isEdit = false;
      showToast('Update Info successful!');
    }
  }

  Widget _scaffold(UserEditState state) => Scaffold(
      key: globalKey,
      body: _body(state),
      backgroundColor: app.AppColor.backgroundColor);

  Widget _body(UserEditState state) => Stack(
        children: <Widget>[
          buildBackground(0.32),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[_appBar(), content()],
          ),
          state is LoadingState ? LoadingWidget() : const SizedBox(),
        ],
      );

  Widget content() => Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 16.0),
              _item(
                  title: 'Name',
                  controller: _nameController,
                  itemisEdit: isEdit),
              _item(
                  title: 'Phone',
                  controller: _phoneController,
                  itemisEdit: isEdit),
              _item(
                  title: 'Birthday',
                  controller: _birthdayController,
                  onTap: () {
                    DatePicker.showDatePicker(
                      context,
                      showTitleActions: true,
                      minTime: DateTime(1900, 1, 1),
                      maxTime: DateTime.now(),
                      onChanged: (date) {},
                      onConfirm: (date) {
                        // print(date);
                        print(DateFormat('dd-MM-yyyy').format(date));
                        _birthdayController.text =
                            DateFormat('dd-MM-yyyy').format(date);
                      },
                      currentTime: DateFormat('dd-MM-yyyy')
                              .parse(_birthdayController.text.trim()) ??
                          DateTime(1990),
                      locale: LocaleType.en,
                    );
                  },
                  itemisEdit: false),
              _item(
                  title: 'Email',
                  controller: _emailController,
                  itemisEdit: false,
                  onTap: () => showToast('Unable to change email')),
              _item(
                  title: 'Address',
                  controller: _addressController,
                  itemisEdit: isEdit),
              SizedBox(height: 32.0),
              isEdit
                  ? InkWell(
                      onTap: () {
                        BlocProvider.of<UserEditBloc>(globalKey.currentContext)
                            .add(EditProfileEVent(UserInfoModel(
                                name: _nameController.text.trim() ?? " ",
                                address: _addressController.text.trim() ?? " ",
                                birthday:
                                    _birthdayController.text.trim() ?? " ",
                                email: ConfigApp.fbuser.email ?? " ",
                                phone: _phoneController.text.trim() ?? " ",
                                photoUrl: ConfigApp.fbuser.photoUrl ?? " ")));
                      },
                      child: AnimatedContainer(
                        duration: Duration(seconds: 1),
                        width: app.Size.getWidth * 0.8,
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            border: Border.all(
                                width: 2, color: app.AppColor.colorClipPath)),
                        child: Center(
                          child: Text(
                            'Save Profile',
                            style: app.StyleText.subhead18GreenMixBlue,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
              SizedBox(height: 16.0)
            ],
          ),
        ),
      );

  Widget _appBar() => Container(
        padding: EdgeInsets.only(top: 32.0),
        // margin: EdgeInsets.only(bottom: app.Size.getHeight * 0.02),
        child: Column(
          children: <Widget>[
            _appbarTitle(),
            _avatar(),
            // _userName(),
          ],
        ),
      );

  Widget _appbarTitle() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _leadIcon(),
          Text('${isEdit ? 'Edit User Profile' : 'User Profile'}',
              textAlign: TextAlign.center,
              style: GoogleFonts.vidaloka(
                  color: Colors.white, fontSize: 24 * app.Size.scaleTxt)),
          _rightIcon(),
        ],
      );

  Widget _rightIcon() => IconButton(
        icon: Icon(isEdit ? Icons.cancel : Icons.mode_edit,
            size: 30.0, color: Colors.white),
        onPressed: () {
          BlocProvider.of<UserEditBloc>(globalKey.currentContext)
              .add(ChangeStatusEditEvent(isEdit: isEdit));
        },
      );

  Widget _leadIcon() => IconButton(
        icon: Icon(Icons.arrow_back_ios, size: 30, color: Colors.white),
        onPressed: () {
          Navigator.pop(globalKey.currentContext);
          FocusScope.of(context).requestFocus(FocusNode());
        },
      );

  Widget buildBackground(double height) => Positioned.fill(
        child: ClipPath(
          child: Container(
            color: app.AppColor.colorClipPath,
          ),
          clipper: HomeClipPath(height),
        ),
      );

  Widget _item(
          {String title,
          TextEditingController controller,
          bool itemisEdit,
          Function onTap}) =>
      InkWell(
        onTap: () {
          if (onTap != null) if (isEdit) onTap();
        },
        child: TextField(
          maxLines: 1,
          onTap: () {},
          enabled: itemisEdit,
          controller: controller,
          style: app.StyleText.subhead16Black,
          decoration: InputDecoration(
              prefix: Container(
                width: app.Size.getWidth * 0.3,
                padding: EdgeInsets.only(left: 5, right: 15.0),
                child: Text(
                  title.toUpperCase(),
                  style: app.StyleText.subhead14GreenMixBlue,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                //  when the TextFormField in unfocused
              ),
              disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                //  when the TextFormField in focused
              ),
              contentPadding: EdgeInsets.all(16.0)),
        ),
      );

  Widget _avatar() => GestureDetector(
        onTap: () {
          print('Demo');
          BlocProvider.of<UserEditBloc>(globalKey.currentContext)
              .add(UpdateAvatarEvent());
        },
        child: Container(
          height: app.Size.getHeight * 0.2,
          width: app.Size.getHeight * 0.2,
          margin: EdgeInsets.only(bottom: app.Size.getHeight * 0.05),
          child: Stack(
            children: <Widget>[
              Container(
                height: app.Size.getHeight * 0.2,
                width: app.Size.getHeight * 0.2,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.grey[400]),
              ),
              Container(
                padding: EdgeInsets.all(4.0),
                width: app.Size.getHeight * 0.2,
                height: app.Size.getHeight * 0.2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(90.0),
                  child: ImageCacheNetwork(
                    url: ConfigApp?.fbuser?.photoUrl ?? "",
                  ),
                ),
              ),
              Positioned(
                bottom: 8,
                right: 8,
                child: Container(
                  padding: EdgeInsets.only(bottom: 2.0),
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.grey[400],
                      border: Border.all(color: Colors.white, width: 1.0)),
                  child: Center(
                    child: Icon(
                      Icons.camera_enhance,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
