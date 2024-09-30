import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesham_tarek/core/theme/theme.dart';
import 'package:hesham_tarek/core/utils/service_locator.dart';
import 'package:hesham_tarek/features/home/bloc/courseList/course_list_cubit.dart';
import 'package:hesham_tarek/features/home/data/repos/course_repo_implementation.dart';
import 'package:hesham_tarek/features/home/presentation/views/home_nav_bar.dart';
import 'package:hesham_tarek/features/login/bloc/login_cubit/login_cubit.dart';
import 'package:hesham_tarek/features/login/data/repos/imei_repo_implementation.dart';
import 'package:hesham_tarek/features/login/data/repos/login_repo_implementation.dart';
import 'package:hesham_tarek/features/login/presentation/views/login_view.dart';
import 'package:hesham_tarek/features/my_courses/bloc/cubit/course_detail_cubit.dart';
import 'package:hesham_tarek/features/my_courses/data/repo/course_detail_repo_implementation.dart';
import 'package:hesham_tarek/features/profile/bloc/language_cubit/language_cubit.dart';
import 'package:hesham_tarek/features/profile/bloc/language_cubit/language_state.dart';
import 'package:hesham_tarek/features/profile/presentation/views/profile_screen_view.dart';
import 'package:hesham_tarek/features/register/bloc/cubit/register_user_cubit.dart';
import 'package:hesham_tarek/features/register/data/repo/create_user_repo_implementation.dart';
import 'package:hesham_tarek/features/register/presentation/views/register_view.dart';
import 'package:hesham_tarek/features/splash/presentation/views/splash_screen_view.dart';
import 'package:hesham_tarek/features/subscription/presentation/views/bank_card_view.dart';
import 'package:hesham_tarek/features/subscription/presentation/views/bank_transfer_view.dart';
import 'package:hesham_tarek/features/subscription/presentation/views/instapay_view.dart';
import 'package:hesham_tarek/features/subscription/presentation/views/pay_at_office_view.dart';
import 'package:hesham_tarek/features/subscription/presentation/views/subscription_view.dart';
import 'package:hesham_tarek/features/subscription/presentation/views/vodafone_cash_view.dart';
import 'package:hesham_tarek/generated/l10n.dart';

import 'package:upgrader/upgrader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => LoginCubit(getIt.get<LoginRepoImplementation>(),
                getIt.get<ImeiRepoImplementation>())),
        BlocProvider(
            create: (_) =>
                RegisterUserCubit(getIt.get<CreateUserRepoImplementation>())),
        BlocProvider(
            create: (_) =>
                CourseListCubit(getIt.get<CourseRepoImplementation>())),
        BlocProvider(
            create: (_) =>
                CourseDetailCubit(getIt.get<CourseDetailRepoImplementation>())),
        BlocProvider(create: (_) => LanguageCubit()), // Provide LanguageCubit
      ],
      child: ScreenUtilInit(
        designSize: const Size(393, 852),
        splitScreenMode: false,
        useInheritedMediaQuery: true,
        ensureScreenSize: true,
        builder: (context, child) {
          return BlocBuilder<LanguageCubit, LanguageState>(
            builder: (context, state) {
              return UpgradeAlert(
                upgrader: Upgrader(
                  debugDisplayAlways:
                      true, // Forces the upgrade dialog to always show for testing
                  debugLogging: true, // Enables detailed logging for debugging,
                ),
                dialogStyle: Platform.isIOS
                    ? UpgradeDialogStyle.cupertino
                    : UpgradeDialogStyle.material,
                shouldPopScope: () => false,
                showIgnore: true,
                showLater: true,
                child: MaterialApp(
                  locale: state.languageCode == "English"
                      ? const Locale("en")
                      : const Locale("ar"), // Set the locale dynamically
                  localizationsDelegates: const [
                    S.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: S.delegate.supportedLocales,
                  debugShowCheckedModeBanner: false,
                  theme: lightTheme,
                  initialRoute: "/",
                  routes: {
                    "/": (context) => const SplashScreenView(),
                    "/register": (context) => const RegisterView(),
                    "/login": (context) => const LoginView(),
                    "/home": (context) => const HomeNavBar(),
                    "/subscription": (context) => const Subscription(),
                    "/subscription/instapay": (context) => const Instapay(),
                    "/subscription/vodafone": (context) =>
                        const VodafoneCashView(),
                    "/subscription/bankcard": (context) => const BankCardView(),
                    "/subscription/bankTransfer": (context) =>
                        const BankTransferView(),
                    "/subscription/payAtOffice": (context) =>
                        const PayAtOfficeView(),
                    "/profile": (context) => const ProfileScreenView(),
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
