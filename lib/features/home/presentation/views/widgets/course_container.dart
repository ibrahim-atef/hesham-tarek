import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hesham_tarek/core/text_styles.dart';
import 'package:hesham_tarek/features/home/data/models/course_list/course_list.dart';
import 'package:hesham_tarek/features/my_courses/bloc/cubit/course_detail_cubit.dart';
import 'package:hesham_tarek/features/my_courses/presentation/views/course_details_view.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class CourseContainer extends StatelessWidget {
  final String image;
  final String text;
  final String status;
  final CourseList courseList;
  const CourseContainer({
    super.key,
    required this.image,
    required this.courseList,
    required this.text,
    required this.status,
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
      child: SizedBox(
        width: 114.w,
        child: Column(
          children: [
            Container(
              height: 114.h,
              width: 114.w,
              decoration: BoxDecoration(
                  border:
                      Border.all(color: const Color(0xff2C4649), width: 1.5),
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(image), fit: BoxFit.cover),
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Color(0xff2C4649), Colors.transparent],
                      stops: [0.0, 0.5]),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: 4.h, left: 2.w, right: 2.w, top: 2.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (courseList.price == 0)
                            (SvgPicture.asset('assets/icons/free_icon.svg'))
                          else
                            (const SizedBox()),
                          GestureDetector(
                            child: const Icon(
                              Icons.favorite_outline,
                              color: Colors.red,
                            ),
                            onTap: () {},
                          )
                        ],
                      ),
                      Text(
                        status,
                        style: TextStyles.light17,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Text(
              text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyles.normalBlack16,
              textAlign: TextAlign.center,
            ),
            Text(
              "${courseList.price}EGP",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF22C55E),
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const Text(
              "4000 EGP",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  fontSize: 14,
                  color: Colors.black38,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
