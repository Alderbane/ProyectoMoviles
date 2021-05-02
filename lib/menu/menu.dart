import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:calendario/auth/user_auth_provider.dart';

import '../login/login.dart';
import 'bloc/image_bloc.dart';

class Menu extends StatelessWidget {
  File selectedImage;
  var ctx;
  var _auth = FirebaseAuth.instance;
  Menu({Key key, this.ctx}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImageBloc()..add(GetImageEvent()),
      child: BlocBuilder<ImageBloc, ImageState>(
        builder: (context, state) {
          if (state is ImageUpdatedState) {
            selectedImage = state.image;
          }
          return Container(
            color: color2,
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
                      CircleAvatar(
                        backgroundImage: selectedImage != null
                            ? FileImage(selectedImage)
                            : NetworkImage(
                                "https://www.nicepng.com/png/detail/413-4138963_unknown-person-unknown-person-png.png"),
                        minRadius: 40,
                        maxRadius: 80,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      MaterialButton(
                        child: Text("Cambiar imagen",
                            style: TextStyle(color: Colors.white)),
                        color: color4,
                        onPressed: () {
                          ImageBloc()..add(ChangeImageEvent());
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      ListTile(
                        title: Text("Calendario",
                            style: TextStyle(color: Colors.white)),
                        leading:
                            Icon(Icons.calendar_today, color: Colors.white),
                        onTap: () {},
                      ),
                      ListTile(
                        title: Text("Clases & Tareas",
                            style: TextStyle(color: Colors.white)),
                        leading: Icon(Icons.home, color: Colors.white),
                        onTap: () {
                          Navigator.of(this.ctx).pushNamed("/clases");
                        },
                      ),
                      ListTile(
                        title: Text("Calificaciones",
                            style: TextStyle(color: Colors.white)),
                        leading: Icon(Icons.assignment_turned_in,
                            color: Colors.white),
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
                              UserAuthProvider().signOut();
                              Navigator.of(ctx).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) {
                                return Login();
                              }), (Route<dynamic> route) => false);
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
        },
      ),
    );
  }
}

// class _MenuState extends State<Menu> {}
