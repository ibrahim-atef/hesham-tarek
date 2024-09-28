import 'package:dartz/dartz.dart';
import 'package:hesham_tarek/core/failures.dart';

abstract class CreateUserRepo {
  Future<Either<Failures, dynamic>> createUser(
      String username, password, phoneNumber, email, imei);
}
