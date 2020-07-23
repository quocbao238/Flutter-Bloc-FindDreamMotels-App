import 'dart:math';
import 'package:findingmotels/config_app/sizeScreen.dart';
import 'package:findingmotels/pages/search/bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart' as frs;
import 'package:smooth_star_rating/smooth_star_rating.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  GlobalKey globalKey;
  int typeFilter;
  List<bool> typeStart;
  int randomAveragePrice = 0;
  double _lowerValue;
  double _upperValue;

  @override
  void initState() {
    _lowerValue = 100.0;
    _upperValue = 450.0;
    randomAveragePrice = _lowerValue.toInt() +
        Random().nextInt(_upperValue.toInt() - _lowerValue.toInt());
    typeFilter = 0;
    typeStart = [true, true, true, true, true];
    globalKey = GlobalKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SearchBloc(),
        child: BlocListener<SearchBloc, SearchState>(
            listener: (context, state) => blocListener(state, context),
            child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) => _scaffold())));
  }

  void blocListener(SearchState state, BuildContext context) {
    if (state is ShowBottomSheetStateSucess) {
      typeFilter = state.typeFilter;
    }
  }

  Widget _scaffold() {
    return Scaffold(
        resizeToAvoidBottomPadding: false, //deprecated
        key: globalKey,
        backgroundColor: AppColor.backgroundColor,
        body: _body());
  }

  Widget _body() => Column(
        children: <Widget>[_appBar(), _searchBar(), _descrip()],
      );

  Widget _descrip() {
    return Expanded(
      child: ScrollConfiguration(
        behavior: ScrollBehavior()
          ..buildViewportChrome(context, null, AxisDirection.down),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: <Widget>[
              _filter(),
              _title(text1: 'Price', text2: 'Range'),
              _slider(),
              _price(),
              _title(text1: 'Start', text2: 'Rating'),
              _startRating(),
              _findByMost(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _findByMost() {
    return Container(
      child: Row(
        children: <Widget>[],
      ),
    );
  }

  Widget _startRating() {
    return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.all(0),
        physics: NeverScrollableScrollPhysics(),
        itemCount: 5,
        itemBuilder: ((context, index) => Container(
              padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 10.0),
              child: Row(
                children: <Widget>[
                  SmoothStarRating(
                    rating: (5 - index).toDouble(),
                    isReadOnly: true,
                    size: 24.0,
                    filledIconData: Icons.star,
                    halfFilledIconData: Icons.star_half,
                    defaultIconData: Icons.star_border,
                    starCount: 5,
                    allowHalfRating: true,
                    spacing: 2.0,
                    onRated: (value) {},
                    color: Colors.blueAccent,
                    borderColor: Colors.transparent,
                  ),
                  Spacer(),
                  Checkbox(
                      onChanged: (v) {
                        setState(() {
                          typeStart[index] = !typeStart[index];
                          print(typeStart[index]);
                        });
                      },
                      value: typeStart[index])
                ],
              ),
            )));
  }

  Widget _price() {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 16.0, right: 16.0),
      child: Row(
        children: <Widget>[
          Text('\$${_lowerValue.toInt()} - \$${_upperValue.toInt()}',
              style: GoogleFonts.heebo(
                  color: AppColor.colorClipPath2,
                  fontWeight: FontWeight.w400,
                  fontSize: 14 * Size.scaleTxt)),
          Spacer(),
          Text('Average price',
              style: GoogleFonts.heebo(
                  color: Colors.grey[400],
                  fontWeight: FontWeight.w400,
                  fontSize: 14 * Size.scaleTxt)),
          SizedBox(width: 4.0),
          Text('\$$randomAveragePrice',
              style: GoogleFonts.heebo(
                  color: AppColor.colorClipPath2,
                  fontWeight: FontWeight.w400,
                  fontSize: 14 * Size.scaleTxt)),
        ],
      ),
    );
  }

  Widget _slider() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: frs.RangeSlider(
        min: 0.0,
        max: 1000.0,
        lowerValue: _lowerValue,
        upperValue: _upperValue,
        divisions: 1000,
        showValueIndicator: true,
        valueIndicatorMaxDecimals: 2,
        onChanged: (double newLowerValue, double newUpperValue) {
          setState(() {
            _lowerValue = newLowerValue;
            _upperValue = newUpperValue;
          });
        },
        onChangeStart: (double startLowerValue, double startUpperValue) {
          print('Started with values: $startLowerValue and $startUpperValue');
        },
        onChangeEnd: (double newLowerValue, double newUpperValue) {
          setState(() {
            randomAveragePrice = _lowerValue.toInt() +
                Random().nextInt(_upperValue.toInt() - _lowerValue.toInt());
          });
        },
      ),
    );
  }

  Widget _title({String text1, String text2, Function onFind}) {
    return Container(
      padding: EdgeInsets.only(top: 16.0, left: 16, right: 16, bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(text1,
              style: GoogleFonts.heebo(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 20 * Size.scaleTxt)),
          SizedBox(width: 8.0),
          Text(text2,
              style: GoogleFonts.heebo(
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1.0,
                  color: Colors.black54,
                  fontSize: 20 * Size.scaleTxt)),
          Spacer(),
          GestureDetector(
            onTap: () {
              if (onFind != null) onFind();
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: AppColor.colorClipPath,
              ),
              child: Text('Find'.toUpperCase(),
                  style: GoogleFonts.heebo(
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.0,
                      color: AppColor.whiteColor,
                      fontSize: 16 * Size.scaleTxt)),
            ),
          )
        ],
      ),
    );
  }

  Widget _filter() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: AppColor.whiteColor.withOpacity(0.8)),
      child: InkWell(
        onTap: () {
          BlocProvider.of<SearchBloc>(globalKey.currentContext)
              .add(ShowBottomSheetEvent(globalKey.currentContext));
        },
        child: Row(
          children: <Widget>[
            Text('Filter by',
                style: GoogleFonts.heebo(
                    color: AppColor.colorClipPath,
                    fontWeight: FontWeight.w400,
                    fontSize: 18 * Size.scaleTxt)),
            Spacer(),
            Text(
              getFilterName(typeFilter),
              style: StyleText.subhead18Black87w400,
            ),
            SizedBox(width: 4.0),
            Icon(Icons.arrow_drop_down)
          ],
        ),
      ),
    );
  }

  Widget _searchBar() => Container(
        margin: EdgeInsets.only(bottom: 16.0),
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: TypeAheadField(
          textFieldConfiguration: TextFieldConfiguration(
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColor.colorClipPath, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColor.colorClipPath, width: 1.0),
                ),
                contentPadding: EdgeInsets.all(0),
                prefixIcon: Icon(LineIcons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                hintText: 'Search hotel',
                hintStyle: GoogleFonts.heebo(
                    fontWeight: FontWeight.w500,
                    color: AppColor.colorClipPath,
                    fontSize: 14 * Size.scaleTxt)),
            style: GoogleFonts.heebo(
                fontWeight: FontWeight.w500,
                color: AppColor.colorClipPath,
                fontSize: 14 * Size.scaleTxt),
          ),
          suggestionsCallback: (pattern) async {
            return null;
          },
          itemBuilder: (context, suggestion) {
            return ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text(suggestion['name']),
              subtitle: Text('\$${suggestion['price']}'),
            );
          },
          onSuggestionSelected: (suggestion) {
            // Navigator.of(context).push(MaterialPageRoute(
            //     builder: (context) => ProductPage(product: suggestion)));
          },
        ),
      );

  Widget _appBar() => Container(
        padding: EdgeInsets.only(top: 32.0),
        height: Size.getHeight * 0.12,
        width: Size.getWidth,
        color: AppColor.colorClipPath,
        margin: EdgeInsets.only(bottom: Size.getHeight * 0.02),
        child: Text('Filter Hotels',
            textAlign: TextAlign.center,
            style: GoogleFonts.vidaloka(
                color: Colors.white, fontSize: 24 * Size.scaleTxt)),
      );
}
