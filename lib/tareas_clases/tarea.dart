import 'package:calendario/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    List horaList = event["hora"].split(":");
    TimeOfDay time =
        TimeOfDay(hour: int.parse(horaList[0]), minute: int.parse(horaList[1]));
    return Scaffold(
      appBar: AppBar(
        title: Text("Tarea"),
        backgroundColor: Color(0xff212D40),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Row(
                      children: [
                        Text(
                          event["nombre"],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.white30,
                  ),
                  Row(
                    children: [
                      Text("Fecha de entrega",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                          "${new DateFormat.yMMMMEEEEd('es').format(event["fecha"])} en ${horaList[0]}:${(int.parse(horaList[1]) < 10 ? '0' : '')}${horaList[1]}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w300))
                    ],
                  ),
                  Divider(
                    color: Colors.white30,
                  ),
                  Row(
                    children: [
                      Text("Tipo de archivo habilitado",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      Text(event["tipo"],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w300))
                    ],
                  ),
                  Divider(
                    color: Colors.white30,
                  ),
                  Row(
                    children: [
                      Text("Descripcion",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                          child: Flexible(
                              child: Text(event["descripcion"],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300))))
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      backgroundColor: color1,
    );
  }
}
