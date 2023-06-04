import 'package:flutter_test/flutter_test.dart';
import 'package:youapp_test/src/auth/presentation/cubit/register/register_state.dart';

void main() {
  group('RegisterState', () {
    test('should have correct props', () {
      final state1 = InitialRegisterState();
      final state2 = SuccesRegisterState('Success!');
      final state3 = LoadingRegisterState();
      final state4 = FailureRegisterState('Error');
      final state5 = ObscureTextState(true);

      expect(state1.props, equals([]));
      expect(state2.props, equals([]));
      expect(state3.props, equals([]));
      expect(state4.props, equals([]));
      expect(state5.props, equals([true]));
    });

    test('should be equatable', () {
      final state1 = SuccesRegisterState('Success!');
      final state2 = SuccesRegisterState('Success!');
      final state3 = FailureRegisterState('Error');
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
