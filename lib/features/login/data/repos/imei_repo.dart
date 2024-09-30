import 'package:dartz/dartz.dart';
import 'package:hesham_tarek/core/failures.dart';
import 'package:hesham_tarek/features/login/data/models/imei.dart';

abstract class ImeiRepo {
  Future<Either<Failures, String>> updateImei(Imei imei);
}