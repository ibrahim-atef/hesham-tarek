import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesham_tarek/core/text_styles.dart';
import 'package:hesham_tarek/features/courses/presentation/views/course_view.dart';
import 'package:hesham_tarek/features/home/data/models/course_list/course_list.dart';
import 'package:hesham_tarek/generated/l10n.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class CoursesAndSeeAll extends StatelessWidget {
  final List<CourseList> courseList;
  const CoursesAndSeeAll({
    super.key,
    required this.courseList,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              S.of(context).Courses,
              style: TextStyles.semiNormalBlack17,
            ),
            ElevatedButton(
              style: const ButtonStyle(
                  elevation: WidgetStatePropertyAll(0),
                  backgroundColor: WidgetStatePropertyAll(Colors.transparent)),
              onPressed: () {
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: CourseView(courseList: courseList),
                  withNavBar: false,
                  pageTransitionAnimation: PageTransitionAnimation.fade,
                );
              },
              child: Row(
                children: [
                  Text(
                    "${S.of(context).See} ${S.of(context).All}",
                    style: TextStyles.mediumBlue17,
                  ),
                  SizedBox(width: 8.w),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 20,
                    color: Theme.of(context).colorScheme.tertiary,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
