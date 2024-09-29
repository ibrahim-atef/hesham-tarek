import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesham_tarek/core/text_styles.dart';
import 'package:hesham_tarek/features/home/data/models/course_list/course_list.dart';
import 'package:hesham_tarek/features/my_courses/bloc/cubit/course_detail_cubit.dart';
import 'package:hesham_tarek/features/my_courses/presentation/views/course_details_view.dart';
import 'package:hesham_tarek/generated/l10n.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class ContentButton extends StatelessWidget {
  final CourseList courseList;
  const ContentButton({
    super.key,
    required this.courseList,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context
            .read<CourseDetailCubit>()
            .getCourseDetails(courseList.id.toString());
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: CourseDetailsView(courseList: courseList),
          withNavBar: false,
          pageTransitionAnimation: PageTransitionAnimation.fade,
        );
      },
      child: Container(
        height: 130.h,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color(0x1A000000),
              offset: Offset(0, 2),
              blurRadius: 2,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 114.h,
                width: 114.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                        image: NetworkImage(
                            'http://adlink2019-001-site58.etempurl.com/lessonimg/${courseList.id}.jpg'))),
              ),
            ),
            Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            courseList.name ?? "",
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ),
                        // IconButton(
                        //     onPressed: () {},
                        //     icon: const Icon(Icons.favorite_border_rounded))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${courseList.price?.toString()} EGP",
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF22C55E),
                                    fontWeight: FontWeight.w500),
                              ),
                              const Text(
                                "4000 EGP",
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: 14,
                                    color: Colors.black45),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            child: ElevatedButton(
                              onPressed: () {
                                context
                                    .read<CourseDetailCubit>()
                                    .getCourseDetails(courseList.id.toString());
                                PersistentNavBarNavigator.pushNewScreen(
                                  context,
                                  screen:
                                      CourseDetailsView(courseList: courseList),
                                  withNavBar: false,
                                  pageTransitionAnimation:
                                      PageTransitionAnimation.fade,
                                );
                              },
                              child: Text(
                                courseList.isBought == true
                                    ? S.of(context).ViewCourse
                                    : S.of(context).Subscribe,
                                style: TextStyles.semiNormalBlack15,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
