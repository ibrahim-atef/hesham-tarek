import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hesham_tarek/core/utils/service_locator.dart';
import 'package:hesham_tarek/features/home/bloc/courseList/course_list_cubit.dart';
import 'package:hesham_tarek/features/login/bloc/login_cubit/login_cubit.dart';
import 'package:hesham_tarek/features/splash/presentation/views/widgets/splash_screen_view_body.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  void initState() {
    context.read<LoginCubit>().checkLoginStatus(context);
    Future.delayed(const Duration(seconds: 3)).then((value) {
    if (mounted) {
  final user = UserData().user;
  user == null?context.read<CourseListCubit>().getCourseList("3411"):
  context.read<CourseListCubit>().getCourseList(user.id.toString());
}
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashScreenViewBody(),
    );
  }
}
