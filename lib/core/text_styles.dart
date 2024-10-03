import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class TextStyles {
  static final light15 = GoogleFonts.openSans(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: Colors.white.withOpacity(0.85));
  static final light17 = GoogleFonts.openSans(
      fontSize: 13,
      fontWeight: FontWeight.w400,
      color: Colors.white.withOpacity(0.85));
  static final semiBold17 = GoogleFonts.openSans(
      fontSize: 17, fontWeight: FontWeight.w600, color: Colors.white);
  static final bold28 = GoogleFonts.openSans(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      color: const Color(0xfff3f4f6));
  static final semiNormalBlack17 = GoogleFonts.openSans(
      fontSize: 17,
      fontWeight: FontWeight.w500,
      color: const Color(0xff11191A));
  static final semiNormalBlack22 = GoogleFonts.openSans(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: const Color(0xff11191A));
  static final semiNormalBlack15 = GoogleFonts.openSans(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: const Color(0xff11191A));
  static final semiBoldBlackText17 = GoogleFonts.openSans(
      fontSize: 17,
      fontWeight: FontWeight.w600,
      color: const Color(0xff11191A));
  static final semiBoldBlack16 = GoogleFonts.openSans(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: const Color(0xff11191A));
  static final normalBlack16 = GoogleFonts.openSans(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: const Color(0xff11191A));
  static final mediumGrey17 = GoogleFonts.openSans(
      fontSize: 17,
      fontWeight: FontWeight.w500,
      color: const Color(0xff4F6163));
  static final mediumBlue17 = GoogleFonts.openSans(
      fontSize: 17,
      fontWeight: FontWeight.w500,
      color: const Color(0xff1D3AF2));
  static final mediumDarkBlue17 = GoogleFonts.openSans(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: const Color(0xFF2C4649));
  static final primary15 = GoogleFonts.openSans(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: const Color(0xffF2B91D));
  static final primary25 = GoogleFonts.openSans(
      fontSize: 25,
      fontWeight: FontWeight.w800,
      color: const Color(0xffF2B91D));
  static final primaryBold15 = GoogleFonts.openSans(
      fontSize: 15,
      fontWeight: FontWeight.w700,
      color: const Color(0xffF2B91D));
}
