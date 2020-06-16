import 'dart:async';

import 'package:findingmotels/config_app/sizeScreen.dart';
import 'package:findingmotels/firebasedemo/model/student.dart';
import 'package:findingmotels/firebasedemo/ui/student_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

final studentReference = FirebaseDatabase.instance.reference().child('student');

class ListViewStudent extends StatefulWidget {
  @override
  _ListViewStudentState createState() => _ListViewStudentState();
}

class _ListViewStudentState extends State<ListViewStudent> {
  List<Student> items;
  StreamSubscription<Event> _onStudentAddSubcription;
  StreamSubscription<Event> _onStudentChangeSubcription;

  @override
  void initState() {
    super.initState();
    items = new List();
    _onStudentAddSubcription =
        studentReference.onChildAdded.listen(__onStudentAdd);
    _onStudentChangeSubcription =
        studentReference.onChildChanged.listen(__onStudentUpdate);
  }

  @override
  void dispose() {
    super.dispose();
    _onStudentAddSubcription.cancel();
    _onStudentChangeSubcription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    getSizeApp(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo Firebase"),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Center(
        child: ListView.builder(
            itemCount: items.length,
            padding: EdgeInsets.only(top: 12.0),
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  Divider(height: 6.0),
                  ListTile(
                    title: Text(
                      "${items[index].name}",
                      style: StyleText.subhead18Black500,
                    ),
                    subtitle: Text(
                      "${items[index].description}",
                      style: StyleText.content14Black400,
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        _deleteStudent(context, items[index], index);
                      },
                    ),
                    leading: FittedBox(
                      child: Center(
                        child: CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 14.0,
                          child: Text(
                            "${items[index].id}",
                            style: StyleText.content14Black400,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      _navigatorStudent(context, items[index], index);
                    },
                  )
                ],
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.red,
          onPressed: () {
            _createNewStudent(context);
          }),
    );
  }

  void __onStudentAdd(Event event) {
    setState(() {
      items.add(new Student.fromSnapShot(event.snapshot));
    });
  }

  void __onStudentUpdate(Event event) {
    var oldStudentValue =
        items.singleWhere((student) => student.id == event.snapshot.key);
    setState(() {
      items[items.indexOf(oldStudentValue)] =
          new Student.fromSnapShot(event.snapshot);
      items.add(new Student.fromSnapShot(event.snapshot));
    });
  }

  void _deleteStudent(BuildContext context, Student student, int index) async {
    await studentReference.child(student.id).remove().then((_) {
      items.removeAt(index);
    });
  }

  void _navigatorStudent(BuildContext context, Student student, int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => StudentScreen(
                  student: student,
                )));
  }

  void _createNewStudent(BuildContext context) {
    Student stNondata = new Student(null, "", "", "", "", "");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => StudentScreen(
                  student: stNondata,
                )));
  }
}
