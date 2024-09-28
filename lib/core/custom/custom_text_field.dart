import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesham_tarek/core/text_styles.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  const CustomTextField({
    super.key,
    required this.hint,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          suffixIcon: Container(
            width: 48.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: const Color(0xffF9FAFB),
              borderRadius:
                  const BorderRadius.horizontal(right: Radius.circular(12)),
              border: Border.all(color: const Color(0xffE5E7EB), width: 1),
            ),
            child: IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          ),
          hintText: hint,
          hintStyle: TextStyles.mediumGrey17),
    );
  }
}
