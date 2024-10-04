import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hesham_tarek/core/text_styles.dart';
import 'package:hesham_tarek/core/utils/service_locator.dart';
import 'package:hesham_tarek/features/login/bloc/login_cubit/login_cubit.dart';
import 'package:hesham_tarek/features/login/presentation/views/login_view.dart';
import 'package:hesham_tarek/features/profile/presentation/views/widgets/language_toggle.dart';
import 'package:hesham_tarek/generated/l10n.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreenViewBody extends StatefulWidget {
  const ProfileScreenViewBody({super.key});
  @override
  State<ProfileScreenViewBody> createState() => ProfileScreenViewBodyState();
}

class ProfileScreenViewBodyState extends State<ProfileScreenViewBody> {
  final user = UserData().user;
  bool isChecked = false;
  Future<void> savePhoneNumberAndPassword(String phone, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('savedPhone1', phone);
    await prefs.setString('savedPassword', password);
  }

  @override
  Widget build(BuildContext context) {
    var text = TextEditingController(
      text: user?.phone1 ?? "",
    );
    return Container(
        height: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).Language,
              style: TextStyles.normalBlack16,
            ),
            // SizedBox(
            //   height: 8.h,
            // ),
            LanguageToggle(),
            SizedBox(
              height: 16.h,
            ),

            SizedBox(
                width: 0.45.sw,
                child: Text(
                  S.of(context).Name,
                  style: TextStyles.normalBlack16,
                )),

            SizedBox(
              height: 8.h,
            ),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black),
              ),
              child: Text(
                user?.name ?? "",
                style: TextStyles.normalBlack16,
              ),
            ),
            SizedBox(
              width: 8.w,
            ),

            SizedBox(
              height: 16.h,
            ),
            SizedBox(
                width: 0.45.sw,
                child: Text(
                  S.of(context).Email,
                  style: TextStyles.normalBlack16,
                )),
            SizedBox(
              height: 8.h,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black),
              ),
              child: Text(
                user?.schoolName ?? "",
                style: TextStyles.normalBlack16,
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            SizedBox(
                width: 0.45.sw,
                child: Text(
                  S.of(context).PhoneNumber,
                  style: TextStyles.normalBlack16,
                )),
            SizedBox(
              height: 8.h,
            ),
            Directionality(
              textDirection: TextDirection.ltr,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black),
                ),
                child: TextFormField(
                  readOnly: true,
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.length <= 7) {
                      return "Please enter a valid Phone Number";
                    }
                  },
                  controller: text,
                ),
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return StatefulBuilder(builder: (context, setState) {
                      return Container(
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          color: Color(0xfff3f4f6),
                        ),
                        height: 300,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                child: Container(
                                  width: 35.w,
                                  height: 5.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    S.of(context).Logout,
                                    style: GoogleFonts.openSans(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    child: SvgPicture.asset(
                                      "assets/icons/close_icon.svg",
                                      width: 30.w,
                                      height: 30.h,
                                    ),
                                    onTap: () => Navigator.pop(context),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 32.h,
                              ),
                              Text(
                                S.of(context).Areyousureyouwanttologout,
                                textAlign: TextAlign.left,
                                style: GoogleFonts.openSans(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                height: 42.h,
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                    checkColor: Colors.black,
                                    value: isChecked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isChecked = value!;
                                        if (isChecked == true) {
                                          savePhoneNumberAndPassword(
                                              user?.phone1 ?? "",
                                              user?.password ?? "");
                                        }
                                      });
                                    },
                                  ),
                                  Text(
                                    S.of(context).RemembermyLogininfo,
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.openSans(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xFF4F6163)),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () => Navigator.pop(context),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: const Color(0xFFE5E7EB)),
                                        color: Colors.white,
                                      ),
                                      padding: const EdgeInsets.fromLTRB(
                                          14, 18, 14, 18),
                                      width: 0.45.sw,
                                      child: Center(
                                        child: Text(
                                          S.of(context).Cancel,
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.openSans(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      context.read<LoginCubit>().logoutUser();
                                      PersistentNavBarNavigator.pushNewScreen(
                                        context,
                                        screen: const LoginView(),
                                        withNavBar: false,
                                        pageTransitionAnimation:
                                            PageTransitionAnimation.fade,
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: const Color(0xFFEF4444),
                                      ),
                                      padding: const EdgeInsets.fromLTRB(
                                          14, 18, 14, 18),
                                      width: 0.45.sw,
                                      child: Center(
                                        child: Text(
                                          S.of(context).Yes,
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.openSans(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    });
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 0,
                      blurRadius: 2,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(14, 20, 14, 20),
                width: double.infinity,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  SvgPicture.asset(
                    "assets/icons/logout_icon.svg",
                    width: 20.w,
                    height: 20.h,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    S.of(context).Logout,
                    style: GoogleFonts.openSans(
                        color: const Color(0xFFEF4444),
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                  ),
                ]),
              ),
            ),
            SizedBox(
              height: 50.h,
            )
          ],
        ));
  }
}
