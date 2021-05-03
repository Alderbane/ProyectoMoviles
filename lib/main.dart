import 'dart:io';

import 'package:calendario/calendar/add_event.dart';
import 'package:calendario/calendar/event_details.dart';
import 'package:calendario/calendar/event_page.dart';
import 'package:calendario/calendar/home_page.dart';
import 'package:calendario/calificaciones/calificaciones.dart';
import 'package:calendario/login/login.dart';
import 'package:calendario/login/signin.dart';
import 'package:calendario/login/signup.dart';
import 'package:calendario/splash2.dart';
import 'package:calendario/tareas_clases/clases.dart';
import 'package:calendario/tareas_clases/tarea.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:calendario/models/event.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final _localStorage = await getApplicationDocumentsDirectory();
  Hive
    ..init(_localStorage.path)
    ..registerAdapter(CalendarAdapter());
  await Hive.openBox("CalendarEvents");
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  initializeDateFormatting('es_MX').then((_) => runApp(MyApp()));
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async{
  //request HTTP para actualizar datos internos
  // IO guardar cosas en el almacenamiento local
  // Conectanos a firebase y guardar datos
  // actualizaciones
  // Nada relacionado a la UI
  // Importante: si el mensaje tiene "notification" Firebase muestra la notificacion

  print("Handling a background message: ${message.messageId}");
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _localNotifications = FlutterLocalNotificationsPlugin();
  @override
  void initState() {
    if (Platform.isAndroid) {
      _configureFMCListener();
    } else {}
    _configureLocalNotifications();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'School Calendar',
      initialRoute: '/login',
      routes: {
        "/splash": (context) => Splash2(),
        "/calendar": (context) => HomePage(),
        "/login": (context) => Login(),
        "/signin": (context) => Signin(),
        "/signup": (context) => Signup(),
        "/eventDetail": (context) => EventDetails(),
        "/addEvent": (context) => AddEvent(),
        "/eventPage": (context) => EventPage(),
        "/tarea": (context) => Tarea(),
        "/clases": (context) => Clases(),
        "/calificaciones": (context)=> Calificaciones(),
      },
    );
  }

  void _configureFMCListener() async {
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage msg) {
        if (msg.notification != null) {
          print("Titulo: ${msg.notification.title}");
          print("Subtitulo: ${msg.notification.body}");
          _showNotifications(
            msg.notification.title,
            msg.notification.body,
          );
        }
      },
    );

    String fcmToken = await FirebaseMessaging.instance.getToken();
    print("TOKEN FCM >>> $fcmToken");
  }

  void _configureLocalNotifications() {
    var androidConfig = AndroidInitializationSettings("@mipmap/ic_launcher");
    var iOSConfig = IOSInitializationSettings();
    var initSettings = InitializationSettings(
      android: androidConfig,
      iOS: iOSConfig,
    );
    _localNotifications.initialize(initSettings);
  }

  _showNotifications(String titulo, String mensaje) async {
    var androidChannels = AndroidNotificationDetails(
      "myChannelId",
      "myChannelName",
      "Channel de notificaciones",
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
    );
    var iosDetails = IOSNotificationDetails();
    var platformDetails = NotificationDetails(
      android: androidChannels,
      iOS: iosDetails,
    );
    await _localNotifications.show(0, titulo, mensaje, platformDetails);
  }
}
