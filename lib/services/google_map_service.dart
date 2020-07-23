import 'dart:async';

import 'package:findingmotels/config_app/configApp.dart';
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
    });
  }

  Future<void> stopListen() async {
    print('StopStream');
    _locationSubscription.cancel();
  }

  Future<void> gotoMyLocation({double zoom = 10.0}) async {
    final GoogleMapController controller = await ConfigApp.ggCompleter.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: ConfigApp.mylatLng ??
            LatLng(37.43296265331129, -122.08832357078792),
        zoom: zoom)));
  }
}
