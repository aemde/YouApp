import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:youapp_test/src/auth/domain/usecases/get_login.dart';
import 'package:youapp_test/src/auth/presentation/cubit/login/login_cubit.dart';
import 'package:youapp_test/src/auth/presentation/cubit/login/login_state.dart';

class MockGetLogin extends Mock implements GetLogin {}

void main() {
  late LoginCubit loginCubit;
  late MockGetLogin mockGetLogin;

  setUp(() {
    mockGetLogin = MockGetLogin();
    loginCubit = LoginCubit(mockGetLogin);
  });

  group('LoginCubit', () {
    // const email = 'test@example.com';
    // const password = 'password';

    test('initial state should be InitialLoginState', () {
      expect(loginCubit.state, equals(InitialLoginState()));
    });

    test('toggleObscureText should toggle the obscureText value', () {
      // Initial value is true
      expect(loginCubit.obscureText, isTrue);

      // Call toggleObscureText
      loginCubit.toggleObscureText();

      // Value should be false after toggle
      expect(loginCubit.obscureText, isFalse);

      // Call toggleObscureText again
      loginCubit.toggleObscureText();

      // Value should be true after toggle again
      expect(loginCubit.obscureText, isTrue);
    });
  });
}
