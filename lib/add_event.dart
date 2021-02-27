import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() =>
    initializeDateFormatting('es_MX', null).then((_) => runApp(AddEvent()));

class AddEvent extends StatefulWidget {
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  String dateTime;

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
          backgroundColor: Color(0xff1F2125),
          body: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                              icon: Icon(Icons.cancel, color: Colors.grey[500]),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: MaterialButton(
                          child: Text("Guardar",
                              style: TextStyle(color: Colors.white)),
                          color: Color(0xff5DB5C1),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                TextField(
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
                Row(
                  children: [
                    Expanded(
                      flex:3,
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
          )),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      currentDate: selectedDate,
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
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
