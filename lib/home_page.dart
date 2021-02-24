import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static Widget _eventIcon = Padding(
    padding: EdgeInsets.only(top: 20, left:10,right:10),
    child: Container(
    height: 2,
    width: 2,
    alignment: Alignment.bottomCenter,
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.all(Radius.circular(1000)),
      border: Border.all(color: Colors.blue, width: 1),
    ),
  ));
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
    // _markedDateMap.add(
    //     new DateTime(2021, 2, 27),
    //     new Event(
    //       date: new DateTime(2021, 2, 27),
    //       title: 'La entrega fallada :\'v',
    //       icon: Icon(Icons.favorite),
    //     ));
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
      weekdayTextStyle: TextStyle(color: Color(0xff99A0A6)),
      thisMonthDayBorderColor: Colors.white60,
//          weekDays: null, /// for pass null when you do not want to render weekDays
      markedDatesMap: _markedDateMap,
      height: 400.0,
      showIconBehindDayText: true,
//          daysHaveCircularBorder: false, /// null for not rendering any border, true for circular border, false for rectangular border
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateShowIcon: true,
      markedDateIconMaxShown: 2,
      selectedDayTextStyle: TextStyle(color: Colors.yellow),
      todayTextStyle: TextStyle(color: Colors.black),
      markedDateIconBuilder: (event) {
        return event.icon;
      },
      // minSelectedDate: _currentDate.subtract(Duration(days: 360)),
      // maxSelectedDate: _currentDate.add(Duration(days: 360)),
      onDayLongPressed: (day) {},
      todayButtonColor: Color(0xff3770D3),
      todayBorderColor: Color(0xff3770D3),
      prevDaysTextStyle: TextStyle(color: Color(0xff37383D)),
      nextDaysTextStyle: TextStyle(color: Color(0xff37383D)),
      daysTextStyle: TextStyle(color: Colors.white),
      weekendTextStyle: TextStyle(color: Color(0xffA9AAAD)),
      headerTextStyle: TextStyle(color: Colors.white, fontSize: 20.0),
      iconColor: Colors.white,
      daysHaveCircularBorder: false,
      markedDateMoreShowTotal:
          true, // null for not showing hidden events indicator
//          markedDateIconMargin: 9,
//          markedDateIconOffset: 3,
    );
    return Scaffold(
      backgroundColor: Color(0xff303135),
      appBar: AppBar(
        title: Text("Calendario"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          color: Color(0xff303135),
          child: _calendarCarousel,
        ),
      ),
    );
  }
}
