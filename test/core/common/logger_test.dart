import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';

void main() {
  test('Logger Test', () {
    final logger = Logger(
      printer: PrettyPrinter(),
    );

    logger.i('Info message');
    logger.d('Debug message');
    logger.w('Warning message');
    logger.e('Error message');
  });
}
