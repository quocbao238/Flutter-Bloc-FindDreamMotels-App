import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findingmotels/config_app/setting.dart';
import 'package:findingmotels/models/motel_model.dart';
import 'package:flutter/material.dart';
import 'config_app/configApp.dart';

class CreateDataPage extends StatefulWidget {
  @override
  _CreateDataPageState createState() => _CreateDataPageState();
}

class _CreateDataPageState extends State<CreateDataPage> {
  int i = 0;
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

  createCategoriesData() async {
    print("asyncOne start");
    // await Future.forEach(districList, (data) async {
    //   await ConfigApp.databaseReference
    //       .collection(AppSetting.dbData)
    //       .document(AppSetting.locationHCM)
    //       .collection(AppSetting.dbdistricList)
    //       .document(i.toString())
    //       .setData({'name': data, "districtId": i.toString()});
    //   i++;
    // });
    for (int i = 0; i < 2; i++) {
      await featchMotelList(
        idLast: i.toString(),
      );
    }
    print("asyncOne end");
  }

  Future<List<MotelModel>> featchMotelList({String idLast}) async {
    List<MotelModel> listMotel = [];
    await ConfigApp.databaseReference
        .collection(AppSetting.dbData) // data
        .document(AppSetting.locationHCM) //hcm
        .collection(idLast) //District1
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) async {
        var motel = MotelModel.fromJson(f.data);
        await ConfigApp.databaseReference
            .collection(AppSetting.dbData)
            .document(AppSetting.locationHCM)
            .collection(AppSetting.dbpopular)
            .document(f.documentID)
            .setData(motel.toJson());
      });
    });
    listMotel.sort((a, b) => double.parse(a.timeUpdate.toString())
        .compareTo(double.parse(b.timeUpdate.toString())));
    return listMotel;
  }

  Future setDataToServer(
      {int districtId, MotelModel newmotel, int documentId}) async {
    await ConfigApp.databaseReference
        .collection(AppSetting.dbData)
        .document(AppSetting.locationHCM)
        .collection(districtId.toString())
        .document(documentId.toString())
        .setData(newmotel.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createCategoriesData();
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
