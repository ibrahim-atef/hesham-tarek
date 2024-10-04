import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:hesham_tarek/features/home/presentation/views/widgets/home_app_bar.dart';

import 'package:hesham_tarek/features/login/presentation/views/login_view.dart';
import 'package:hesham_tarek/features/register/presentation/views/register_view.dart';
import 'package:hesham_tarek/generated/l10n.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class NotSignedIn extends StatelessWidget {
  const NotSignedIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Column(
          children: [
            const HomeAppBar(),
            SizedBox(
              height: 75.h,
            ),
            SvgPicture.asset("assets/icons/lock_icon.svg"),
            SizedBox(
              height: 25.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                  style: GoogleFonts.openSans(
                    fontSize: 17,
                  ),
                  textAlign: TextAlign.center,
                  S
                      .of(context)
                      .Pleaseloginorcreateaccounttoenjoyfullapplicationfeatures),
            ),
            SizedBox(
              height: 40.h,
            ),
            GestureDetector(
              onTap: () {
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: const LoginView(),
                  withNavBar: false,
                  pageTransitionAnimation: PageTransitionAnimation.fade,
                );
              },
              child: Center(
                child: Container(
                  width: 360.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  height: 48.h,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          S.of(context).Login,
                          style: GoogleFonts.openSans(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 17),
                        ),
                        const Icon(
                          Icons.lock,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            GestureDetector(
              onTap: () {
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: const RegisterView(),
                  withNavBar: false,
                  pageTransitionAnimation: PageTransitionAnimation.fade,
                );
              },
              child: Center(
                child: Container(
                  width: 360.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: Colors.black26),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 10,
                        offset: Offset(0, 5),
                        color: Colors.black12,
                      ),
                    ],
                  ),
                  height: 48.h,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          S.of(context).Createaccount,
                          style: GoogleFonts.openSans(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 17),
                        ),
                        const Icon(
                          Icons.person_add,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                ),
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
    );
  }
}
