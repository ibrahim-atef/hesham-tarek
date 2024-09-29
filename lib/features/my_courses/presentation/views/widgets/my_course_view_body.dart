import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesham_tarek/core/utils/service_locator.dart';
import 'package:hesham_tarek/features/home/bloc/courseList/course_list_cubit.dart';
import 'package:hesham_tarek/features/my_courses/presentation/views/widgets/view_course_button.dart';

import '../../../../home/presentation/views/widgets/home_app_bar.dart';

class MyCourseViewBody extends StatefulWidget {
  const MyCourseViewBody({super.key});

  @override
  State<MyCourseViewBody> createState() => _MyCourseViewBodyState();
}

class _MyCourseViewBodyState extends State<MyCourseViewBody> {
  var searchController = TextEditingController();

  Future<void> _refreshData() async {
    // Add your refresh logic here. For example, you can trigger a Bloc event
    context
        .read<CourseListCubit>()
        .getCourseList(UserData().user!.id.toString()); // Example refresh
    await Future.delayed(const Duration(seconds: 2)); // Simulate loading
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseListCubit, CourseListState>(
      builder: (context, state) {
        if (state is CourseListFailure) {
          return RefreshIndicator(
            onRefresh: _refreshData,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: const HomeAppBar()), // AppBar on top
                SliverFillRemaining(
                  child: Center(child: const Text("Something went wrong")),
                ),
              ],
            ),
          );
        }
        if (state is CourseListSuccess) {
          final boughtCourses = state.courseList
              .where((course) => course.isBought ?? false)
              .toList();

          if (boughtCourses.isNotEmpty) {
            return RefreshIndicator(
              onRefresh: _refreshData,
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                      child: const HomeAppBar()), // AppBar on top
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final course = boughtCourses[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 8.h),
                          child: ViewCourseButton(courseList: course),
                        );
                      },
                      childCount: boughtCourses.length,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: const HomeAppBar()), // AppBar on top
                SliverFillRemaining(
                  child: Center(child: const Text("No courses found")),
                ),
              ],
            );
          }
        } else {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: const HomeAppBar()), // AppBar on top
              SliverFillRemaining(
                child: Center(child: const CircularProgressIndicator()),
              ),
            ],
          );
        }
      },
    );
  }
}
