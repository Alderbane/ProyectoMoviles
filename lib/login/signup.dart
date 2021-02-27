import 'package:flutter/material.dart';

void main() => runApp(Signup());

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool _isHidden = true;
  bool _checkBoxValue = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registro',
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff212D40), Color(0xff1F2125)],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Image.network(
                      'https://lh3.googleusercontent.com/proxy/f7AuVYmeD0RSLa0b-qFYTlgQUkqSNNWEdNdE8JwzWr_hEmi5rn07_aSyVaWrwTVKIT_h8_4xy6PQ9qB-vQNGKcMAT9FFkAXQxzaHGBw_PeYIpXdcwHh1xvLKldQ',
                      scale: 3,
                      color: Color(0xff88B4F5),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Nombre Completo:',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          height: 46,
                          child: TextField(
                            style: TextStyle(
                              height: 1,
                            ),
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.all(Radius.zero)),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Email:',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          height: 46,
                          child: TextField(
                            style: TextStyle(
                              height: 2,
                            ),
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.all(Radius.zero)),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Password:',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          height: 46,
                          child: TextField(
                            obscureText: _isHidden,
                            style: TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              fillColor: Colors.transparent,
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.all(Radius.zero)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.all(Radius.zero)),
                              suffix: InkWell(
                                onTap: () {
                                  setState(() {
                                    _isHidden = !_isHidden;
                                  });
                                },
                                child: Icon(
                                  Icons.visibility_off,
                                  color: Color(0xffBCB0A1),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Theme(
                          data: Theme.of(context).copyWith(
                              unselectedWidgetColor: Color(0xff5DB5C1)),
                          child: Checkbox(
                              value: _checkBoxValue,
                              onChanged: (bool _newValue) {
                                setState(() {
                                  _checkBoxValue = _newValue;
                                });
                              },
                              activeColor: Color(0xff5DB5C1),
                              checkColor: Colors.transparent),
                        ),
                        Column(
                          children: [
                            Text('ACEPTO LOS TÉRMINOS Y CONDICIONES DE USO',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FlatButton(
                      minWidth: 310,
                      height: 46,
                      color: Color(0xff5DB5C1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed('/');
                      },
                      child: Text(
                        'REGISTRATE',
                        style: TextStyle(fontFamily: 'AkzidenzGrotesk'),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        Text('¿Ya tienes una cuenta?',
                            style: TextStyle(color: Colors.white)),
                        SizedBox(
                          height: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacementNamed('/signin');
                          },
                          child: Text(
                            'INGRESA',
                            style: TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
