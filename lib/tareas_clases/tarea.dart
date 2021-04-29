import 'package:calendario/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/event.dart';

//'${selectedTime.hour}:${(selectedTime.minute<10)?"0":""}${selectedTime.minute}'

class Tarea extends StatefulWidget {
  Tarea({Key key}) : super(key: key);

  @override
  _TareaState createState() => _TareaState();
}

class _TareaState extends State<Tarea> {
  var event;

  @override
  Widget build(BuildContext context) {
    event = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Tarea"),
        backgroundColor: Color(0xff212D40),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: 30,
          left: 20,
          right: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(event.titulo)
            ],
          ),
        ),
      ),
      backgroundColor: color1,
    );
  }
}
