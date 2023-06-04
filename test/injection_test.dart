import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:youapp_test/core/platform/network_info.dart';
import 'package:youapp_test/injection.dart';
import 'package:youapp_test/src/auth/data/datasources/auth_remote_data_source.dart';
import 'package:youapp_test/src/auth/domain/repositories/auth_repository.dart';
import 'package:youapp_test/src/auth/domain/usecases/get_login.dart';
import 'package:youapp_test/src/auth/domain/usecases/get_register.dart';
import 'package:youapp_test/src/auth/presentation/cubit/login/login_cubit.dart';
import 'package:youapp_test/src/auth/presentation/cubit/register/register_cubit.dart';
import 'dart:io';

void main() {
  group('Dependency Injection Tests', () {
    late GetIt locator;

    setUp(() {
      locator = GetIt.instance;
      final httpClient = HttpClient(); // Mock HttpClient object for testing
      init(httpClient);
    });

    test('Verify Dependency Registration', () {
      // Get the registered instances from the GetIt locator
      final loginCubit = locator<LoginCubit>();
      final registerCubit = locator<RegisterCubit>();
      final getLoginUseCase = locator<GetLogin>();
      final getRegisterUseCase = locator<GetRegister>();
      final authRepository = locator<AuthRepository>();
      final authRemoteDataSource = locator<AuthRemoteDataSource>();
      final networkInfo = locator<NetworkInfo>();
      final dataConnectionChecker = locator<DataConnectionChecker>();
      final connectivity = locator<Connectivity>();

      // Verify that the dependencies are registered correctly
      expect(loginCubit, isA<LoginCubit>(),
          reason: 'LoginCubit should be registered');
      expect(registerCubit, isA<RegisterCubit>(),
          reason: 'RegisterCubit should be registered');
      expect(getLoginUseCase, isA<GetLogin>(),
          reason: 'GetLogin use case should be registered');
      expect(getRegisterUseCase, isA<GetRegister>(),
          reason: 'GetRegister use case should be registered');
      expect(authRepository, isA<AuthRepository>(),
          reason: 'AuthRepository should be registered');
      expect(authRemoteDataSource, isA<AuthRemoteDataSource>(),
          reason: 'AuthRemoteDataSource should be registered');
      expect(networkInfo, isA<NetworkInfo>(),
          reason: 'NetworkInfo should be registered');
      expect(dataConnectionChecker, isA<DataConnectionChecker>(),
          reason: 'DataConnectionChecker should be registered');
      expect(connectivity, isA<Connectivity>(),
          reason: 'Connectivity should be registered');
    });
  });
}
