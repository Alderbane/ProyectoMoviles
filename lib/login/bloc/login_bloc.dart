import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'login_event.dart';
part 'login_state.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is SigninEmailEvent) {
      try {
        yield LoginLoadingState();
        await _auth.signInWithEmailAndPassword(
            email: event.email, password: event.password);
        yield LoginSuccessState();
      } catch (e) {
        print(e.toString());
        yield LoginErrorState(error: "Error al hacer login: ${e.toString()}");
      }
    } else if (event is SignUpEvent) {
      try {
        yield LoginLoadingState();
        var credential = await _auth.createUserWithEmailAndPassword(email: event.email, password: event.password);
        await credential.user.updateProfile(displayName: event.name);
        print(credential.user);
        yield LoginSuccessState();
      } catch (e) {
        print(e.toString());
        yield LoginErrorState(error: "Error al hacer login: ${e.toString()}");
      }
    }
  }
}
