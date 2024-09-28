import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesham_tarek/constants.dart';
import 'package:hesham_tarek/core/text_styles.dart';
import 'package:hesham_tarek/features/login/presentation/views/widgets/logo_plus_name.dart';
import 'package:hesham_tarek/features/register/bloc/cubit/register_user_cubit.dart';
import 'package:hesham_tarek/features/splash/presentation/views/widgets/blur_container.dart';
import 'package:hesham_tarek/generated/l10n.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../../../login/presentation/views/login_view.dart';

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  State<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody> {
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var firstNameController = TextEditingController();
  var emailController = TextEditingController();
  bool isVisible = false;
  bool isButtonEnabled = false;
  final formKey = GlobalKey<FormState>();
  String selectedCountryCode = 'EG';

  @override
  void initState() {
    super.initState();

    // Add listeners to the controllers
    phoneController.addListener(_checkIfFieldsAreFilled);
    passwordController.addListener(_checkIfFieldsAreFilled);
    firstNameController.addListener(_checkIfFieldsAreFilled);
    emailController.addListener(_checkIfFieldsAreFilled);
  }

  void _checkIfFieldsAreFilled() {
    setState(() {
      // Check if all fields are non-empty
      isButtonEnabled = phoneController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          firstNameController.text.isNotEmpty &&
          emailController.text.isNotEmpty;
    });
  }

  Future<String> getDeviceIdentifiers() async {
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      String? androidId = await AndroidIdHelper.getAndroidId();
      return androidId ?? "";
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      final identifierForVendor = iosInfo.identifierForVendor;
      return identifierForVendor ?? "";
    } else {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/splash.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          color: const Color(0xff2C4649).withOpacity(0.6),
        ),
        const LogoPlusName(),
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: InnerBlurContainer(
              width: double.infinity,
              height: 580.h,
              blurSigma: 4,
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            S.of(context).Createaccount,
                            style: TextStyles.bold28,
                          ),
                        ),
                        SizedBox(height: 24.h),

                        // First Name and Last Name Fields in a Row

                        Text(
                          S.of(context).Name,
                          style: TextStyles.light15,
                        ),
                        SizedBox(height: 8.h),
                        TextFormField(
                          controller: firstNameController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xfff3f4f6),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 8.h,
                        ),
                        Text(
                          S.of(context).Email,
                          style: TextStyles.light15,
                        ),
                        SizedBox(height: 8.h),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: emailController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xfff3f4f6),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a valid email';
                            } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                .hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          S.of(context).PhoneNumber,
                          style: TextStyles.light15,
                        ),
                        SizedBox(height: 8.h),
                        SizedBox(
                          height: 80.h,
                          child: IntlPhoneField(
                            validator: (value) {
                              if (value!.number.length < 10) {
                                return "Please enter a valid phone number";
                              }
                              return null;
                            },
                            disableLengthCheck: true,
                            dropdownDecoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(8)),
                              color: Color(0xfff3f4f6),
                            ),
                            showDropdownIcon: false,
                            onCountryChanged: (Country country) {
                              setState(() {
                                selectedCountryCode = country.code;
                              });
                            },
                            controller: phoneController,
                            initialCountryCode: "EG",
                          ),
                        ),

                        // Password Field
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
                              if (value!.length < 4) {
                                return "Please enter a valid password";
                              }
                              return null;
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
                        BlocConsumer<RegisterUserCubit, RegisterUserState>(
                          listener: (context, state) {
                            if (state is RegisterUserSuccess) {
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: const LoginView(),
                                withNavBar: false,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.fade,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "Account Created Successfully")));
                            }
                            if (state is RegisterUserFailure) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(state.errMessage)));
                            }
                          },
                          builder: (context, state) {
                            if (state is RegisterUserLoading) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            return ElevatedButton(
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
                                  ? () async {
                                      String phoneNumber = phoneController.text;
                                      if (selectedCountryCode == 'EG' &&
                                          !phoneNumber.startsWith('0')) {
                                        phoneNumber = "0$phoneNumber";
                                      }
                                      context
                                          .read<RegisterUserCubit>()
                                          .registerUser(
                                            firstNameController.text,
                                            passwordController.text,
                                            phoneController.text,
                                            emailController.text,
                                            await getDeviceIdentifiers(),
                                          );
                                    }
                                  : null,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    S.of(context).Createaccount,
                                    style: isButtonEnabled
                                        ? TextStyles.semiBoldBlackText17
                                        : TextStyles.semiBold17,
                                  ),
                                  SizedBox(width: 8.w),
                                  Icon(
                                    Icons.person,
                                    color: isButtonEnabled
                                        ? const Color(0xff11191A)
                                        : Colors.white,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              S.of(context).Alreadyhaveanaccount,
                              style: TextStyles.light15,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                S.of(context).Login,
                                style: TextStyles.primary15,
                              ),
                            ),
                          ],
                        ),
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
    firstNameController.dispose();
    emailController.dispose();
    super.dispose();
  }
}
