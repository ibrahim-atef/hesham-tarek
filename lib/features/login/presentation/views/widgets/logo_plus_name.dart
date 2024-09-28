import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class LogoPlusName extends StatelessWidget {
  const LogoPlusName({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
      ),
      child: SizedBox(
        height: 55.h,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset('assets/images/logo_name.svg'),
            IconButton(
                onPressed: () {
                  // context.read<CourseListCubit>().getCourseList("3411");
                  Navigator.pushNamed(context, "/home");
                },
                icon: SvgPicture.asset('assets/icons/home_icon.svg')),
          ],
        ),
      ),
    ));
  }
}
