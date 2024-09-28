import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hesham_tarek/core/failures.dart';
import 'package:hesham_tarek/core/utils/api_service.dart';
import 'package:hesham_tarek/features/home/data/models/course_list/course_list.dart';
import 'package:hesham_tarek/features/home/data/repos/course_repo.dart';

class CourseRepoImplementation implements CourseRepo {
  final ApiService apiService;
  CourseRepoImplementation(this.apiService);
  @override
  Future<Either<Failures, List<CourseList>>> fetchCourses(String userID) async {
    try {
      var data = await apiService.get(
        dotenv.env['coursesEndPoint']!,
        'lessonId=0&materialId=1&userId=$userID',
      ) as List<dynamic>;

      List<CourseList> courses =
          data.map((course) => CourseList.fromJson(course)).toList();
      return right(courses);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
