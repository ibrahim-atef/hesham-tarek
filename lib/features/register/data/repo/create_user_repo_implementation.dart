import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hesham_tarek/core/failures.dart';
import 'package:hesham_tarek/core/utils/api_service.dart';
import 'package:hesham_tarek/features/register/data/models/new_user.dart';
import 'package:hesham_tarek/features/register/data/repo/create_user_repo.dart';

class CreateUserRepoImplementation implements CreateUserRepo {
  final ApiService apiService;
  CreateUserRepoImplementation(this.apiService);
  @override
  Future<Either<Failures, dynamic>> createUser(
      String username, password, phoneNumber, email, imei) async {
    try {
      NewUser user = NewUser(
          Id: 0,
          Username: phoneNumber,
          Password: password,
          Name: username,
          Phone1: phoneNumber,
          SchoolName: email,
          IMEIDesktopOnline: null,
          IMEI: imei);
      var data =
          await apiService.post(dotenv.env['createEndPoint']!, user.toJson());
      return right(data);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
