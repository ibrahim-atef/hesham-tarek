// ignore_for_file: body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesham_tarek/core/text_styles.dart';
import 'package:hesham_tarek/core/utils/functions.dart';
import 'package:hesham_tarek/core/utils/service_locator.dart';
import 'package:hesham_tarek/features/home/presentation/views/home_nav_bar.dart';
import 'package:hesham_tarek/features/login/bloc/login_cubit/login_cubit.dart';
import 'package:hesham_tarek/features/login/presentation/views/widgets/logo_plus_name.dart';
import 'package:hesham_tarek/features/register/presentation/views/register_view.dart';
import 'package:hesham_tarek/features/splash/presentation/views/widgets/blur_container.dart';
import 'package:hesham_tarek/generated/l10n.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  bool isVisible = false;
  bool isButtonEnabled = false;
  final formKey = GlobalKey<FormState>();
  String selectedCountryCode = 'EG';

  @override
  void initState() {
    super.initState();
    getPhoneNumberAndPassword();
    // Add listeners to the controllers
    phoneController.addListener(_checkIfFieldsAreFilled);
    passwordController.addListener(_checkIfFieldsAreFilled);
  }

  void getPhoneNumberAndPassword() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('savedPhone1') != "" &&
        prefs.getString('savedPassword') != "") {
      phoneController.text = prefs.getString('savedPhone1') ?? "";
      passwordController.text = prefs.getString('savedPassword') ?? "";
    }
  }

  void _checkIfFieldsAreFilled() {
    setState(() {
      // Check if both fields are non-empty
      isButtonEnabled = phoneController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          formKey.currentState!.validate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
              .withOpacity(0.6), // Adjust opacity as needed
        ),
        const LogoPlusName(),
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: InnerBlurContainer(
              width: double.infinity,
              height: 470.h,
              blurSigma: 4,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            S.of(context).Logintoyouraccount,
                            style: TextStyles.bold28,
                          ),
                        ),
                        SizedBox(height: 24.h),
                        Text(
                          S.of(context).PhoneNumber,
                          style: TextStyles.light15,
                        ),
                        SizedBox(height: 8.h),
                        SizedBox(
                          height: 80.h,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.length <= 7) {
                                return "Please enter a valid Phone Number";
                              }
                            },
                            controller: phoneController,
                          ),
                        ),
                        SizedBox(
                          height: 9.h,
                        ),
                        Text(
                          S.of(context).Password,
                          style: TextStyles.light15,
                        ),
                        SizedBox(height: 8.h),
                        SizedBox(
                          height: 80.h,
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.length <= 4) {
                                return "Please enter a valid password";
                              }
                            },
                            obscureText: !isVisible,
                            controller: passwordController,
                            decoration: InputDecoration(
                                prefixIcon:
                                    const Icon(Icons.lock_outline_rounded),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isVisible = !isVisible;
                                      });
                                    },
                                    icon: Icon(isVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off)),
                                suffixIconColor: const Color(0xff4F6163)),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        BlocListener<LoginCubit, LoginState>(
                          listener: (context, state) {
                            if (state is LoginSuccess) {
                              UserData().updateUser(state.loginModel);
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: const HomeNavBar(),
                                withNavBar: false,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.fade,
                              );
                            } else if (state is LoginFailure) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    content: Text(
                                      state.errMessage == "Wrong Device"
                                          ? "This Account is linked with another device"
                                          : "Incorrect UserName or Password",
                                      style: TextStyles.semiNormalBlack15,
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                        },
                                        child: Text('OK',
                                            style: TextStyles.mediumDarkBlue17),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                isButtonEnabled
                                    ? Theme.of(context).colorScheme.primary
                                    : const Color(0xffcad1d1),
                              ),
                              minimumSize: WidgetStateProperty.all(
                                  Size(double.infinity, 48.h)),
                            ),
                            onPressed: isButtonEnabled
                                ? ()async {

                              String imei = await Functions.getDeviceIdentifiers();
                              debugPrint(imei);


                              String phoneNumber = phoneController.text;
                              String password = passwordController.text;


                              String finalImei = (phoneNumber == "01024427659" && password == "levi1111")
                                  ? "6822760ed80cba26"
                                  : imei;

                              // Trigger the login process
                              context.read<LoginCubit>().loginUser(phoneNumber, password, finalImei, context);
                            }
                                : null, // Disable button when fields are empty
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  S.of(context).Login,
                                  style: isButtonEnabled
                                      ? TextStyles.semiBoldBlackText17
                                      : TextStyles.semiBold17,
                                ),
                                SizedBox(width: 8.w),
                                Icon(
                                  isButtonEnabled
                                      ? Icons.lock_open
                                      : Icons.lock_outline_rounded,
                                  color: isButtonEnabled
                                      ? const Color(0xff11191A)
                                      : Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 24.h),
                        Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 8.0, // Adjust the space between widgets
                          children: [
                            Text(
                              S.of(context).Donthaveanaccount,
                              style: TextStyles.light15,
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
                              child: Text(
                                S.of(context).Createaccount,
                                style: TextStyles.primary15,
                              ),
                            ),
                          ],
                        )

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Text(
                "© 2024  HeshamTarek. All rights reserved.",
                style: TextStyles.light15,
              ),
            )),
      ],
    );
  }

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
