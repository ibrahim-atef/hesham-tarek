import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hesham_tarek/core/text_styles.dart';
import 'package:hesham_tarek/features/splash/presentation/views/widgets/blur_container.dart';

class SplashScreenViewBody extends StatefulWidget {
  const SplashScreenViewBody({super.key});

  @override
  State<SplashScreenViewBody> createState() => _SplashScreenViewBodyState();
}

class _SplashScreenViewBodyState extends State<SplashScreenViewBody> {
  EdgeInsets padding = EdgeInsets.zero;
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        padding =
            EdgeInsets.only(bottom: 10.h); // Move container up by 10 pixels
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/splash.png'), // Replace with your image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: const Color(0xff2C4649)
                .withOpacity(0.5), // Adjust opacity as needed
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: InnerBlurContainer(
                blurSigma: 4,
                height: 229.h,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                        padding: padding,
                        duration: const Duration(milliseconds: 500),
                        child: SvgPicture.asset('assets/images/logo.svg')),
                    Animate(
                      effects: const [
                        FadeEffect(
                          begin: 0,
                          end: 1,
                          duration: Duration(milliseconds: 500),
                          delay: Duration(milliseconds: 1500),
                        ),
                        SlideEffect(
                          begin: Offset(-1, 0), // Slide in from the left
                          end: Offset.zero,
                          duration: Duration(milliseconds: 500),
                          delay: Duration(milliseconds: 1500),
                        ),
                      ],
                      child: Text(
                        "Hesham Tarek",
                        style: TextStyles.primary25,
                      ),
                    ),
                    Animate(
                      effects: const [
                        FadeEffect(
                          begin: 0,
                          end: 1,
                          duration: Duration(milliseconds: 500),
                          delay: Duration(milliseconds: 1500),
                        ),
                        SlideEffect(
                          begin: Offset(1, 0), // Slide in from the right
                          end: Offset.zero,
                          duration: Duration(milliseconds: 500),
                          delay: Duration(milliseconds: 1500),
                        ),
                      ],
                      child: Text(
                        "Engineering Solutions",
                        style: TextStyles.primaryBold15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: Text("Loading...", style: TextStyles.light15),
              ))
        ],
      ),
    );
  }
}
