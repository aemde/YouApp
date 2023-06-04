import 'package:flutter_test/flutter_test.dart';
import 'package:youapp_test/src/auth/presentation/cubit/login/login_state.dart';

void main() {
  group('LoginState', () {
    test('should have correct props', () {
      final state1 = InitialLoginState();
      final state2 = SuccessLoginState('Success!');
      final state3 = LoadingLoginState();
      final state4 = FailureLoginState('Error');
      final state5 = ObscureTextState(true);

      expect(state1.props, equals([]));
      expect(state2.props, equals([]));
      expect(state3.props, equals([]));
      expect(state4.props, equals([]));
      expect(state5.props, equals([true]));
    });

    test('should be equatable', () {
      final state1 = SuccessLoginState('Success!');
      final state2 = SuccessLoginState('Success!');
      final state3 = FailureLoginState('Error');
      final state4 = ObscureTextState(true);

      expect(state1 == state2, isTrue);
      expect(state1.hashCode == state2.hashCode, isTrue);

      expect(state1 == state3, isFalse);
      expect(state1.hashCode == state3.hashCode, isFalse);

      expect(state1 == state4, isFalse);
      expect(state1.hashCode == state4.hashCode, isFalse);
    });
  });
}
