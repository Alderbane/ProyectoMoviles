import 'package:flutter/material.dart';

void main() => runApp(Login());

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inicio de Sesión',
      home: Scaffold(
        
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff212D40),Color(0xff1F2125)],
              ),
            ),
          child: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 100,),
               new Image.asset('assets/images/calendar_icon.png',scale: 2,color: Color(0xff8BB4F8),),
                SizedBox(height: 100,),
                MaterialButton(
                  minWidth: 310,
                  height: 46,
                  color: Color(0xff5DB5C1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/signup');
                  },
                  child: Text('REGISTRATE',style: TextStyle(fontFamily: 'AkzidenzGrotesk'),),
                ),
                SizedBox(height: 40,),
                MaterialButton(
                  minWidth: 310,
                  height: 46,
                  color: Color(0xff5DB5C1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/signin');
                  },
                  child: Text('INGRESA',style: TextStyle(fontFamily: 'AkzidenzGrotesk'),),
                ),
                SizedBox(height: 80,)

              ],
            ),
          ),
        ),
      ),
    );
  }
}
