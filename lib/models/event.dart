import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'event.g.dart';

@HiveType(typeId: 0, adapterName: "CalendarAdapter")
class Evento {
  @HiveField(0)
  DateTime fecha;
  @HiveField(1)
  String titulo;
  @HiveField(2)
  String descripcion;
  @HiveField(3)
  String hora;

  Evento({
    @required this.fecha,
    @required this.titulo,
    @required this.descripcion,
    @required this.hora,
  });

  bool isAllDay() {
    return this.hora == "Todo el día";
  }
}
