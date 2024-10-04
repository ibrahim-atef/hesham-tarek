import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PhoneField extends StatelessWidget {
  const PhoneField({
    super.key,
    required this.phoneController,
  });

  final TextEditingController phoneController;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 80.h,
        child: TextFormField(
          validator: (value) {
            if (value!.length < 10) {
              return "Please enter a valid phone number";
            }
            return null;
          },
          controller: phoneController,
          decoration: const InputDecoration(
            labelText: 'Phone Number',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
            fillColor: Color(0xfff3f4f6),
            filled: true,
          ),
        ));
  }
}
