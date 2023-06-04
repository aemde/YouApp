import 'package:equatable/equatable.dart';

class RegisterState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialRegisterState extends RegisterState {}

class SuccesRegisterState extends RegisterState {
  final String msg;

  SuccesRegisterState(this.msg);
}

class LoadingRegisterState extends RegisterState {}

class FailureRegisterState extends RegisterState {
  final String msg;

  FailureRegisterState(this.msg);
}

class ObscureTextState extends RegisterState {
  final bool obscureText;

  ObscureTextState(this.obscureText);

  @override
  List<Object?> get props => [obscureText];
}
