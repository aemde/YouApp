import 'package:http/io_client.dart';
import 'package:mockito/annotations.dart';
import 'package:youapp_test/core/platform/network_info.dart';
import 'package:youapp_test/src/auth/data/datasources/auth_remote_data_source.dart';
import 'package:youapp_test/src/auth/domain/repositories/auth_repository.dart';

@GenerateMocks([
  AuthRepository,
  AuthRemoteDataSource,
  NetworkInfo
], customMocks: [
  // MockSpec<http.Client>(as: #MockHttpClient)
  MockSpec<IOClient>(as: #MockIOClient)
])
void main() {}
