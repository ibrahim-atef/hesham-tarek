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
    context
        .read<CourseListCubit>()
        .getCourseList(UserData().user!.id.toString());
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
                    Text(state.errMessage),
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
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Column(
                    children: [
                      const HomeAppBar(),
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            SizedBox(
                              height: (145 * boughtCourses.length).h,
                              width: double.infinity,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  if (index < boughtCourses.length) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8.h, horizontal: 16.w),
                                      child: ViewCourseButton(
                                          courseList: boughtCourses[index]),
                                    );
                                  } else {
                                    return const SizedBox
                                        .shrink(); // Or handle the case where the index is out of bounds
                                  }
                                },
                                itemCount: state.courseList.length,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Positioned(
                  //   top: 117.h,
                  //   left: 16.w,
                  //   right: 16.w,
                  //   child: SizedBox(
                  //     height: 60.h,
                  //     child: const SearchFieldHome(),
                  //   ),
                  // ),
                ],
              ),
            );
          } else {
            return RefreshIndicator(
              onRefresh: _refreshData,
              child: SingleChildScrollView(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Column(
                      children: [
                        const HomeAppBar(),
                        SizedBox(
                          height: 500.h,
                          child: Center(
                              child: Text(
                                  S.of(context).Youdonthaveanyboughtcourses)),
                        ),
                        SizedBox(
                          height: 500.h,
                        )
                      ],
                    ),
                  ],
                ),
              ),
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
