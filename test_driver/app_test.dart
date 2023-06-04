import 'package:flutter_driver/flutter_driver.dart';
// ignore: depend_on_referenced_packages
import 'package:test/test.dart';

void main() {
  group('Splash Screen and Login Test', () {
    FlutterDriver? driver;

    // Set up Flutter Driver before running the tests
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the Flutter Driver connection after all the tests are finished
    tearDownAll(() async {
      if (driver != null) {
        driver!.close();
      }
    });

    test('Splash screen delay', () async {
      // Ensure that the splash screen appears
      final splashScreenFinder = find.byType('SplashScreenPage');
      await driver!.waitFor(splashScreenFinder);

      // Wait for 1.5 seconds
      await Future.delayed(const Duration(milliseconds: 1500));

      // Ensure that the splash screen disappears
      expect(
        driver!.waitFor(splashScreenFinder).catchError((error) {
          return;
        }),
        false,
      );
    });

    test('Login with email and password', () async {
      // Enter email and password
      final emailTextFieldFinder = find.byValueKey('email_text_field');
      final passwordTextFieldFinder = find.byValueKey('password_text_field');
      final loginButtonFinder = find.byValueKey('login_button');

      await driver!.tap(emailTextFieldFinder);
      await driver!.enterText('sanderanastitiw5@gmail.com'); // user not found

      await driver!.tap(passwordTextFieldFinder);
      await driver!.enterText('wrong_password');

      // Wait for a while to see the login result
      await Future.delayed(const Duration(seconds: 1));

      // Tap the login button
      await driver!.tap(loginButtonFinder);

      // Wait for a while to see the login result
      await Future.delayed(const Duration(seconds: 3));

      // Tap the button to show the ErrorDialog
      final showDialogButtonFinder = find.byValueKey('error_dialog');
      await driver!.tap(showDialogButtonFinder);

      // Wait until the ErrorDialog appears
      await driver!.waitFor(find.byValueKey('error_dialog'));

      // Tap the close button on the ErrorDialog
      final closeButtonFinder = find.byValueKey('close_button');
      await driver!.tap(closeButtonFinder);

      // Ensure that the ErrorDialog is closed
      await driver!.waitForAbsent(find.byValueKey('error_dialog'));

      // Second Test
      await driver!.tap(emailTextFieldFinder);
      await driver!.enterText('sanderanastitiw4@gmail.com');

      await driver!.tap(passwordTextFieldFinder);
      await driver!.enterText('wrong_password');

      // Wait for a while to see the login result
      await Future.delayed(const Duration(seconds: 1));

      // Tap the login button
      await driver!.tap(loginButtonFinder);

      // Wait for a while to see the login result
      await Future.delayed(const Duration(seconds: 3));

      // Tap the button to show the ErrorDialog
      await driver!.tap(showDialogButtonFinder);

      // Wait until the ErrorDialog appears
      await driver!.waitFor(find.byValueKey('error_dialog'));

      // Tap the close button on the ErrorDialog
      await driver!.tap(closeButtonFinder);

      // Ensure that the ErrorDialog is closed

      // Third Test
      await driver!.tap(emailTextFieldFinder);
      await driver!.enterText('sanderanastitiw4@gmail.com');

      await driver!.tap(passwordTextFieldFinder);
      final toggleButtonFinder = find.byValueKey('toggle_button');

      // Wait for a while to see the login result
      await Future.delayed(const Duration(seconds: 1));

      // Toggle obsecure text
      await driver!.tap(toggleButtonFinder);
      await driver!.enterText('12345678');

      // Wait for a while to see the login result
      await Future.delayed(const Duration(seconds: 2));

      // Tap the login button
      await driver!.tap(loginButtonFinder);

      // Wait for a while to see the login result
      await Future.delayed(const Duration(seconds: 4));
    });
  });
}
