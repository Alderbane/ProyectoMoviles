import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';

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
    _events = {
      _currentDate.subtract(Duration(days: 30)): [
        'Event A0',
        'Event B0',
        'Event C0'
      ],
      _currentDate.subtract(Duration(days: 27)): ['Event A1'],
      _currentDate.subtract(Duration(days: 20)): [
        'Event A2',
        'Event B2',
        'Event C2',
        'Event D2'
      ],
      _currentDate.subtract(Duration(days: 16)): ['Event A3', 'Event B3'],
      _currentDate.subtract(Duration(days: 10)): [
        'Event A4',
        'Event B4',
        'Event C4'
      ],
      _currentDate.subtract(Duration(days: 4)): [
        'Event A5',
        'Event B5',
        'Event C5'
      ],
      _currentDate.subtract(Duration(days: 2)): ['Event A6', 'Event B6'],
      _currentDate: ['Event A7', 'Event B7', 'Event C7', 'Event D7'],
      _currentDate.add(Duration(days: 1)): [
        'Event A8',
        'Event B8',
        'Event C8',
        'Event D8'
      ],
      _currentDate.add(Duration(days: 3)):
          Set.from(['Event A9', 'Event A9', 'Event B9']).toList(),
      _currentDate.add(Duration(days: 7)): [
        'Event A10',
        'Event B10',
        'Event C10'
      ],
      _currentDate.add(Duration(days: 11)): ['Event A11', 'Event B11'],
      _currentDate.add(Duration(days: 17)): [
        'Event A12',
        'Event B12',
        'Event C12',
        'Event D12'
      ],
      _currentDate.add(Duration(days: 22)): ['Event A13', 'Event B13'],
      _currentDate.add(Duration(days: 26)): [
        'Event A14',
        'Event B14',
        'Event C14'
      ],
    };
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
    return Scaffold(
      backgroundColor: Color(0xff1F2125),
      appBar: AppBar(
        title: Text("Calendario"),
      ),
      body: Column(
        children: [
          _buildTableCalendarWithBuilders(),
          const SizedBox(height: 8.0),
          // _buildButtons(),
          // const SizedBox(height: 8.0),
          Expanded(child: _buildEventList()),
        ],
        mainAxisSize: MainAxisSize.max,
      ),
    );
  }

  void _addEvent() {
    // print(_currentDate);
    // print(_currentDate.add(Duration(days: 1)));
    // print(_events.containsKey(_currentDate.add(Duration(days: 1))) == null);
    if (!_events.containsKey(_currentDate.add(Duration(days: 1)))) {
      _events[_currentDate.add(Duration(days: 1))] = ["entrega 1"];
    } else {
      _events.update(_currentDate.add(Duration(days: 1)), (value) {
        value.add("cosa fea");
        return value;
      });
    }
    print(_events);
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
        titleTextStyle: TextStyle(color: Colors.white,fontSize: 22.69),
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
    List<Widget> list = _selectedEvents
        .map((event) => Container(
              decoration: BoxDecoration(
                border: Border.all(width: 0.8),
                color: Color(0xff5DB5C1),
                borderRadius: BorderRadius.circular(5.0),
              ),
              margin:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: ListTile(
                title: Text(event
                    .toString()), //Este texto contendrá el título del evento en un objeto relacionado con la variable _events
                onTap: () => print("presionado"),//Redirecciona a nuevo widget el cual cuenta con los detalles del evento de ese día 
              ),
            ))
        .toList();
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
          onTap: () => Navigator.of(context).pushNamed("/addEvent"), //Genera un dialog el cual recibe el día en el que fue seleccionado agregar evento, en este se puede cambiar el día del mismo y agregar los detalles a fondo sobre este
        ),
      ),
    );
    return ListView(children: list);
  }
}
