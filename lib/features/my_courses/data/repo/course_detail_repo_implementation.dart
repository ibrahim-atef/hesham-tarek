import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hesham_tarek/core/failures.dart';
import 'package:hesham_tarek/core/utils/api_service.dart';
import 'package:hesham_tarek/features/my_courses/data/models/course_detail/course_detail.dart';
import 'package:hesham_tarek/features/my_courses/data/repo/course_detail_repo.dart';

class CourseDetailRepoImplementation implements CourseDetailRepo {
  final ApiService apiService;
  CourseDetailRepoImplementation(this.apiService);
  @override
  Future<Either<Failures, CourseDetail>> fetchCourseDetails(
      String courseID) async {
    try {
      var data = await apiService.get(
        dotenv.env['coursesEndPoint']!,
        'lessonId=$courseID&materialId=1&userId=4',
      ) as List<dynamic>;

      CourseDetail courseDetail = CourseDetail.fromJson(data[0]);
      return right(courseDetail);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
