import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:calendario/auth/user_auth_provider.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  static final AuthBloc _authBloc = AuthBloc._internal();
  factory AuthBloc() {
    return _authBloc;
  }

  AuthBloc._internal() : super(AuthInitial());
  // atuh provider
  UserAuthProvider _authProvider = UserAuthProvider();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is VerifyAuthenticationEvent) {
      // requests a APIs
      // acceso a BD locales
      // revisar acceso a internet
      // lo que debamos hacer para inicializar datos de la app
      if (_authProvider.isAlreadyLogged())
        yield AlreadyAuthState();
      else
        yield UnAuthState();
    }
    else if(event is SignOutAuthenticationEvent) {
      await _authProvider.signOut();
      yield UnAuthState();
    }else if(event is SignInAuthenticationEvent){
      await UserAuthProvider().emailSignIn(event.user, event.password);
      yield AlreadyAuthState();
    }else if(event is GoToCalendarioEvent){
      yield GoToCalendarioState();
    }else if(event is GoToCalificacionesEvent){
      yield GoToCalificacionesState();
    }else if(event is GoToClasesEvent){
      yield GoToClasesState();
    }
  }
}
