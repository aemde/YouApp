import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youapp_test/core/common/logger.dart';
import 'package:youapp_test/src/auth/domain/usecases/get_register.dart';

import '../../../../../core/error/failure.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  GetRegister register;
  late bool obscureText;

  RegisterCubit(this.register) : super(InitialRegisterState()) {
    obscureText = true;
  }
  void toggleObscureText() {
    obscureText = !obscureText;
    emit(ObscureTextState(obscureText));
  }

  void registerEvent({
    required String email,
    required String name,
    required String password,
  }) async {
    emit(LoadingRegisterState());

    final result = await register.execute(
      name: name,
      email: email,
      password: password,
    );

    logger.i(result);

    result.fold(
      (l) {
        if (l is ServerFailure) {
          emit(FailureRegisterState(l.msg));
        }
      },
      (r) {
        if (r == 'success') {
          emit(SuccesRegisterState(r));
        } else {
          emit(FailureRegisterState('Server Error'));
        }
        emit(ObscureTextState(true));
      },
    );
  }
}
