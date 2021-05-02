
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
  @HiveField(4)
  int id;
  Evento({
    @required this.fecha,
    @required this.titulo,
    @required this.descripcion,
    @required this.hora,
    this.id,
  });

  bool isAllDay() {
    return this.hora == "Todo el día";
  }

  Map<String, dynamic> toMap() {
    return {
      'fecha': fecha,
      'titulo': titulo,
      'descripcion': descripcion,
      'hora': hora,
      'id': id
    };
  }

  static Evento fromMap(Map<String, dynamic> mp) {
    return Evento(
      titulo: mp['titulo'],
      descripcion: mp['descripcion'],
      fecha: DateTime.fromMicrosecondsSinceEpoch(
          mp['fecha'].microsecondsSinceEpoch),
      hora: mp['hora'],
      id: mp['id'],
    );
  }
}
