import 'package:findingmotels/config_app/sizeScreen.dart';
import 'package:findingmotels/pages/search/bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  GlobalKey globalKey;
  int typeFilter = 0;
  @override
  void initState() {
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
        children: <Widget>[
          _appBar(),
          _searchBar(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.0),
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: AppColor.whiteColor.withOpacity(0.8)),
                    child: InkWell(
                      onTap: () {
                        BlocProvider.of<SearchBloc>(globalKey.currentContext)
                            .add(
                                ShowBottomSheetEvent(globalKey.currentContext));
                      },
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Filter by',
                            style: StyleText.subhead18GreenMixBlue,
                          ),
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
                  )
                ],
              ),
            ),
          )
        ],
      );

  Widget _searchBar() => Container(
        margin: EdgeInsets.only(bottom: 16.0),
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: TypeAheadField(
          textFieldConfiguration: TextFieldConfiguration(
            decoration: InputDecoration(
              prefixIcon: Icon(LineIcons.search),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
              hintText: 'Search hotel',
            ),
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
