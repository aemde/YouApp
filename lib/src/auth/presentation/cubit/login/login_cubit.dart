import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failure.dart';
import '../../../domain/usecases/get_login.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  GetLogin login;
  late bool obscureText;

  LoginCubit(this.login) : super(InitialLoginState()) {
    obscureText = true;
  }

  void toggleObscureText() {
    obscureText = !obscureText;
    emit(ObscureTextState(obscureText));
  }

  void loginEvent({
    required String email,
    required String password,
  }) async {
    emit(LoadingLoginState());

    final result = await login.execute(
      email: email,
      password: password,
    );

    result.fold(
      (l) {
        if (l is ServerFailure) {
          emit(FailureLoginState(l.msg));
        }
      },
      (r) {
        if (r == 'success') {
          emit(SuccessLoginState(r));
        } else {
          emit(FailureLoginState('Server Error'));
        }
        emit(ObscureTextState(true));
      },
    );
  }
}
