import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'config_app/configApp.dart';

class CreateDataPage extends StatefulWidget {
  @override
  _CreateDataPageState createState() => _CreateDataPageState();
}

class _CreateDataPageState extends State<CreateDataPage> {
  List<String> districList = [
    "District 1",
    "District 2",
    "District 3",
    "District 4",
    "District 5",
    "District 6",
    "District 7",
    "District 8",
    "District 9",
    "District 10",
    "District 11",
    "District 12",
    "Binh Tan District",
    "Binh Thanh District",
    "Go Vap District",
    "Phu Nhuan District",
    "Tan Binh District",
    "Tan Phu District",
    "Thu Duc District",
    "Binh Chanh District",
    "Can Gio District",
    "Cu Chi District",
    "Hoc Mon District",
    "Nha Be District"
  ];

  Future<bool> createCategoriesData(List<String> list) async {
    List<District> _listDistrict = [];
    for (int i = 0; i < list.length; i++) {
      _listDistrict.add(District(name: list[i], id: i.toString()));
      await ConfigApp.databaseReference
          .collection("districList")
          .document(ConfigApp.fbuser.uid)
          .setData({'name': list[i], "id": i.toString()});
    }
    await ConfigApp.databaseReference
        .collection("user")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) {
        print(f.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createCategoriesData(districList);
        },
        child: Center(
          child: Icon(
            Icons.add,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}

class District {
  String name;
  String id;
  District({
    this.name,
    this.id,
  });
}
