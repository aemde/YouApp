import 'package:get/get.dart';

import '../../src/auth/presentation/pages/login_page.dart';
import '../../src/auth/presentation/pages/register_page.dart';
import '../../src/intro/splashscreen/splah_screen_page.dart';
import '../../src/profile/presentation/page/interest/page/interest_page.dart';
import '../../src/profile/presentation/page/profile/page/profile_page.dart';

class AppRoutes {
  static const String splash = '/';
  static const String signIn = '/signIn';
  static const String signUp = '/signUp';
  static const String profile = '/profile';
  static const String interest = '/interest';

  static List<GetPage> routes = [
    GetPage(
      name: splash,
      page: () => const SplashScreenPage(),
    ),
    GetPage(
      name: signIn,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: profile,
      page: () => ProfilePage(),
    ),
    GetPage(
      name: signUp,
      page: () => const RegisterPage(),
    ),
    GetPage(
      name: interest,
      page: () => const InterestPage(),
    ),
  ];
}
