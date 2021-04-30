import 'package:calendario/calendar/bloc/calendar_bloc.dart';
import 'package:calendario/models/event.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../constants.dart';

// void main() =>
//     initializeDateFormatting('esMX', null).then((_) => runApp(EventPage()));

class EventPage extends StatefulWidget {
  EventPage({Key key}) : super(key: key);

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  CalendarBloc calendarBloc = CalendarBloc();
  var _titleController = TextEditingController();
  var _descController = TextEditingController();
  DateTime _dateController;
  Evento event;
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  TimeOfDay selectedTime = TimeOfDay(hour: 0, minute: 0);
  bool _isAllDay;
  bool flag = false;
  @override
  Widget build(BuildContext context) {
    event = ModalRoute.of(context).settings.arguments;

    // Data controllers
    if (!flag) {
      _titleController.text = event.titulo ?? "";
      _descController.text = event.descripcion ?? "";
      _dateController = event.fecha;
      if (event.hora != "Todo el día") {
        List horaList = event.hora.split(":");
        selectedTime = TimeOfDay(
            hour: int.parse(horaList[0]), minute: int.parse(horaList[1]));
      }
      flag = !flag;
    }

    _isAllDay = (_isAllDay == null) ? event.isAllDay() : _isAllDay;
    return Scaffold(
      appBar: AppBar(
        key: _scaffoldKey,
        title: Text("Editar Evento"),
        backgroundColor: Color(0xff212D40),
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                if (_titleController.text.isEmpty) {
                  _scaffoldKey.currentState
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                      backgroundColor: color2,
                      content: Text(
                        "Titulo no puede estar vacio",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ));
                  return;
                }
                event.titulo = _titleController.text;
                event.descripcion = _descController.text;
                event.fecha = _dateController;
                event.hora = _isAllDay
                    ? "Todo el día"
                    : '${selectedTime.hour}:${selectedTime.minute}';
                calendarBloc.add(UpdateEvent(evento: event));
                // calendarBloc.add(SaveEvent(
                //     evento: Evento(
                //         fecha: DateTime.now(),
                //         titulo: "Test",
                //         descripcion: "Test 2",
                //         hora: "08:00")));
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              })
        ],
      ),
      backgroundColor: Color(0xff1F2125),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              style: TextStyle(fontSize: 25, color: Colors.grey[500]),
              cursorColor: Colors.grey[500],
              decoration: InputDecoration(
                hintText: "Titulo",
                hintStyle: TextStyle(color: Colors.grey[500]),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[500]),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[500]),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 35),
              ),
            ),
            TextField(
              controller: _descController,
              style: TextStyle(fontSize: 25, color: Colors.grey[500]),
              cursorColor: Colors.grey[500],
              decoration: InputDecoration(
                hintText: "Descripcion",
                hintStyle: TextStyle(color: Colors.grey[500]),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[500]),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[500]),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 35),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Todo el día",
                      style: TextStyle(color: Colors.grey[600])),
                  Switch(
                    value: _isAllDay,
                    onChanged: (value) {
                      setState(() {
                        _isAllDay = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 20),
                      child: Text(
                        '${new DateFormat.yMMMMEEEEd('es').format(event.fecha)}',
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ),
                    onTap: () {
                      _selectDate(context);
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 20),
                      child: Text(
                        _isAllDay ? '' : '${selectedTime.format(context)}',
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ),
                    onTap: () {
                      if (!_isAllDay) _selectTime(context);
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      currentDate: _dateController,
      context: context,
      initialDate: _dateController,
      firstDate: DateTime(2015),
      lastDate: DateTime(2050),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark(),
          child: child,
        );
      },
    );
    if (picked != null && picked != event.fecha)
      setState(() {
        print(picked);
        _dateController = picked;
      });
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark(),
          child: child,
        );
      },
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
      });
  }
}
