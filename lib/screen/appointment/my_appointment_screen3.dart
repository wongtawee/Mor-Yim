import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:moryim/screen/appointment/Data/myData.dart';

class MyAppointmentScreen3 extends StatefulWidget {
  @override
  _MyAppointmentScreen3State createState() => _MyAppointmentScreen3State();
}

class _MyAppointmentScreen3State extends State<MyAppointmentScreen3> {
  List<myData> allData = [];

  @override
  // ignore: must_call_super
  void initState() {
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    ref.child('Moryim').once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;
      allData.clear();
      for (var key in keys) {
        myData d = new myData(
          data[key]['name'],
          data[key]['lastname'],
          data[key]['Date'],
          data[key]['Time'],
          data[key]['list'],
          data[key]['note'],
        );
        allData.add(d);
      }
      setState(() {
        print('Length : ${allData.length}');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('รายละเอียดการจอง'),
      ),
      body: new Container(
          child: allData.length == 0
              ? new Text(' No Data is Available')
              : new ListView.builder(
                  itemCount: allData.length,
                  itemBuilder: (_, index) {
                    return UI(
                      allData[index].name,
                      allData[index].lastname,
                      allData[index].Date,
                      allData[index].Time,
                      allData[index].list,
                      allData[index].note,
                    );
                  },
                )),
    );
  }

  // ignore: non_constant_identifier_names
  Widget UI(String name, String lastname, String Date, String Time, String list,
      String note) {
    return Card(
      elevation: 10.0,
      child: new Container(
        padding: new EdgeInsets.all(20.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(
              'FirstName : $name',
              style: Theme.of(context).textTheme.headline6,
            ),
            new Text(
              'LastName : $lastname',
            ),
            new Text(
              'Date : $Date',
            ),
            new Text(
              'Time : $Time',
            ),
            new Text(
              'list : $list',
            ),
            new Text(
              'note : $note',
            ),
          ],
        ),
      ),
    );
  }
}
