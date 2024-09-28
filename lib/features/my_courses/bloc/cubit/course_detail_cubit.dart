import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hesham_tarek/features/my_courses/data/models/course_detail/course_detail.dart';
import 'package:hesham_tarek/features/my_courses/data/repo/course_detail_repo.dart';

part 'course_detail_state.dart';

class CourseDetailCubit extends Cubit<CourseDetailState> {
  final CourseDetailRepo courseDetailRepo;
  CourseDetailCubit(this.courseDetailRepo) : super(CourseDetailInitial());
  Future<void> getCourseDetails(String courseID) async {
    emit(CourseDetailLoading());
    var result = await courseDetailRepo.fetchCourseDetails(courseID);
    result.fold((failure) {
      emit(CourseDetailFailure(failure.errMessage));
    }, (courseDetail) {
      emit(CourseDetailSuccess(courseDetail));
    });
  }
}
