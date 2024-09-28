import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesham_tarek/core/utils/service_locator.dart';
import 'package:hesham_tarek/features/home/bloc/courseList/course_list_cubit.dart';
import 'package:hesham_tarek/features/my_courses/presentation/views/widgets/view_course_button.dart';
import 'package:hesham_tarek/generated/l10n.dart';

import '../../../../home/presentation/views/widgets/home_app_bar.dart';

class MyCourseViewBody extends StatefulWidget {
  const MyCourseViewBody({super.key});

  @override
  State<MyCourseViewBody> createState() => _MyCourseViewBodyState();
}

class _MyCourseViewBodyState extends State<MyCourseViewBody> {
  @override
  void initState() {
    // context
    //     .read<CourseListCubit>()
    //     .getCourseList(UserData().user!.id.toString());
    super.initState();
  }

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
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Column(
                  children: [
                    const HomeAppBar(),
                    const Text("Something went wrong"),
                  ],
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
              child: ListView(
                // Make the whole content scrollable
                physics:
                    const AlwaysScrollableScrollPhysics(), // Always allow scroll to refresh
                children: [
                  const HomeAppBar(), // Make sure this is scrollable as well
                  ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    physics:
                        const BouncingScrollPhysics(), // Optional bounce effect
                    shrinkWrap:
                        true, // Make sure it takes the minimal required height
                    itemCount: boughtCourses.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child:
                            ViewCourseButton(courseList: boughtCourses[index]),
                      );
                    },
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Text("No courses found"),
            );
          }
        } else {
          return const Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                children: [
                  HomeAppBar(),
                  Center(child: CircularProgressIndicator())
                ],
              ),
            ],
          );
        }
      },
    );
  }
}
