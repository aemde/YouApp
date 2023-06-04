import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/io_client.dart';
import 'package:youapp_test/src/auth/domain/usecases/get_register.dart';

import 'core/platform/network_info.dart';
import 'src/auth/data/datasources/auth_remote_data_source.dart';
import 'src/auth/data/repositories/auth_repository_impl.dart';
import 'src/auth/domain/repositories/auth_repository.dart';
import 'src/auth/domain/usecases/get_login.dart';
import 'src/auth/presentation/cubit/login/login_cubit.dart';
import 'src/auth/presentation/cubit/register/register_cubit.dart';

final locator = GetIt.instance;

// GetIt locator = GetIt.instance();
void init(HttpClient httpClient) {
  locator.registerFactory(() => LoginCubit(locator()));
  locator.registerFactory(() => RegisterCubit(locator()));

  // usecases
  locator.registerLazySingleton(() => GetLogin(locator()));
  locator.registerLazySingleton(() => GetRegister(locator()));

  // repository
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      networkInfo: locator(),
      remoteDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
            client: locator(),
          ));

  // helper
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(
        locator(),
      ));

  // external
  locator.registerLazySingleton(() => IOClient(httpClient));
  locator.registerLazySingleton(() => DataConnectionChecker());

  // Registrasi objek/factory yang diperlukan di GetIt
  locator.registerSingleton<Connectivity>(Connectivity());
}
