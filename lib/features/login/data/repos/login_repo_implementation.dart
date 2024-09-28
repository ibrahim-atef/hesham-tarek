import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hesham_tarek/core/failures.dart';
import 'package:hesham_tarek/core/utils/api_service.dart';
import 'package:hesham_tarek/features/login/data/models/login_model.dart';
import 'package:hesham_tarek/features/login/data/repos/login_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepoImplementation implements LoginRepo {
  final ApiService apiService;
  LoginRepoImplementation(this.apiService);
  @override
  Future<Either<Failures, LoginModel>> fetchUser(
      String username, password, imei) async {
    try {
      var data = await apiService.get(dotenv.env['loginEndPoint']!,
          'username=$username&password=$password&imei=$imei');
      return right(LoginModel.fromJson(data));
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<void> saveUserCredentials(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('password', password);
  }

  @override
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('password');
  }

  @override
  Future<Map<String, String>?> getUserCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
    final password = prefs.getString('password');
    if (username != null && password != null) {
      return {'username': username, 'password': password};
    }
    return null;
  }
}
