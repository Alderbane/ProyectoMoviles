import 'package:calendario/calendar/bloc/calendar_bloc.dart';
import 'package:calendario/calendar/event_page.dart';
import 'package:calendario/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/event.dart';

class EventDetails extends StatefulWidget {
  final Evento evento;
  EventDetails({Key key, @required this.evento}) : super(key: key);

  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  Evento event;

  @override
  Widget build(BuildContext context) {
    event = widget.evento;
    // event = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Evento"),
        backgroundColor: Color(0xff212D40),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              CalendarBloc().add(DeleteEvent(evento: event));
              Navigator.of(context).pop();
            },
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => EventPage(evento: event,)));
            },
          ),
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
                  event.descripcion,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 25,
                ),
                child: Text(
                  '${new DateFormat.yMMMMEEEEd('es').format(event.fecha)}, ${event.isAllDay() ? event.hora : "a las " + event.hora}',
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
