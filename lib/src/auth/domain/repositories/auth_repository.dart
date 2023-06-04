import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> register({
    required String email,
    required String name,
    required String password,
  });

  Future<Either<Failure, String>> login({
    required String email,
    required String password,
  });
}
