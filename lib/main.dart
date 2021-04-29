import 'package:calendario/calendar/add_event.dart';
import 'package:calendario/calendar/event_details.dart';
import 'package:calendario/calendar/event_page.dart';
import 'package:calendario/calendar/home_page.dart';
import 'package:calendario/login/login.dart';
import 'package:calendario/login/signin.dart';
import 'package:calendario/login/signup.dart';
import 'package:calendario/splash2.dart';
import 'package:calendario/tareas_clases/clases.dart';
import 'package:calendario/tareas_clases/tarea.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:calendario/models/event.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final _localStorage = await getApplicationDocumentsDirectory();
  Hive
    ..init(_localStorage.path)
    ..registerAdapter(CalendarAdapter());
  await Hive.openBox("CalendarEvents");
  await Firebase.initializeApp();
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
        "/eventDetail": (context) => EventDetails(),
        "/addEvent": (context) => AddEvent(),
        "/eventPage": (context) => EventPage(),
        "/tarea": (context) => Tarea(),
        "/clases": (context) => Clases()
      },
    );
  }
}
