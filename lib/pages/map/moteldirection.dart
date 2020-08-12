import 'package:findingmotels/config_app/configApp.dart';
import 'package:findingmotels/helper/ulti.dart';
import 'package:findingmotels/models/motel_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapMotelDirection extends StatefulWidget {
  final MotelModel motelModel;
  const MapMotelDirection({this.motelModel});

  @override
  _MapMotelDirectionState createState() => _MapMotelDirectionState();
}

class _MapMotelDirectionState extends State<MapMotelDirection> {
  List<LatLng> listLatLng = List();
  Set<Marker> markers = {};
  Set<Polyline> polyline = {};
  LatLng latlngCenterMap;

  CameraPosition initialCameraPosition =
      CameraPosition(target: ConfigApp.mylatLng, zoom: 14.5);

  Future<void> addMarkerButtonPressed() async {
    BitmapDescriptor customIcon = await Helper.getAssetIcon(context);
    polyline = await ConfigApp.myGoogleMapService.drawePolyline(
        ConfigApp.mylatLng,
        LatLng(widget.motelModel.location.lat, widget.motelModel.location.lng));
    setState(() {
      markers.add(Marker(
          markerId: MarkerId(ConfigApp.mylatLng.toString()),
          position: LatLng(
              widget.motelModel.location.lat, widget.motelModel.location.lng),
          infoWindow: InfoWindow(
              title: widget.motelModel.title,
              snippet: 'PhoneNumber:' + widget.motelModel.phoneNumber,
              onTap: () {}),
          icon: customIcon));
    });
    // ConfigApp.myGoogleMapService.listenLocation();
  }

  _awaitAddMaker() async {
    await addMarkerButtonPressed();
  }

  @override
  void initState() {
    super.initState();
    ConfigApp.myGoogleMapService
        .getLocation()
        .then((value) => listLatLng.add(ConfigApp.mylatLng));
    listLatLng.add(
        LatLng(widget.motelModel.location.lat, widget.motelModel.location.lng));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _awaitAddMaker();
    });
    latlngCenterMap = getCenterLatLng(ConfigApp.mylatLng,
        LatLng(widget.motelModel.location.lat, widget.motelModel.location.lng));
  }

  LatLng getCenterLatLng(LatLng l1, LatLng l2) {
    double centerLat = (l1.latitude + l2.latitude) / 2;
    double centerLng = (l1.longitude + l2.longitude) / 2;
    return LatLng(centerLat, centerLng);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _map(),
          _buttonBack(),
          // Positioned(
          //   top: MediaQuery.of(context).padding.top + 10,
          //   left: 0,
          //   child: Container(
          //     height: 50.0,
          //     width: 80.0,
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.only(
          //             topRight: Radius.circular(25),
          //             bottomRight: Radius.circular(25)),
          //         color: Colors.grey.withOpacity(0.5)),
          //     child: Center(
          //       child: IconButton(
          //         padding: EdgeInsets.only(right: 10.0),
          //         icon: Icon(
          //           Icons.arrow_back,
          //           size: 30,
          //           color: Colors.white,
          //         ),
          //         onPressed: () {
          //           Navigator.of(context).pop();
          //         },
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buttonBack() {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 10,
      left: 0,
      child: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Container(
          width: 80.0,
          height: 50.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
            color: Colors.grey.withOpacity(0.6),
          ),
          child: Center(
              child:
                  Icon(Icons.arrow_back_ios, size: 30.0, color: Colors.white)),
        ),
      ),
    );
  }

  GoogleMap _map() {
    return GoogleMap(
      mapType: MapType.normal,
      markers: markers,
      initialCameraPosition: initialCameraPosition,
      myLocationEnabled: true,
      onMapCreated: (GoogleMapController controller) {
        if (latlngCenterMap != null)
          controller
              .animateCamera(CameraUpdate.newLatLngZoom(latlngCenterMap, 13));
      },
      polylines: polyline,
    );
  }
}
