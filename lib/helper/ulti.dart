import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Helper {
  Helper._();

  static Future<BitmapDescriptor> getAssetIcon(
    BuildContext context,
  ) async {
    Completer<BitmapDescriptor> bitmapIcon = Completer<BitmapDescriptor>();
    ImageConfiguration config =
        createLocalImageConfiguration(context);
    AssetImage('assets/logo/makerIcon128.png')
        .resolve(config)
        .addListener(ImageStreamListener((ImageInfo image, bool sync) async {
      ByteData bytes =
          await image.image.toByteData(format: ImageByteFormat.png);
      BitmapDescriptor bitmap =
          BitmapDescriptor.fromBytes(bytes.buffer.asUint8List());
      bitmapIcon.complete(bitmap);
    }));
    return await bitmapIcon.future;
  }
}
