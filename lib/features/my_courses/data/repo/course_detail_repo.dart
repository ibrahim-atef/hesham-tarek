import 'package:dartz/dartz.dart';
import 'package:hesham_tarek/core/failures.dart';
import 'package:hesham_tarek/features/my_courses/data/models/course_detail/course_detail.dart';

abstract class CourseDetailRepo {
  Future<Either<Failures, CourseDetail>> fetchCourseDetails(String courseID);
}
