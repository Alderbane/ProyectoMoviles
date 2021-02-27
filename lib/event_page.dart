import 'package:calendario/models/event_model.dart';
import 'package:flutter/material.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() =>
    initializeDateFormatting('esMX', null).then((_) => runApp(EventPage()));

class EventPage extends StatefulWidget {
  EventPage({Key key}) : super(key: key);

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    final Evento event = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("${event.titulo}"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Text("Descripcion"),
            Text("${event.descripcion}"),
            Text("Fecha"),
            Text(
              '${new DateFormat.yMMMMEEEEd('es').format(event.fecha)}',
              style: TextStyle(color: Colors.grey[500]),
            ),
            Text("Hora"),
            Text("${event.hora}"),
          ],
        ),
      ),
    );
  }
}
