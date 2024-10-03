import 'package:flutter/material.dart';
import 'package:hesham_tarek/features/courses/presentation/views/widgets/course_view_body.dart';
import 'package:hesham_tarek/features/home/data/models/course_list/course_list.dart';
import 'package:hesham_tarek/generated/l10n.dart';

class CourseView extends StatelessWidget {
  final List<CourseList> courseList;
  const CourseView({super.key, required this.courseList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).Courses),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            )),
      ),
      body: CourseViewBody(courseList: courseList)
    );
  }
}
