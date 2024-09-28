part of 'course_detail_cubit.dart';

sealed class CourseDetailState extends Equatable {
  const CourseDetailState();

  @override
  List<Object> get props => [];
}

final class CourseDetailInitial extends CourseDetailState {}

final class CourseDetailLoading extends CourseDetailState {}

final class CourseDetailFailure extends CourseDetailState {
  final String errMessage;
  const CourseDetailFailure(this.errMessage);
}

final class CourseDetailSuccess extends CourseDetailState {
  final CourseDetail courseDetail;
  const CourseDetailSuccess(this.courseDetail);
}
