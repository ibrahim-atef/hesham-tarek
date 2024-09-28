import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class WhatsappFloatingWidget extends StatelessWidget {
  WhatsappFloatingWidget({super.key, required this.heroTag});
  String androidUrl = "https://wa.me/${"+201068386732"}?text=" "";
  String iosUrl = "https://wa.me/${"+201068386732"}?text=" "";
  String webUrl =
      'https://api.whatsapp.com/send/?phone=${"+201068386732"}?text=""';
  String heroTag;

  // Method to launch WhatsApp with a specific number
  void _launchWhatsApp() async {
    try {
      if (Platform.isIOS) {
        if (await canLaunchUrl(Uri.parse(iosUrl))) {
          await launchUrl(Uri.parse(iosUrl));
        }
      } else {
        if (await canLaunchUrl(Uri.parse(androidUrl))) {
          await launchUrl(Uri.parse(androidUrl));
        }
      }
    } catch (e) {
      await launchUrl(Uri.parse(webUrl), mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: heroTag,
      disabledElevation: 0,
      enableFeedback: false,
      focusElevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      onPressed: () {
        _launchWhatsApp(); // Replace with the desired phone number
      },
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: SizedBox(
        height: 40.h,
        child: Image.asset(
          "assets/icons/whatsapp.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
