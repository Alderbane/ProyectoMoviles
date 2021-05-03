import 'package:calendario/menu/menu.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class Calificaciones extends StatefulWidget {
  Calificaciones({Key key}) : super(key: key);

  @override
  _CalificacionesState createState() => _CalificacionesState();
}

class _CalificacionesState extends State<Calificaciones> {
  @override
  Widget build(BuildContext context) {
    var ctx = context;
    return Scaffold(
      backgroundColor: Color(0xff1F2125),
      appBar: AppBar(
        title: Text("Calificaciones"),
        backgroundColor: Color(0xff212D40),
      ),
      body: Padding(
        padding: EdgeInsets.all(2),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                // border: Border.all(width: 0.8),
                // color: Color(0xff5DB5C1),
                borderRadius: BorderRadius.circular(5.0),
              ),
              margin:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: ListTile(
                leading: Icon(
                  Icons.assignment_turned_in,
                  size: 40,
                  color: color5,
                ),
                title: Text('DISEÑO DE BASES DE DATOS',
                    style: TextStyle(color: color5)),
                subtitle: Text('CALIFICACION: N/A',
                    style: TextStyle(color: Colors.white, fontSize: 15)),
                onTap: () {
                  // print("${e.titulo}, ${e.descripcion}");
                  // Navigator.of(context).pushNamed("/tarea", arguments: event);
                }, //Redirecciona a nuevo widget el cual cuenta con los detalles del evento de ese día
              ),
            ),
            Container(
              decoration: BoxDecoration(
                // border: Border.all(width: 0.8),
                // color: Color(0xff5DB5C1),
                borderRadius: BorderRadius.circular(5.0),
              ),
              margin:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: ListTile(
                leading: Icon(
                  Icons.assignment_turned_in,
                  size: 40,
                  color: color5,
                ),
                title: Text('CALCULO DIFERENCIAL',
                    style: TextStyle(color: color5)),
                subtitle: Text('CALIFICACION: 93.55%',
                    style: TextStyle(color: Colors.white, fontSize: 15)),
                onTap: () {
                  // print("${e.titulo}, ${e.descripcion}");
                  // Navigator.of(context).pushNamed("/tarea", arguments: event);
                }, //Redirecciona a nuevo widget el cual cuenta con los detalles del evento de ese día
              ),
            ),
            Container(
              decoration: BoxDecoration(
                // border: Border.all(width: 0.8),
                // color: Color(0xff5DB5C1),
                borderRadius: BorderRadius.circular(5.0),
              ),
              margin:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: ListTile(
                leading: Icon(
                  Icons.assignment_turned_in,
                  size: 40,
                  color: color5,
                ),
                title: Text('PROGRAMACION ORIENTADA A OBJETOS',
                    style: TextStyle(color: color5)),
                subtitle: Text('CALIFICACION: 86.36%',
                    style: TextStyle(color: Colors.white, fontSize: 15)),
                onTap: () {
                  // print("${e.titulo}, ${e.descripcion}");
                  // Navigator.of(context).pushNamed("/tarea", arguments: event);
                }, //Redirecciona a nuevo widget el cual cuenta con los detalles del evento de ese día
              ),
            ),
            Container(
              decoration: BoxDecoration(
                // border: Border.all(width: 0.8),
                // color: Color(0xff5DB5C1),
                borderRadius: BorderRadius.circular(5.0),
              ),
              margin:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: ListTile(
                leading: Icon(
                  Icons.assignment_turned_in,
                  size: 40,
                  color: color5,
                ),
                title: Text('CONTEXTO HISTORICO Y SOCIAL',
                    style: TextStyle(color: color5)),
                subtitle: Text('CALIFICACION: 74.75%',
                    style: TextStyle(color: Colors.white, fontSize: 15)),
                onTap: () {
                  // print("${e.titulo}, ${e.descripcion}");
                  // Navigator.of(context).pushNamed("/tarea", arguments: event);
                }, //Redirecciona a nuevo widget el cual cuenta con los detalles del evento de ese día
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: Menu(
          ctx: ctx,
        ),
      ),
    );
  }
}
