// import 'package:calendario/calendar/event_page.dart';
import 'package:calendario/constants.dart';
import 'package:calendario/menu/menu.dart';
import 'package:calendario/models/event.dart';
import 'package:calendario/tareas_clases/bloc/tareasclases_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

final Map<DateTime, List> _holidays = {
  DateTime(2020, 1, 1): ['New Year\'s Day'],
  DateTime(2020, 1, 6): ['Epiphany'],
  DateTime(2020, 2, 14): ['Valentine\'s Day'],
  DateTime(2020, 4, 21): ['Easter Sunday'],
  DateTime(2020, 4, 22): ['Easter Monday'],
};

class Clases extends StatefulWidget {
  Clases({Key key}) : super(key: key);

  @override
  _ClasesState createState() => _ClasesState();
}

class _ClasesState extends State<Clases> with TickerProviderStateMixin {
  AnimationController _animationController;
  List _selectedEvents;
  CalendarController _calendarController;
  Map<DateTime, List> _events = {};
  DateTime _currentDate;

  @override
  void initState() {
    DateTime newDate = DateTime.now();
    DateTime _currentDate = newDate.subtract(Duration(
      hours: newDate.hour,
      minutes: newDate.minute,
      seconds: newDate.second,
      milliseconds: newDate.millisecond,
      microseconds: newDate.microsecond,
    ));
    _events = {};
    // _events[_currentDate.add(Duration(days: 1))] = ["entrega 1"];
    _selectedEvents = _events[_currentDate] ?? [];
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();

    super.initState();
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  @override
  Widget build(BuildContext context) {
    var ctx = context;
    return Scaffold(
      backgroundColor: Color(0xff1F2125),
      appBar: AppBar(
        title: Text("Clases y Tareas"),
        backgroundColor: Color(0xff212D40),
      ),
      body: BlocProvider(
          create: (context) => TareasclasesBloc()..add(GetAllEvent()),
          child: BlocConsumer<TareasclasesBloc, TareasclasesState>(
              listener: (context, state) {
            if (state is LoadAllState) {
              setState(() {
                _events = state.eventos;
              });
            }
          }, builder: (context, state) {
            if (state is LoadingAllState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                children: [
                  _buildTableCalendarWithBuilders(),
                  const SizedBox(height: 8.0),
                  Expanded(child: _buildEventList()),
                ],
                mainAxisSize: MainAxisSize.max,
              );
            }
          })),
      drawer: Drawer(
        child: Menu(
          ctx: ctx,
        ),
      ),
    );
  }

  Widget _buildTableCalendarWithBuilders() {
    return TableCalendar(
      locale: "es_MX",
      calendarController: _calendarController,
      events: _events,
      holidays: _holidays,
      initialCalendarFormat: CalendarFormat.week,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {
        CalendarFormat.week: '',
      },
      calendarStyle: CalendarStyle(
        markersColor: color5,
        markersMaxAmount: 4,
        outsideDaysVisible: false,
        outsideStyle: TextStyle(color: Color(0xff37383D)),
        outsideWeekendStyle: TextStyle(
          color: Color(0xff37383D),
        ),
        weekendStyle: TextStyle(color: Color(0xffA9AAAD)),
        weekdayStyle: TextStyle(color: Colors.white),
        eventDayStyle: TextStyle(color: Colors.white),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: TextStyle(color: Color(0xff65696D)),
        weekdayStyle: TextStyle(color: Color(0xff99A0A6)),
      ),
      headerStyle: HeaderStyle(
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 22.69),
        leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
        rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
        centerHeaderTitle: true,
        formatButtonVisible: false,
      ),
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, _) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
            child: Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.only(top: 5.0, left: 6.0),
              color: Color(0xff353841),
              width: 100,
              height: 100,
              child: Text(
                '${date.day}',
                style:
                    TextStyle().copyWith(fontSize: 16.0, color: Colors.white),
              ),
            ),
          );
        },

        todayDayBuilder: (context, date, _) {
          return Container(
            margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.only(top: 5.0, left: 6.0),
            color: Color(0xff8BB4F8),
            width: 100,
            height: 100,
            child: Text(
              '${date.day}',
              style: TextStyle().copyWith(fontSize: 16.0),
            ),
          );
        },
        // markersBuilder: (context, date, events, holidays) {
        //   final children = <Widget>[];

        //   if (events.isNotEmpty) {
        //     children.add(
        //       Positioned(
        //         right: 1,
        //         bottom: 1,
        //         child: _buildEventsMarker(date, events),
        //       ),
        //     );
        //   }

        //   if (holidays.isNotEmpty) {
        //     children.add(
        //       Positioned(
        //         right: -2,
        //         top: -2,
        //         child: _buildHolidaysMarker(),
        //       ),
        //     );
        //   }

        //   return children;
        // },
      ),
      onDaySelected: (date, events, holidays) {
        _onDaySelected(date, events, holidays);
        _animationController.forward(from: 0.0);
      },
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: _calendarController.isSelected(date)
            ? Color(0xff5DB5C1)
            : _calendarController.isToday(date)
                ? Color(0xff5DB5C1)
                : Color(0xff5DB5C1),
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.add_box,
      size: 20.0,
      color: Colors.blueGrey[800],
    );
  }

  Widget _buildEventList() {
    return ListView(
        children: _selectedEvents.map((event) {
      Map<String, dynamic> e = event;
      if (e.containsKey("claseid")) {
        return _buildHWcontainer(e);
      } else {
        return _buildClassContainer(e);
      }
    }).toList());
  }

  Widget _buildHWcontainer(Map<String, dynamic> event) {
    List horaList = event["hora"].split(":");
    TimeOfDay time =
        TimeOfDay(hour: int.parse(horaList[0]), minute: int.parse(horaList[1]));
    return Container(
      decoration: BoxDecoration(
        // border: Border.all(width: 0.8),
        // color: Color(0xff5DB5C1),
        borderRadius: BorderRadius.circular(5.0),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ListTile(
        leading: Icon(
          Icons.assignment,
          size: 40,
          color: color5,
        ),
        title: Text('${event["clase"]}',
            style: TextStyle(
              color: color5,
            )),
        subtitle: Text('Fecha limite hoy a las ${time.format(context)}',
            style: TextStyle(color: Colors.white, fontSize: 16)),
        onTap: () {
          // print("${e.titulo}, ${e.descripcion}");
          Navigator.of(context).pushNamed("/tarea", arguments: event);
        }, //Redirecciona a nuevo widget el cual cuenta con los detalles del evento de ese día
      ),
    );
  }

  Widget _buildClassContainer(Map<String, dynamic> event) {
    List horaList = event["hora"].split(":");
    TimeOfDay time =
        TimeOfDay(hour: int.parse(horaList[0]), minute: int.parse(horaList[1]));
    return Container(
      decoration: BoxDecoration(
        // border: Border.all(width: 0.8),
        // color: Color(0xff5DB5C1),
        borderRadius: BorderRadius.circular(5.0),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ListTile(
        leading: Icon(
          Icons.calendar_today_outlined,
          size: 40,
          color: color5,
        ),
        title: Text('${event["nombre"]}', style: TextStyle(color: color5)),
        subtitle: Text('CLASE COMIENZA A LAS ${time.format(context)}',
            style: TextStyle(color: Colors.white, fontSize: 15)),
        onTap: () {
          // print("${e.titulo}, ${e.descripcion}");
          // Navigator.of(context).pushNamed("/tarea", arguments: event);
        }, //Redirecciona a nuevo widget el cual cuenta con los detalles del evento de ese día
      ),
    );
  }
}
