import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hesham_tarek/features/home/data/models/course_list/course_list.dart';
import 'package:hesham_tarek/features/home/data/repos/course_repo.dart';

part 'course_list_state.dart';

class CourseListCubit extends Cubit<CourseListState> {
  final CourseRepo courseRepo;
  CourseListCubit(this.courseRepo) : super(CourseListInitial());

  Future<void> getCourseList(String userID) async {
    emit(CourseListLoading());
    var result = await courseRepo.fetchCourses(userID);
    result.fold((failure) {
      emit(CourseListFailure(failure.errMessage));
    }, (courseList) {
      emit(CourseListSuccess(courseList));
    });
  }
}
