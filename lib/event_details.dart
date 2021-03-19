import 'package:calendario/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'models/event_model.dart';

void main() =>
    initializeDateFormatting('esMX', null).then((_) => runApp(EventDetails()));

class EventDetails extends StatefulWidget {
  EventDetails({Key key}) : super(key: key);

  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  Evento event;

  @override
  Widget build(BuildContext context) {
    event = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Evento"),
        backgroundColor: Color(0xff212D40),
        actions: [
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                print("Entrar a edicion");
                Navigator.of(context).pushNamed("/eventPage", arguments: event);
              })
        ],
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
              Text(
                event.titulo,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut vitae sodales mauris. Cras velit turpis, euismod ut dignissim at, tincidunt nec ante. Donec sed consequat enim. Nam ut massa vel ex condimentum fringilla. Integer nec aliquet neque. Maecenas a quam a ligula blandit lacinia. Vivamus placerat arcu sed urna porta, quis faucibus nunc volutpat. Ut vel auctor dui, ut dignissim augue. Ut pulvinar facilisis velit sit amet pellentesque. Quisque ac congue orci. Etiam cursus sed arcu in rutrum. Sed lectus metus, fermentum nec iaculis eu, commodo in sapien. Pellentesque non feugiat tellus. Etiam luctus, enim a tincidunt finibus, magna diam gravida purus, eget interdum neque arcu a ante.",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 25,
                ),
                child: Text(
                  '${new DateFormat.yMMMMEEEEd('es').format(event.fecha)}, ${event.isAllDay() ? event.hora : "a las" + event.hora}',
                  style: TextStyle(color: Colors.grey[500]),
                ),
              )
            ],
          ),
        ),
      ),
      backgroundColor: color1,
    );
  }
}
