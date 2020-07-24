import 'dart:async';
import 'dart:convert';
import 'package:findingmotels/config_app/setting.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:findingmotels/config_app/configApp.dart';
import 'package:findingmotels/helper/ulti.dart';
import 'package:findingmotels/models/motel_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MyGoogleMapService {
  Future<void> checkPermissions() async {
    final PermissionStatus permissionGrantedResult =
        await ConfigApp.location.hasPermission();
    ConfigApp.permissionStatus = permissionGrantedResult;
  }

  Future<void> requestPermission() async {
    if (ConfigApp.permissionStatus != PermissionStatus.granted) {
      final PermissionStatus permissionRequestedResult =
          await ConfigApp.location.requestPermission();
      ConfigApp.permissionStatus = permissionRequestedResult;
      if (permissionRequestedResult != PermissionStatus.granted) {
        return;
      }
    }
  }

  Future<LocationData> getLocation() async {
    try {
      ConfigApp.locationData = await ConfigApp.location.getLocation();
      print("getLocation Lat" + ConfigApp.locationData.latitude.toString());
      print("getLocation Lng" + ConfigApp.locationData.longitude.toString());

      ConfigApp.mylatLng = LatLng(
          ConfigApp.locationData.latitude, ConfigApp.locationData.longitude);
      return ConfigApp.locationData;
    } on PlatformException catch (err) {
      print(
          'Error _getLocation in MyGoogleMapService Message:' + err.toString());
    }
    return null;
  }

  StreamSubscription<LocationData> _locationSubscription;
  Future<void> listenLocation() async {
    _locationSubscription =
        ConfigApp.location.onLocationChanged.handleError((dynamic err) {
      print('Error listenLocation in MyGoogleMapService Message:' +
          err.toString());
      _locationSubscription.cancel();
    }).listen((LocationData currentLocation) {
      ConfigApp.mylatLng = LatLng(
          ConfigApp.locationData.latitude, ConfigApp.locationData.longitude);
      ConfigApp.locationData = currentLocation;
      print(ConfigApp.locationData.toString());
      Future.delayed(Duration(seconds: 5));
    });
  }

  Future<void> stopListen() async {
    print('StopStream');
    _locationSubscription.cancel();
  }

  Future<void> gotoMyLocation({double zoom = 16.0}) async {
    final GoogleMapController controller = await ConfigApp.ggCompleter.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: ConfigApp.mylatLng ??
            LatLng(37.43296265331129, -122.08832357078792),
        zoom: zoom)));
  }

  Future<Marker> setMakerIcon(
      BuildContext context, MotelModel motelModel) async {
    BitmapDescriptor makerIcon = await Helper.getAssetIcon(context);
    var maker = Marker(
        markerId: MarkerId(motelModel.userIdCreate),
        position: LatLng(motelModel.location.lat, motelModel.location.lng),
        infoWindow: InfoWindow(
            title: motelModel.title, snippet: motelModel.address, onTap: () {}),
        icon: makerIcon);
    return maker;
  }

  Future<Set<Polyline>> drawePolyline(LatLng l1, LatLng l2) async {
    Set<Polyline> _polyLines = {};
    String url = await getRouteCoordinates(l1, l2);
    _polyLines = createRoute(url);
    return _polyLines;
  }

  Future<String> getRouteCoordinates(LatLng l1, LatLng l2) async {
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=${AppSetting.directionKey}";
    var response = await http.get(url);
    Map values = jsonDecode(response.body);
    return values["routes"][0]["overview_polyline"]["points"];
  }

  Set<Polyline> createRoute(String encondedPoly) {
    Set<Polyline> _polyLines = {};
    _polyLines.add(Polyline(
        polylineId: PolylineId("Demo"),
        width: 6,
        points: _convertToLatLng(_decodePoly(encondedPoly)),
        color: Colors.red));
    return _polyLines;
  }

  List _decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = new List();
    int index = 0;
    int len = poly.length;
    int c = 0;
    do {
      var shift = 0;
      int result = 0;
      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);
    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];
    print(lList.toString());
    return lList;
  }

  List<LatLng> _convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }
}
