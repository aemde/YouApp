import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youapp_test/core/platform/key_local_storage.dart';

void main() {
  group('KeyLocalStorage Test', () {
    late KeyLocalStorage keyLocalStorage;

    setUp(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
      SharedPreferences.setMockInitialValues({});
      keyLocalStorage = KeyLocalStorage();
    });

    test('Read Auth Storage Test', () async {
      await runZonedGuarded(() async {
        final sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString('userId', '12345');

        final result = await keyLocalStorage.readAuthStorage('userId');

        expect(result, '12345');
      }, (error, stackTrace) {
        fail('An error occurred: $error');
      });
    });

// ...

    test('Write Auth Storage Test', () async {
      await runZonedGuarded(() async {
        final sharedPreferences = await SharedPreferences.getInstance();

        await keyLocalStorage.writeAuthStorage('userId', '12345');
        final storedValue = sharedPreferences.getString('userId');

        expect(storedValue, '12345');
      }, (error, stackTrace) {
        fail('An error occurred: $error');
      });
    });

    test('Delete Auth Storage Test', () async {
      await runZonedGuarded(() async {
        final sharedPreferences = await SharedPreferences.getInstance();

        sharedPreferences.setString('userId', '12345');
        await keyLocalStorage.deleteAuthStorage('userId');
        final storedValue = sharedPreferences.getString('userId');

        expect(storedValue, isNull);
      }, (error, stackTrace) {
        fail('An error occurred: $error');
      });
    });

// ...
  });
}
