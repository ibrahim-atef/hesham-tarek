import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesham_tarek/core/custom/whatsapp_floating_widget.dart';
import 'package:hesham_tarek/core/utils/service_locator.dart';
import 'package:hesham_tarek/features/home/presentation/views/home_view.dart';
import 'package:hesham_tarek/features/login/bloc/login_cubit/login_cubit.dart';
import 'package:hesham_tarek/features/notSignedIn/presentation/view/not_signed_in.dart';
import 'package:hesham_tarek/features/profile/presentation/views/profile_screen_view.dart';
import 'package:hesham_tarek/generated/l10n.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../../my_courses/presentation/views/my_courses_view.dart';

class HomeNavBar extends StatefulWidget {
  const HomeNavBar({super.key});

  @override
  State<HomeNavBar> createState() => _HomeNavBarState();
}

class _HomeNavBarState extends State<HomeNavBar> {
  final user = UserData().user;
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        inactiveIcon: const Icon(Icons.home_outlined),
        title: (S.of(context).Home),
        activeColorPrimary: const Color(0xffF2B91D),
        inactiveColorPrimary: const Color(0xff899B9C),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.collections_bookmark),
        inactiveIcon: const Icon(Icons.collections_bookmark_outlined),
        title: (S.of(context).MyCourses),
        activeColorPrimary: const Color(0xffF2B91D),
        inactiveColorPrimary: const Color(0xff899B9C),
      ),
      // PersistentBottomNavBarItem(
      //   icon: const Icon(Icons.favorite),
      //   inactiveIcon: const Icon(Icons.favorite_border),
      //   title: (S.of(context).Favorites),
      //   activeColorPrimary: const Color(0xffF2B91D),
      //   inactiveColorPrimary: const Color(0xff899B9C),
      // ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        inactiveIcon: const Icon(Icons.person_outline),
        title: (S.of(context).Profile),
        activeColorPrimary: const Color(0xffF2B91D),
        inactiveColorPrimary: const Color(0xff899B9C),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    PersistentTabController controller =
        PersistentTabController(initialIndex: 0);

    return BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
      if (state is LoginSuccess) {
        // context
        //     .read<CourseListCubit>()
        //     .getCourseList(UserData().user!.id.toString());
        return PersistentTabView(
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(0),
            child: WhatsappFloatingWidget(heroTag: "home"),
          ),
          context,
          controller: controller,
          screens: const [
            HomeView(),
            MyCourseView(),
            // FavoritesView(),
            ProfileScreenView()
          ],
          items: _navBarsItems(),
          hideNavigationBarWhenKeyboardAppears: true,
          padding: EdgeInsets.symmetric(vertical: 12.h),
          backgroundColor: const Color(0xff2C4649),
          isVisible: true,
          animationSettings: const NavBarAnimationSettings(
            navBarItemAnimation: ItemAnimationSettings(
              duration: Duration(milliseconds: 400),
              curve: Curves.ease,
            ),
            screenTransitionAnimation: ScreenTransitionAnimationSettings(
              animateTabTransition: true,
              duration: Duration(milliseconds: 200),
              screenTransitionAnimationType:
                  ScreenTransitionAnimationType.fadeIn,
            ),
          ),
          confineToSafeArea: true,
          navBarHeight: 70.h,
          navBarStyle: NavBarStyle.style6,
        );
      } else {
        return PersistentTabView(
          context,
          controller: controller,
          screens: const [
            HomeView(),
            NotSignedIn(),
            // NotSignedIn(),
            NotSignedIn()
          ],
          items: _navBarsItems(),
          hideNavigationBarWhenKeyboardAppears: true,
          padding: EdgeInsets.symmetric(vertical: 12.h),
          backgroundColor: const Color(0xff2C4649),
          isVisible: true,
          animationSettings: const NavBarAnimationSettings(
            navBarItemAnimation: ItemAnimationSettings(
              duration: Duration(milliseconds: 400),
              curve: Curves.ease,
            ),
            screenTransitionAnimation: ScreenTransitionAnimationSettings(
              animateTabTransition: true,
              duration: Duration(milliseconds: 200),
              screenTransitionAnimationType:
                  ScreenTransitionAnimationType.fadeIn,
            ),
          ),
          confineToSafeArea: true,
          navBarHeight: 70.h,
          navBarStyle: NavBarStyle.style6,
        );
      }
    });
  }
}
