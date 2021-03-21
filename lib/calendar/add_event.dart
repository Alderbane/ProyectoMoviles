import 'package:calendario/constants.dart';
import 'package:calendario/models/event.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:calendario/calendar/bloc/calendar_bloc.dart';

class AddEvent extends StatefulWidget {
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  String dateTime;
  CalendarBloc calendarBloc = CalendarBloc();
  var _titleController = TextEditingController();
  var _descController = TextEditingController();
  DateTime selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  bool _isAllDay = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text("Agregar Evento"),
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
                  calendarBloc.add(
                    SaveEvent(
                      evento: Evento(
                        fecha: selectedDate,
                        titulo: _titleController.text,
                        descripcion: _descController.text,
                        hora: _isAllDay
                            ? "Todo el día"
                            : '${selectedTime.hour}:${selectedTime.minute}',
                      ),
                    ),
                  );
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
                          '${new DateFormat.yMMMMEEEEd('es').format(selectedDate)}',
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
                          _isAllDay
                              ? ''
                              : '${selectedTime.hour}:${selectedTime.minute}',
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
        ));
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      currentDate: selectedDate,
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015),
      lastDate: DateTime(2050),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark(),
          child: child,
        );
      },
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        print(picked);
        selectedDate = picked;
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
