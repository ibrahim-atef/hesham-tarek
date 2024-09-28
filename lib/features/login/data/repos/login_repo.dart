import 'package:dartz/dartz.dart';
import 'package:hesham_tarek/core/failures.dart';
import 'package:hesham_tarek/features/login/data/models/login_model.dart';

abstract class LoginRepo {
  Future<Either<Failures, LoginModel>> fetchUser(
      String username, password, imei);
  Future<void> saveUserCredentials(String username, String password);
  Future<void> logout();
  Future<Map<String, String>?> getUserCredentials();
}
