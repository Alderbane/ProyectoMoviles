import 'package:calendario/menu/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants.dart';
import 'bloc/calificaciones_bloc.dart';

class Calificaciones extends StatefulWidget {
  Calificaciones({Key key}) : super(key: key);

  @override
  _CalificacionesState createState() => _CalificacionesState();
}

class _CalificacionesState extends State<Calificaciones> {
  List _selectedEvents;
  @override
  Widget build(BuildContext context) {
    var ctx = context;
    return Scaffold(
      backgroundColor: Color(0xff1F2125),
      appBar: AppBar(
        title: Text("Calificaciones"),
        backgroundColor: Color(0xff212D40),
      ),
      body: BlocProvider(
        create: (context) =>
            CalificacionesBloc()..add(CalificacionesDownloadEvent()),
        child: BlocBuilder<CalificacionesBloc, CalificacionesState>(
          builder: (context, state) {
            if (state is CalificacionesLoadedState) {
              _selectedEvents = state.calificaciones;
              return Padding(
                padding: EdgeInsets.all(2),
                child: Column(
                  children: [Expanded(child: _buildEventList())],
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
      drawer: Drawer(
        child: Menu(
          ctx: ctx,
        ),
      ),
    );
  }

  Widget _buildEventList() {
    return ListView(
        children: _selectedEvents.map((event) {
      Map<String, dynamic> e = event;
      return Container(
        decoration: BoxDecoration(
          // border: Border.all(width: 0.8),
          // color: Color(0xff5DB5C1),
          borderRadius: BorderRadius.circular(5.0),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: ListTile(
          leading: Icon(
            Icons.assignment_turned_in,
            size: 40,
            color: color5,
          ),
          title: Text('${e["nombre"]}', style: TextStyle(color: color5)),
          subtitle: Text(
              'CALIFICACION: ${(e["calificacion"] != 0) ? e["calificacion"] : "N/A"}%',
              style: TextStyle(color: Colors.white, fontSize: 15)),
        ),
      );
    }).toList());
  }
}
