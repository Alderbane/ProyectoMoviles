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
  var _titleController = TextEditingController();
  var _descController = TextEditingController();
  Evento event;
  TimeOfDay selectedTime = TimeOfDay(hour: 0, minute: 0);
  bool _isAllDay;

  @override
  Widget build(BuildContext context) {
    event = ModalRoute.of(context).settings.arguments;
    _titleController.text = event.titulo;
    _descController.text = event.descripcion;
    print(_isAllDay);
    _isAllDay = (_isAllDay == null)?event.isAllDay(): _isAllDay;
    // TimeOfDay(hour:int.parse(event.hora.split(":")[0]),minute: int.parse(event.hora.split(":")[1]));
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Evento"),
        backgroundColor: Color(0xff212D40),
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                print("se guarda la cosa");
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
                        '${selectedTime.format(context)}',
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ),
                    onTap: () {
                      _selectTime(context);
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
      currentDate: event.fecha,
      context: context,
      initialDate: event.fecha,
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
        event.fecha = picked;
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
