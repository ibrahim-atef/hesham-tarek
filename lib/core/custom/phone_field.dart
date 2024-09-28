import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneField extends StatelessWidget {
  const PhoneField({
    super.key,
    required this.phoneController,
    required this.onCountryChanged,
  });

  final TextEditingController phoneController;
  final void Function(Country) onCountryChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
              topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
          color: Color(0xfff3f4f6),
        ),
        showDropdownIcon: false,
        controller: phoneController,
        onCountryChanged: onCountryChanged,
        initialCountryCode: "EG",
      ),
    );
  }
}
