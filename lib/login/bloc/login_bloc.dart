import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'login_event.dart';
part 'login_state.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
var credential;

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  // LoginBloc() : super(LoginInitial());
  static final LoginBloc _booksRepository = LoginBloc._internal();

  factory LoginBloc() {
    return _booksRepository;
  }
  LoginBloc._internal() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is SigninEmailEvent) {
      try {
        yield LoginLoadingState();
        // await _auth.signInWithEmailAndPassword(
        //     email: event.email, password: event.password);
        credential = await _auth.signInWithEmailAndPassword(
            email: event.email, password: event.password);
        print(credential.user);
        yield LoginSuccessState();
      } catch (e) {
        print(e.toString());
        yield LoginErrorState(error: "Error al hacer login: ${e.toString()}");
      }
    } else if (event is SignUpEvent) {
      try {
        yield LoginLoadingState();
        credential = await _auth.createUserWithEmailAndPassword(
            email: event.email, password: event.password);
        await credential.user.updateProfile(displayName: event.name);
        print(credential.user);
        yield LoginSuccessState();
      } catch (e) {
        print(e.toString());
        yield LoginErrorState(error: "Error al hacer login: ${e.toString()}");
      }
    } else if (event is VerifyLoginEvent) {
      if (_auth.currentUser == null) {
        print("No tiene sesion");
        yield NotLoggedState();
      } else {
        print("Si tiene sesion");
        yield AlreadyLoggedState();
      }
    } else if (event is SignoutEvent) {
      await _auth.signOut();
      yield SignoutSuccessState();
    }
  }
}
