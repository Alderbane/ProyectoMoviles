import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  Menu({Key key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(45.0),
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "john doe",
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(color: Colors.black),
              ),
              SizedBox(
                height: 8,
              ),
              Text("jdoe@email.com"),
              SizedBox(
                height: 16,
              ),
              ListTile(
                title: Text("Calendario"),
                leading: Icon(Icons.calendar_today),
                onTap: () {},
              ),
              ListTile(
                title: Text("Clases"),
                leading: Icon(Icons.home),
                onTap: () {},
              ),
              ListTile(
                title: Text("Calificaciones"),
                leading: Icon(Icons.assignment_turned_in),
                onTap: () {},
              ),
              ListTile(
                title: Text("Tareas"),
                leading: Icon(Icons.assignment),
                onTap: () {},
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    child: Text("Cerrar sesión"),
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/login', (Route<dynamic> route) => false);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
