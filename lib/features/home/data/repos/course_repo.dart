import 'package:dartz/dartz.dart';
import 'package:hesham_tarek/core/failures.dart';
import 'package:hesham_tarek/features/home/data/models/course_list/course_list.dart';

abstract class CourseRepo {
  Future<Either<Failures, List<CourseList>>> fetchCourses(String userID);
}
