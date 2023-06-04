import '../../../../core/common/logger.dart';

String calculateZodiac(int year) {
  const zodiacList = [
    'Monkey',
    'Rooster',
    'Dog',
    'Pig',
    'Rat',
    'Ox',
    'Tiger',
    'Rabbit',
    'Dragon',
    'Snake',
    'Horse',
    'Sheep'
  ];
  logger.i(year);
  return zodiacList[(year - 1924) % 12];
}

String getZodiac(int month, int day) {
  switch (month) {
    case 1:
      return day < 20 ? 'Capricorn' : 'Aquarius';
    case 2:
      return day < 19 ? 'Aquarius' : 'Pisces';
    case 3:
      return day < 21 ? 'Pisces' : 'Aries';
    case 4:
      return day < 20 ? 'Aries' : 'Taurus';
    case 5:
      return day < 21 ? 'Taurus' : 'Gemini';
    case 6:
      return day < 21 ? 'Gemini' : 'Cancer';
    case 7:
      return day < 23 ? 'Cancer' : 'Leo';
    case 8:
      return day < 23 ? 'Leo' : 'Virgo';
    case 9:
      return day < 23 ? 'Virgo' : 'Libra';
    case 10:
      return day < 23 ? 'Libra' : 'Scorpio';
    case 11:
      return day < 22 ? 'Scorpio' : 'Sagittarius';
    case 12:
      return day < 22 ? 'Sagittarius' : 'Capricorn';
    default:
      return '';
  }
}

String removeEmailDomain(String email) {
  int atIndex = email.indexOf('@');
  String username = atIndex != -1 ? email.substring(0, atIndex) : email;
  return username;
}
