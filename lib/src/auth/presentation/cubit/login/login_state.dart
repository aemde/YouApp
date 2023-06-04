import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialLoginState extends LoginState {}

class SuccessLoginState extends LoginState {
  final String msg;

  SuccessLoginState(this.msg);
}

class LoadingLoginState extends LoginState {}

class FailureLoginState extends LoginState {
  final String msg;

  FailureLoginState(this.msg);
}

class ObscureTextState extends LoginState {
  final bool obscureText;

  ObscureTextState(this.obscureText);

  @override
  List<Object?> get props => [obscureText];
}
