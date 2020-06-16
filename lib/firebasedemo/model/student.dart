import 'package:firebase_database/firebase_database.dart';

class Student {
  String _id;
  String _name;
  String _age;
  String _city;
  String _department;
  String _description;

  Student(this._id, this._name, this._age, this._city, this._department,
      this._description);

  Student.map(dynamic object) {
    this._id = object['id'];
    this._name = object['name'];
    this._age = object['age'];
    this._city = object['city'];
    this._department = object['department'];
    this._description = object['description'];
  }

  String get id => _id;
  String get name => _name;
  String get age => _age;
  String get city => _city;
  String get department => _department;
  String get description => _description;

  Student.fromSnapShot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _name = snapshot.value['name'];
    _age = snapshot.value['age'];
    _city = snapshot.value['city'];
    _department = snapshot.value['department'];
    _description = snapshot.value['description'];
  }
}
