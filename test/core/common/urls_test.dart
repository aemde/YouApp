import 'package:flutter_test/flutter_test.dart';
import 'package:youapp_test/core/common/urls.dart';

void main() {
  group('YouAppUrls Test', () {
    test('Login URL Test', () {
      const email = 'test@example.com';
      const password = 'password123';
      const expectedUrl =
          'http://techtest.youapp.ai/api/login?email=test@example.com&password=password123';

      final loginUrl = YouAppUrls.login(email: email, password: password);

      expect(loginUrl, expectedUrl);
    });

    test('Register URL Test', () {
      const expectedUrl = 'http://techtest.youapp.ai/api/register';

      final registerUrl = YouAppUrls.register();

      expect(registerUrl, expectedUrl);
    });

    test('Get Profile URL Test', () {
      const expectedUrl = 'http://techtest.youapp.ai/api/profile';

      final getProfileUrl = YouAppUrls.getProfile();

      expect(getProfileUrl, expectedUrl);
    });

    test('Update Profile URL Test', () {
      const expectedUrl = 'http://techtest.youapp.ai/api/profile';

      final updateProfileUrl = YouAppUrls.updateProfile();

      expect(updateProfileUrl, expectedUrl);
    });
  });
}
