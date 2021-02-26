import 'package:flutter/material.dart';

void main() => runApp(AddEvent());

class AddEvent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
          backgroundColor: Color(0xff1F2125),
          body: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.cancel, color: Colors.grey[500]),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    SizedBox(
                      width: 260,
                    ),
                    MaterialButton(
                      child: Text("Guardar",
                          style: TextStyle(color: Colors.white)),
                      color: Color(0xff5DB5C1),
                      onPressed: () {},
                    ),
                  ],
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
                    contentPadding: EdgeInsets.symmetric(horizontal:35),
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
                    contentPadding: EdgeInsets.symmetric(horizontal:35),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
