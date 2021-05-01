import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:calendario/auth/user_auth_provider.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'login_event.dart';
part 'login_state.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
var credential;

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());
  // static final LoginBloc _logBloc = LoginBloc._internal();

  // factory LoginBloc() {
  //   return _logBloc;
  // }
  // LoginBloc._internal() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is VerifyLoginEvent) {
      if (UserAuthProvider().isAlreadyLogged()) {
        print("Si tiene sesion");
        yield AlreadyLoggedState();
      } else {
        print("No tiene sesion");
        yield NotLoggedState();
      }
    }
  }
}
