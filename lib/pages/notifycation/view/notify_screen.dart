import 'package:findingmotels/config_app/sizeScreen.dart';
import 'package:findingmotels/models/history_model.dart';
import 'package:findingmotels/pages/history_detail/view/history_detail_screen.dart';
import 'package:findingmotels/pages/notifycation/bloc/notify_bloc.dart';
import 'package:findingmotels/pages/widgets/clip_path_custom/appClipPath.dart';
import 'package:findingmotels/pages/widgets/empty/empty_widget.dart';
import 'package:findingmotels/pages/widgets/loadingWidget/loading_widget.dart';
import 'package:findingmotels/pages/widgets/notify_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class NotifyPage extends StatefulWidget {
  @override
  _NotifyPageState createState() => _NotifyPageState();
}

class _NotifyPageState extends State<NotifyPage> {
  GlobalKey globalKey;
  List<HistoryModel> listHistory = [];

  @override
  void initState() {
    globalKey = GlobalKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => NotifyBloc()..add(FeatchListHistoryEvent()),
        child: BlocListener<NotifyBloc, NotifyState>(
            listener: (context, state) => blocListener(state, context),
            child: BlocBuilder<NotifyBloc, NotifyState>(
                builder: (context, state) => _scaffold(state))));
  }

  void blocListener(NotifyState state, BuildContext context) {
    if (state is FeatchListHistorySucessState) {
      listHistory = state.listHistory;
    }
  }

  Widget _scaffold(NotifyState state) => Scaffold(
        key: globalKey,
        backgroundColor: AppColor.backgroundColor,
        body: Stack(children: <Widget>[
          buildBackground(0.12),
          state is LoadingState ? LoadingWidget() : _body(state)
        ]),
      );

  Widget _body(NotifyState state) => Positioned.fill(
        child: Column(
          children: <Widget>[
            _appBar(),
            _content(state),
          ],
        ),
      );

  Widget _content(NotifyState state) {
    Widget data = Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.only(top: Size.getHeight * 0.08),
          itemCount: listHistory.length,
          itemBuilder: (context, index) => NotifyItem(
                index: index,
                historyModel: listHistory[index],
                onTap: () {
                  Navigator.of(context).push(
                    new MaterialPageRoute(
                      builder: (context) {
                        return HistoryDetailPage(
                            historyModel: listHistory[index]);
                      },
                    ),
                  );
                },
              )),
    );
    Widget empty = Expanded(child: EmptyWidget());
    if (state is LoadingState) {
      return LoadingWidget();
    } else {
      return listHistory.length > 0 ? data : empty;
    }
  }
}

Widget _appBar() => Container(
      padding: EdgeInsets.only(top: 32.0),
      margin: EdgeInsets.only(bottom: Size.getHeight * 0.02),
      child: Text('Booking History',
          textAlign: TextAlign.center,
          style: GoogleFonts.vidaloka(
              color: Colors.white, fontSize: 24 * Size.scaleTxt)),
    );

Widget buildBackground(double height) => Positioned.fill(
      child: ClipPath(
        child: Container(
          color: AppColor.colorClipPath,
        ),
        clipper: HomeClipPath(height),
      ),
    );
