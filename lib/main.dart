import 'package:calendario/add_event.dart';
import 'package:calendario/event_page.dart';
import 'package:calendario/home_page.dart';
import 'package:calendario/login/login.dart';
import 'package:calendario/login/signin.dart';
import 'package:calendario/login/signup.dart';
import 'package:calendario/splash2.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting('es_MX').then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'School Calendar',
      initialRoute: '/splash',
      routes: {
        "/splash": (context) => Splash2(),
        "/": (context) => HomePage(),
        "/login": (context) => Login(),
        "/signin": (context) => Signin(),
        "/signup": (context) => Signup(),
        "/addEvent": (context) => AddEvent(),
        "/eventPage": (context) => EventPage(),
      },
    );
  }
}
