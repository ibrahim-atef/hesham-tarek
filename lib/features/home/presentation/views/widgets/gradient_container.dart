import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class GradientButton extends StatelessWidget {
  final String svgImage;
  final String buttonText;
  final Widget route;
  const GradientButton(
      {super.key,
      required this.svgImage,
      required this.buttonText,
      required this.route});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: route,
          withNavBar: false,
          pageTransitionAnimation: PageTransitionAnimation.fade,
        );
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color(0xffC4649),
            ),
            width: 75.w,
            height: 75.h,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SvgPicture.asset(svgImage)),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            buttonText,
            style: GoogleFonts.openSans(fontSize: 16, color: Colors.black87),
          )
        ],
      ),
    );
  }
}
