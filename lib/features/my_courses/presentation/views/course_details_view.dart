import 'package:flutter/material.dart';
import 'package:hesham_tarek/features/home/data/models/course_list/course_list.dart';
import 'package:hesham_tarek/features/my_courses/presentation/views/widgets/course_details_view_body.dart';
import 'package:hesham_tarek/generated/l10n.dart';

class CourseDetailsView extends StatelessWidget {
  final CourseList courseList;
  const CourseDetailsView({
    super.key,
    required this.courseList,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: courseList.isBought == false
          ? Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "/subscription");
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  height: 50,
                  child: Text(
                    S.of(context).SubscribetoseealltheVideos,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            )
          : const SizedBox.shrink(),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            )),
        title: Text(S.of(context).Course),
      ),
      body: CourseDetailsViewBody(courseList: courseList),
    );
  }
}
