import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesham_tarek/generated/l10n.dart';

class VodafoneCashDesc extends StatelessWidget {
  const VodafoneCashDesc({super.key});

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
                "${S.of(context).Paymentwith} ${S.of(context).Vodafonecash}",
                style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
                textAlign: TextAlign.start,
              ),
              Image.asset(
                "assets/icons/vodafone.png",
                width: 32.w,
                height: 32.h,
                fit: BoxFit.contain,
              )
            ],
          ),
          const SizedBox(height: 38),
          SizedBox(
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).one,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.start,
                ),
                Expanded(
                  child: Text(
                    S.of(context).SendcoursepackagepricetothefollowingNumber,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            child: const Text(
              "01098797224",
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            child: const Text(
              "01070499359",
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            child: const Text(
              "01070499342",
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            child: const Text(
              "01004342626",
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).two,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.start,
                ),
                Expanded(
                  child: Text(
                    S
                        .of(context)
                        .ClickonWhatsAppiconatthebottomofthispageandsenduscreenshotofTransaction,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
