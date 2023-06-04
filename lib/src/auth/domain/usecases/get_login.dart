import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repositories/auth_repository.dart';

class GetLogin {
  final AuthRepository repository;

  GetLogin(this.repository);

  Future<Either<Failure, String>> execute({
    required String email,
    required String password,
  }) {
    return repository.login(
      email: email,
      password: password,
    );
  }
}
