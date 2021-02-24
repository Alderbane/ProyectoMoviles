import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static Widget _eventIcon = new Container(
    decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: Colors.blue, width: 2.0)),
    child: new Icon(
      Icons.person,
      color: Colors.amber,
    ),
  );
  DateTime _currentDate = DateTime.now();

  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {
      new DateTime(2021, 2, 25): [
        new Event(
          date: new DateTime(2021, 2, 25),
          title: 'Event 1',
          icon: _eventIcon,
          dot: Container(
            margin: EdgeInsets.symmetric(horizontal: 1.0),
            color: Colors.red,
            height: 5.0,
            width: 5.0,
          ),
        ),
      ]
    },
  );

  CalendarCarousel _calendarCarousel, _calendarCarouselNoHeader;

  @override
  void initState() {
    // TODO: implement initState
    _markedDateMap.add(
        new DateTime(2021, 2, 27),
        new Event(
          date: new DateTime(2021, 2, 27),
          title: 'La entrega fallada :\'v',
          icon: Icon(Icons.favorite),
        ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _calendarCarousel = CalendarCarousel<Event>(
      onDayPressed: (DateTime date, List<Event> events) {
        print(_markedDateMap.events);
        this.setState(() => _currentDate = date);
        events.forEach((event) => print(event.title));
      },
      weekendTextStyle: TextStyle(
        color: Colors.red,
      ),
      thisMonthDayBorderColor: Colors.grey,
//          weekDays: null, /// for pass null when you do not want to render weekDays
      markedDatesMap: _markedDateMap,
      height: 400.0,
      showIconBehindDayText: true,
//          daysHaveCircularBorder: false, /// null for not rendering any border, true for circular border, false for rectangular border
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateShowIcon: true,
      markedDateIconMaxShown: 2,
      selectedDayTextStyle: TextStyle(
        color: Colors.yellow,
      ),
      todayTextStyle: TextStyle(
        color: Colors.blue,
      ),
      markedDateIconBuilder: (event) {
        return event.icon;
      },
      // minSelectedDate: _currentDate.subtract(Duration(days: 360)),
      // maxSelectedDate: _currentDate.add(Duration(days: 360)),
      onDayLongPressed: (day) {},
      todayButtonColor: Colors.transparent,
      todayBorderColor: Colors.green,
      markedDateMoreShowTotal:
          true, // null for not showing hidden events indicator
//          markedDateIconMargin: 9,
//          markedDateIconOffset: 3,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Cosa"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          child: _calendarCarousel,
        ),
      ),
    );
  }
}
