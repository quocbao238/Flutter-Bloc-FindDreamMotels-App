import 'package:cached_network_image/cached_network_image.dart';
import 'package:findingmotels/pages/widgets/loadingWidget/loading_widget.dart';
import 'package:flutter/material.dart';

class ImageCacheNetwork extends StatelessWidget {
  final String url;
  final BoxFit boxfit;

  const ImageCacheNetwork({this.url, this.boxfit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      placeholder: (context, url) => Center(child: LoadingWidget()),
      errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
    );
  }
}
