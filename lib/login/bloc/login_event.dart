part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}
class SigninEmailEvent extends LoginEvent {
  final String email;
  final String password;

  SigninEmailEvent({@required this.email, @required this.password});
  @override
  List<Object> get props => [email, password];
}

class ForgotPasswordEvent extends LoginEvent {
  @override
  List<Object> get props => [];
}

class SignUpEvent extends LoginEvent {
  final String name;
  final String email;
  final String password;

  SignUpEvent({@required this.name, @required this.email, @required this.password});
  @override
  List<Object> get props => [name, email, password];
}
