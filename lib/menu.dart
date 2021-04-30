import 'package:flutter/material.dart';
import './models/event.dart';
import 'package:firebase_core/firebase_core.dart'; // new
import 'package:firebase_auth/firebase_auth.dart'; // new
import 'package:provider/provider.dart'; // new

class Menu extends StatefulWidget {
  Menu({Key key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  var _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff212D40),
      child: Padding(
        padding: EdgeInsets.all(45.0),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  _auth.currentUser.displayName,
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(color: Colors.white),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(_auth.currentUser.email,
                    style: TextStyle(color: Colors.white)),
                SizedBox(
                  height: 16,
                ),
                ListTile(
                  title:
                      Text("Calendario", style: TextStyle(color: Colors.white)),
                  leading: Icon(Icons.calendar_today, color: Colors.white),
                  onTap: () {},
                ),
                ListTile(
                  title: Text("Clases & Tareas",
                      style: TextStyle(color: Colors.white)),
                  leading: Icon(Icons.home, color: Colors.white),
                  onTap: () {
                    Navigator.of(context).pushNamed("/clases");
                  },
                ),
                ListTile(
                  title: Text("Calificaciones",
                      style: TextStyle(color: Colors.white)),
                  leading:
                      Icon(Icons.assignment_turned_in, color: Colors.white),
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
                    child: MaterialButton(
                      child: Text("Cerrar sesión",
                          style: TextStyle(color: Colors.white)),
                      color: Color(0xff33393E),
                      onPressed: () async {
                        await _auth.signOut();
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/login', (Route<dynamic> route) => false);
                        print(_auth.currentUser);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
