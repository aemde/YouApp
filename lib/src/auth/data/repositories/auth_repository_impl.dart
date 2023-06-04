import 'package:dartz/dartz.dart';

import 'package:youapp_test/core/error/failure.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRemoteDataSource remoteDataSource;
  NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, String>> login({
    required String email,
    required String password,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteAddAddress = await remoteDataSource.login(
          email: email,
          password: password,
        );
        return Right(remoteAddAddress);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.msg));
      }
    } else {
      return Left(CacheFailure('cache error'));
    }
  }

  @override
  Future<Either<Failure, String>> register({
    required String email,
    required String name,
    required String password,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteAddAddress = await remoteDataSource.register(
          email: email,
          name: name,
          password: password,
        );
        return Right(remoteAddAddress);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.msg));
      }
    } else {
      return Left(CacheFailure('cache error'));
    }
  }
}
