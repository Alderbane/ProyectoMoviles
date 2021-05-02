import 'package:calendario/calendar/bloc/calendar_bloc.dart';
import 'package:calendario/calendar/event_page.dart';
import 'package:calendario/menu/menu.dart';
import 'package:calendario/models/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';
import "package:collection/collection.dart";

final Map<DateTime, List> _holidays = {
  DateTime(2020, 1, 1): ['New Year\'s Day'],
  DateTime(2020, 1, 6): ['Epiphany'],
  DateTime(2020, 2, 14): ['Valentine\'s Day'],
  DateTime(2020, 4, 21): ['Easter Sunday'],
  DateTime(2020, 4, 22): ['Easter Monday'],
};

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  AnimationController _animationController;
  List _selectedEvents;
  CalendarController _calendarController;
  Map<DateTime, List> _events = {};
  DateTime _currentDate;
  DateTime selectedDate;

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
    selectedDate = day;
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
        title: Text("Calendario"),
        backgroundColor: Color(0xff212D40),
      ),
      body: BlocProvider(
        create: (context) => CalendarBloc()..add(DownloadEvent()),
        child: BlocBuilder<CalendarBloc, CalendarState>(
          builder: (context, state) {
            if (state is CalendarLoadedState) {
              _events = groupBy(state.eventos, (obj) => obj.fecha);
              return Column(
                children: [
                  _buildTableCalendarWithBuilders(),
                  const SizedBox(height: 8.0),
                  Expanded(child: _buildEventList()),
                ],
                mainAxisSize: MainAxisSize.max,
              );
            } else if (state is CalendarInitial) {
              CalendarBloc().add(LoadEvent());
            }
            // else if (state is CalendarEditState) {
            //   List eventList = [];
            //   _events.forEach((key, value) {
            //     value.forEach((element) {
            //       eventList.add(element);
            //     });
            //   });

            //   CalendarBloc().add(UpdateEvent(eventos: eventList));
            // }

            return Column(
              children: [
                _buildTableCalendarWithBuilders(),
                const SizedBox(height: 8.0),
                Expanded(child: _buildEventList()),
              ],
              mainAxisSize: MainAxisSize.max,
            );
          },
        ),
      ),
      // body: Column(
      //   children: [
      //     _buildTableCalendarWithBuilders(),
      //     const SizedBox(height: 8.0),
      //     // _buildButtons(),
      //     // const SizedBox(height: 8.0),

      //     Expanded(child: _buildEventList()),
      //   ],
      //   mainAxisSize: MainAxisSize.max,
      // ),
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
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {
        CalendarFormat.month: '',
      },
      calendarStyle: CalendarStyle(
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
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];

          if (events.isNotEmpty) {
            children.add(
              Positioned(
                right: 1,
                bottom: 1,
                child: _buildEventsMarker(date, events),
              ),
            );
          }

          if (holidays.isNotEmpty) {
            children.add(
              Positioned(
                right: -2,
                top: -2,
                child: _buildHolidaysMarker(),
              ),
            );
          }

          return children;
        },
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
    List<Widget> list = _selectedEvents.map((event) {
      Evento e = event;
      return Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.8),
          color: Color(0xff5DB5C1),
          borderRadius: BorderRadius.circular(5.0),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: ListTile(
          title: Text(e
              .titulo), //Este texto contendrá el título del evento en un objeto relacionado con la variable _events
          onTap: () {
            print("${e.titulo}, ${e.descripcion}");

            // Evento e = Evento(
            //   titulo: "Entrega 1",
            //   descripcion: "Primera entrega de web",
            //   fecha: DateTime(2021, 02, 26),
            //   hora: "Todo el día",
            // );
            Navigator.of(context).pushNamed("/eventDetail", arguments: e);
          }, //Redirecciona a nuevo widget el cual cuenta con los detalles del evento de ese día
        ),
      );
    }).toList();
    list.add(
      Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.8),
          color: Color(0xff5DB5C1),
          borderRadius: BorderRadius.circular(5.0),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: ListTile(
          title: Text("+ Agregar evento"),
          onTap: () => Navigator.of(context).pushNamed("/addEvent",
              arguments:
                  selectedDate), //Genera un dialog el cual recibe el día en el que fue seleccionado agregar evento, en este se puede cambiar el día del mismo y agregar los detalles a fondo sobre este
        ),
      ),
    );
    return ListView(children: list);
  }
}
