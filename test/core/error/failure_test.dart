import 'package:flutter_test/flutter_test.dart';
import 'package:youapp_test/core/error/failure.dart';

void main() {
  group('ServerFailure', () {
    test('should create an instance with the provided message', () {
      final failure = ServerFailure('Server error occurred');
      expect(failure.msg, 'Server error occurred');
    });
  });

  group('CacheFailure', () {
    test('should create an instance with the provided message', () {
      final failure = CacheFailure('Cache error occurred');
      expect(failure.msg, 'Cache error occurred');
    });
  });
}
