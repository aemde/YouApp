import 'package:flutter_test/flutter_test.dart';
import 'package:youapp_test/core/error/exceptions.dart';

void main() {
  group('ServerException', () {
    test('should create an instance with the provided message', () {
      final exception = ServerException('Server error occurred');
      expect(exception.msg, 'Server error occurred');
    });
  });

  group('NetworkException', () {
    test('should create an instance with the default message', () {
      final exception = NetworkException();
      expect(exception.message, 'Network Exception');
    });

    test('should create an instance with the provided message', () {
      final exception = NetworkException(message: 'Connection timed out');
      expect(exception.message, 'Connection timed out');
    });

    test('should have correct string representation', () {
      final exception = NetworkException(message: 'Connection error');
      expect(exception.toString(), 'NetworkException: Connection error');
    });
  });
}
