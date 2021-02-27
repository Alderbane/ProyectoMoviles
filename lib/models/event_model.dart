class Evento {
  DateTime fecha;
  String titulo;
  String descripcion;
  String hora;

  Evento({
    this.fecha,
    this.titulo,
    this.descripcion,
    this.hora,
  }) {}

  bool isAllDay() {
    return this.hora == "Todo el día";
  }
}
