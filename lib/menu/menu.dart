import 'dart:io';

import 'package:calendario/auth/bloc/auth_bloc.dart';
import 'package:calendario/calendar/home_page.dart';
import 'package:calendario/calificaciones/calificaciones.dart';
import 'package:calendario/tareas_clases/clases.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:calendario/auth/user_auth_provider.dart';

import '../login/login.dart';
import 'bloc/image_bloc.dart';

class Menu extends StatefulWidget {
  var ctx;

  Menu({Key key, this.ctx}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  String selectedImage;

  var _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => ImageBloc()..add(GetImageEvent()),
      child: BlocListener<ImageBloc, ImageState>(
        listener: (context, state) {
          if (state is ImageUpdatedState) {
            selectedImage = state.image;
            // print(selectedImage);
            setState(() {});
          }
        },
        child: Container(
          color: color2,
          child: Padding(
            padding: EdgeInsets.all(45.0),
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      (_auth.currentUser != null)
                          ? _auth.currentUser.displayName
                          : "John Doe",
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(color: Colors.white),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                        (_auth.currentUser != null)
                            ? _auth.currentUser.email
                            : "john@doe.eo",
                        style: TextStyle(color: Colors.white)),
                    SizedBox(
                      height: 16,
                    ),
                    CircleAvatar(
                      backgroundImage: selectedImage != null
                          ? NetworkImage(selectedImage)
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
                      leading: Icon(Icons.calendar_today, color: Colors.white),
                      onTap: () {
                        // Navigator.of(context)
                        //     .pushReplacement(MaterialPageRoute(builder: (_) => HomePage()));
                        BlocProvider.of<AuthBloc>(context)
                            .add(GoToCalendarioEvent());
                      },
                    ),
                    ListTile(
                      title: Text("Clases & Tareas",
                          style: TextStyle(color: Colors.white)),
                      leading: Icon(Icons.home, color: Colors.white),
                      onTap: () {
                        // Navigator.of(context)
                        //     .pushReplacement(MaterialPageRoute(builder: (_) => Clases()));
                        BlocProvider.of<AuthBloc>(context)
                            .add(GoToClasesEvent());
                      },
                    ),
                    ListTile(
                      title: Text("Calificaciones",
                          style: TextStyle(color: Colors.white)),
                      leading:
                          Icon(Icons.assignment_turned_in, color: Colors.white),
                      onTap: () {
                        // Navigator.of(context)
                        //     .pushReplacement(MaterialPageRoute(builder: (_) => Calificaciones()));
                        BlocProvider.of<AuthBloc>(context)
                            .add(GoToCalificacionesEvent());
                      },
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
                            BlocProvider.of<AuthBloc>(context)
                                .add(SignOutAuthenticationEvent());
                            // Navigator.of(widget.ctx).pushAndRemoveUntil(
                            //     MaterialPageRoute(
                            //         builder: (BuildContext context) {
                            //   return Login();
                            // }), (Route<dynamic> route) => false);
                            // UserAuthProvider().signOut();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class _MenuState extends State<Menu> {}
