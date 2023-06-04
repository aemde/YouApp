const String baseUrl = 'http://techtest.youapp.ai';

class YouAppUrls {
  static String login({required String email, required String password}) {
    return '$baseUrl/api/login?email=$email&password=$password';
  }

  static String register() => '$baseUrl/api/register'; // use body

  /// ERROR
  static String getProfile() => '$baseUrl/api/profile'; // Error 404
  static String updateProfile() => '$baseUrl/api/profile'; // Error 404
}
