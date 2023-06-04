import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
// import 'package:test/test.dart';
import 'package:youapp_test/global_bloc_observer.dart';

class MockBloc extends Mock implements BlocBase {}

// class MockTransition extends Mock implements Transition {}
// class MockTransition extends Mock implements Transition<dynamic, dynamic> {}

class MockLogger {
  void i(String message) {
    // print(message);
  }
}

void main() {
  late GlobalBlocObserver blocObserver;
  // late MockLogger logger;

  setUp(() {
    blocObserver = GlobalBlocObserver();
    // logger = MockLogger();
  });

  group('GlobalBlocObserver', () {
    // test('should log onEvent', () {
    //   final bloc = Bloc<dynamic, dynamic>;
    //   final event = 'Event';

    //   blocObserver.onEvent(bloc, event);
    // });

    test('should log onChange', () {
      final bloc = MockBloc();
      const oldState = 'old';
      const newState = 'new';
      const change = Change(currentState: oldState, nextState: newState);

      blocObserver.onChange(bloc, change);
    });

    // test('should log onTransition', () {
    //   final bloc = MockBloc();
    //   final transition = MockTransition();

    //   when(() => bloc.runtimeType).thenReturn('MockBloc');

    //   blocObserver.onTransition(bloc, transition);

    //   verify(() => logger.i('MockBloc $transition')).called(1);
    // });

    test('should log onError', () {
      final bloc = MockBloc();
      const error = 'Error';
      final stackTrace = StackTrace.current;

      blocObserver.onError(bloc, error, stackTrace);
    });
  });
}
