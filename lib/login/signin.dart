import 'package:calendario/calendar/home_page.dart';
import 'package:flutter/material.dart';
import 'package:calendario/login/bloc/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(Signin());

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  LoginBloc _loginBloc = LoginBloc();
  bool _isHidden = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material App',
        home: Scaffold(
            resizeToAvoidBottomInset: true,
            body: BlocProvider(
              create: (context) => LoginBloc(),
              child: BlocListener<LoginBloc, LoginState>(
                child: SingleChildScrollView(
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
                              height: 30,
                            ),
                            new Image.asset(
                              'assets/images/calendar_icon.png',
                              scale: 3,
                              color: Color(0xff8BB4F8),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    'Correo Electronico:',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Container(
                                    height: 46,
                                    child: TextFormField(
                                      controller: emailController,
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
                                            borderRadius:
                                                BorderRadius.all(Radius.zero)),
                                      ),
                                      validator: (String value) {
                                        if (value.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        return null;
                                      },
                                    ),
                                  )
                                ],
                              ),
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
                                  child: TextFormField(
                                    controller: passwordController,
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
                                          borderRadius:
                                              BorderRadius.all(Radius.zero)),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                          ),
                                          borderRadius:
                                              BorderRadius.all(Radius.zero)),
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
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              minWidth: 330,
                              height: 46,
                              color: Color(0xff5DB5C1),
                              onPressed: () {
                                print(emailController.value.text);
                                print(passwordController.value.text);
                                if (_formKey.currentState.validate()) {
                                  _loginBloc.add(SigninEmailEvent(
                                      email: emailController.value.text,
                                      password: passwordController.value.text));
                                }
                              },
                              child: Text(
                                'ENTRAR',
                                style: TextStyle(fontFamily: 'AkzidenzGrotesk'),
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Column(
                              children: [
                                Text('¿Olvidaste tu password?',
                                    style: TextStyle(color: Colors.white)),
                                SizedBox(
                                  height: 90,
                                ),
                                Text('¿Aún no tienes cuenta?',
                                    style: TextStyle(color: Colors.white)),
                                SizedBox(
                                  height: 5,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushReplacementNamed('/signup');
                                  },
                                  child: Text(
                                    'REGÍSTRATE',
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
                listener: (context, state) {
                  if (state is LoginSuccessState) {
                    // Navigator.of(context).pushReplacementNamed('/');

                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return HomePage();
                    }), (Route<dynamic> route) => false);
                  }
                },
              ),
            )));
  }
}
