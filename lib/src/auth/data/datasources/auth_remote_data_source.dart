import 'dart:convert';
import 'dart:io';

import 'package:http/io_client.dart';

import '../../../../core/common/logger.dart';
import '../../../../core/common/urls.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/platform/key_local_storage.dart';

abstract class AuthRemoteDataSource {
  Future<String> register({
    required String email,
    required String name,
    required String password,
  });

  Future<String> login({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final IOClient client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<String> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await client.get(Uri.parse(YouAppUrls.login(
        email: email,
        password: password,
      )));

      final responseBody = response.body;
      final parsedResponse = json.decode(responseBody);

      logger.i(parsedResponse);

      if (parsedResponse['message'] == 'success') {
        await KeyLocalStorage().writeAuthStorage('email', email);
        return parsedResponse['message'];
      } else {
        final errorMessage = parsedResponse['message'] as String;
        throw ServerException(errorMessage);
      }
    } on ServerException catch (e) {
      throw ServerException(e.msg);
    } on SocketException {
      throw NetworkException();
    } catch (e) {
      throw NetworkException();
    }
  }

  @override
  Future<String> register({
    required String email,
    required String name,
    required String password,
  }) async {
    try {
      final response = await client.post(
        Uri.parse(YouAppUrls.register()),
        body: {
          "name": email,
          "email": email,
          "password": password,
        },
      );
      final responseBody = response.body;
      final parsedResponse = json.decode(responseBody);

      logger.i(responseBody);

      if (parsedResponse['message'] == 'success') {
        await KeyLocalStorage().writeAuthStorage('email', email);
        return parsedResponse['message'];
      } else {
        final errorMessage = parsedResponse['message'] as String;
        throw ServerException(errorMessage);
      }
    } on ServerException catch (e) {
      throw ServerException(e.msg);
    } on SocketException {
      throw NetworkException();
    } catch (e) {
      throw NetworkException();
    }
  }
}
