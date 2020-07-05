import 'package:findingmotels/config_app/sizeScreen.dart';
import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Favorite Page",
        style: StyleText.header20Black,
      ),
    );
  }
}
