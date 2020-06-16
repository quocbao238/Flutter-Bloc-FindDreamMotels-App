import 'package:findingmotels/firebasedemo/model/student.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class StudentScreen extends StatefulWidget {
  final Student student;
  const StudentScreen({Key key, this.student}) : super(key: key);

  @override
  _StudentScreenState createState() => _StudentScreenState();
}

final studentReference = FirebaseDatabase.instance.reference().child('student');

class _StudentScreenState extends State<StudentScreen> {
  TextEditingController _nameController,
      _ageController,
      _cityController,
      _departmentController,
      _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.student.name);
    _ageController = TextEditingController(text: widget.student.age);
    _cityController = TextEditingController(text: widget.student.city);
    _departmentController =
        TextEditingController(text: widget.student.department);
    _descriptionController =
        TextEditingController(text: widget.student.description);
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _ageController.dispose();
    _cityController.dispose();
    _departmentController.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sudent"),
        backgroundColor: Colors.red,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 15),
        alignment: Alignment.centerLeft,
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              style: TextStyle(fontSize: 16.0, color: Colors.deepPurpleAccent),
              decoration:
                  InputDecoration(icon: Icon(Icons.person), labelText: "Name"),
            ),
            Padding(padding: EdgeInsets.only(top: 8.0)),
            TextField(
              controller: _ageController,
              style: TextStyle(fontSize: 16.0, color: Colors.deepPurpleAccent),
              decoration:
                  InputDecoration(icon: Icon(Icons.person), labelText: "Age"),
            ),
            Padding(padding: EdgeInsets.only(top: 8.0)),
            TextField(
              controller: _cityController,
              style: TextStyle(fontSize: 16.0, color: Colors.deepPurpleAccent),
              decoration:
                  InputDecoration(icon: Icon(Icons.person), labelText: "City"),
            ),
            Padding(padding: EdgeInsets.only(top: 8.0)),
            TextField(
              controller: _departmentController,
              style: TextStyle(fontSize: 16.0, color: Colors.deepPurpleAccent),
              decoration: InputDecoration(
                  icon: Icon(Icons.person), labelText: "Department"),
            ),
            Padding(padding: EdgeInsets.only(top: 8.0)),
            TextField(
              controller: _descriptionController,
              style: TextStyle(fontSize: 16.0, color: Colors.deepPurpleAccent),
              decoration: InputDecoration(
                  icon: Icon(Icons.person), labelText: "Description"),
            ),
            Padding(padding: EdgeInsets.only(top: 8.0)),
            FlatButton(
              child: Text("${(widget.student.id != null) ? "Update" : "Add"}"),
              onPressed: () {
                if (widget.student.id != null) {
                  studentReference.child(widget.student.id).set({
                    'name': _nameController.text,
                    'age': _ageController.text,
                    'city': _cityController.text,
                    'department': _departmentController.text,
                    'description': _descriptionController.text,
                  }).then((_) {
                    Navigator.pop(context);
                  });
                } else {
                  studentReference.push().set({
                    'name': _nameController.text,
                    'age': _ageController.text,
                    'city': _cityController.text,
                    'department': _departmentController.text,
                    'description': _descriptionController.text,
                  }).then((_) {
                    Navigator.pop(context);
                  });
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
