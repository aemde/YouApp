import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repositories/auth_repository.dart';

class GetRegister {
  final AuthRepository repository;

  GetRegister(this.repository);

  Future<Either<Failure, String>> execute({
    required String name,
    required String email,
    required String password,
  }) {
    return repository.register(
      email: email,
      name: name,
      password: password,
    );
  }
}
