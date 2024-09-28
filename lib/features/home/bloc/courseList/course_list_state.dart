part of 'course_list_cubit.dart';

sealed class CourseListState extends Equatable {
  const CourseListState();

  @override
  List<Object> get props => [];
}

final class CourseListInitial extends CourseListState {}

final class CourseListLoading extends CourseListState {}

final class CourseListSuccess extends CourseListState {
  final List<CourseList> courseList;
  const CourseListSuccess(this.courseList);
}

final class CourseListFailure extends CourseListState {
  final String errMessage;
  const CourseListFailure(this.errMessage);
}
