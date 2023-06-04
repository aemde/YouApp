import 'package:mockito/annotations.dart';
import 'package:youapp_test/src/auth/domain/usecases/get_login.dart';
import 'package:youapp_test/src/auth/domain/usecases/get_register.dart';

@GenerateMocks([
  GetLogin,
  GetRegister,
])
void main() {}
