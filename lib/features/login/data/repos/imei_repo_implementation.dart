import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hesham_tarek/core/failures.dart';
import 'package:hesham_tarek/core/utils/api_service.dart';
import 'package:hesham_tarek/features/login/data/models/imei.dart';
import 'package:hesham_tarek/features/login/data/repos/imei_repo.dart';

class ImeiRepoImplementation implements ImeiRepo {
   final ApiService apiService;

  ImeiRepoImplementation(this.apiService);
  @override
  Future<Either<Failures, String>> updateImei(Imei imei)async {
    try{
      var data = await apiService.post(dotenv.env['imeiEndPoint']!, imei.toJson());
      return right(data);
    }catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

}
