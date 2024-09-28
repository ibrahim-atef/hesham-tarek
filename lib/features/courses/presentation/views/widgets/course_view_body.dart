// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesham_tarek/core/custom/content_button.dart';
import 'package:hesham_tarek/features/home/bloc/courseList/course_list_cubit.dart';
import 'package:hesham_tarek/features/home/data/models/course_list/course_list.dart';
import 'package:hesham_tarek/features/home/presentation/views/widgets/home_app_bar.dart';
import 'package:hesham_tarek/generated/l10n.dart';

class CourseViewBody extends StatefulWidget {
  final List<CourseList> courseList;
  const CourseViewBody({super.key, required this.courseList});

  @override
  State<CourseViewBody> createState() => _CourseViewBodyState();
}

class _CourseViewBodyState extends State<CourseViewBody> {
  List<String> items = ['All', 'Online', 'Offline', 'Hybrid', "Free"];
  int selectedIndex = 0;
  var searchController = TextEditingController();
  List<CourseList> filteredCourses = [];

  @override
  void initState() {
    super.initState();
    // Initialize filteredCourses with the complete course list
    filteredCourses = widget.courseList;
    // Add listener to update filteredCourses based on search input
    searchController.addListener(_filterCourses);
  }

  @override
  void dispose() {
    searchController.removeListener(_filterCourses);
    searchController.dispose();
    super.dispose();
  }

  void _filterCourses() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredCourses = widget.courseList.where((course) {
        bool matchesPrice = selectedIndex == 4 ? course.price == 0 : true;
        bool matchesSearch = course.name?.toLowerCase().contains(query) ??
            false; // Adjust as needed
        return matchesPrice && matchesSearch;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseListCubit, CourseListState>(
      builder: (context, state) {
        if (state is CourseListFailure) {
          return Column(
            children: [
              const HomeAppBar(),
              Text("Error"),
              Text(S.of(context).Somethingwentwrong),
            ],
          );
        } else if (state is CourseListSuccess) {
          return Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Column(
              children: [
                // Search Bar
                // Container(
                //   height: 50,
                //   decoration: BoxDecoration(
                //     color: Colors.grey[200],
                //     borderRadius: BorderRadius.circular(8.0),
                //     border: Border.all(color: Colors.grey[400]!),
                //   ),
                //   child: CustomTextField(
                //     hint: S.of(context).SearchCourses,
                //     controller: searchController,
                //   ),
                // ),
                // Filter Buttons
                // Container(
                //   margin: EdgeInsets.only(bottom: 12, top: 8),
                //   width: double.infinity,
                //   height: 40.h,
                //   child: ListView.builder(
                //     scrollDirection: Axis.horizontal,
                //     itemCount: items.length,
                //     itemBuilder: (context, index) {
                //       final item = items[index];
                //       return Container(
                //         padding: EdgeInsets.symmetric(horizontal: 5),
                //         margin: EdgeInsets.symmetric(vertical: 2),
                //         child: ElevatedButton(
                //           onPressed: () {
                //             setState(() {
                //               selectedIndex = index;
                //               _filterCourses(); // Update filtered courses when filter changes
                //             });
                //           },
                //           child: Text(
                //             item,
                //             style: GoogleFonts.openSans(
                //               color: selectedIndex == index
                //                   ? Colors.black
                //                   : Color(0xff2a2a2a),
                //               fontWeight: FontWeight.w400,
                //             ),
                //           ),
                //           style: ButtonStyle(
                //             backgroundColor: WidgetStateProperty.all(
                //               selectedIndex == index
                //                   ? Theme.of(context).colorScheme.primary
                //                   : Colors.white,
                //             ),
                //             shape: WidgetStateProperty.all(
                //               RoundedRectangleBorder(
                //                 borderRadius: BorderRadius.circular(10),
                //               ),
                //             ),
                //           ),
                //         ),
                //       );
                //     },
                //   ),
                // ),
                // Course List
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: ContentButton(
                          courseList: filteredCourses[index],
                        ),
                      );
                    },
                    itemCount: filteredCourses.length,
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
