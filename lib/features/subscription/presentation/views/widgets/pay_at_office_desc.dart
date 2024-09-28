import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesham_tarek/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

class PayAtOfficeDesc extends StatelessWidget {
  const PayAtOfficeDesc({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).Paymentatoffice,
                style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
                textAlign: TextAlign.start,
              ),
              Image.asset(
                "assets/icons/instapay.png",
                width: 32.w,
                height: 32.h,
                fit: BoxFit.contain,
              )
            ],
          ),
          const SizedBox(height: 38),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).Workinghours,
                style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
                textAlign: TextAlign.start,
              )
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  ". ",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.start,
                ),
                Expanded(
                  child: Text(
                    S.of(context).SaturdaytoThurthdayFrom900amto900pm,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 38),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).Location,
                style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
                textAlign: TextAlign.start,
              )
            ],
          ),
          const SizedBox(height: 10),
          GestureDetector(
              onTap: () => _launchMaps(),
              child: Image.asset("assets/images/location.jpg",
                  width: double.infinity))
        ],
      ),
    );
  }

  void _launchMaps() async {
    final Uri url = Uri.parse("https://goo.gl/maps/imULpbZbEmqQSXNF7");

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}
