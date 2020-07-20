import 'package:findingmotels/config_app/setting.dart';
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
    await Future.forEach(districList, (data) async {
      await ConfigApp.databaseReference
          .collection(AppSetting.dbData)
          .document(AppSetting.locationHCM)
          .collection(AppSetting.dbdistricList)
          .document(i.toString())
          .setData({'name': data, "districtId": i.toString()});
      i++;
    });
    print("asyncOne end");
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
