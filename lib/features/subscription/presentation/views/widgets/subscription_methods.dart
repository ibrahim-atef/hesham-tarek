// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesham_tarek/core/text_styles.dart';
import 'package:hesham_tarek/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentMethod {
  final String method;
  final String icon;
  final String path;

  PaymentMethod({
    required this.method,
    required this.icon,
    required this.path,
  });
}

class SubscriptionMethods extends StatelessWidget {
  SubscriptionMethods({super.key});

  final List<PaymentMethod> methods = [
    PaymentMethod(
      method: "Instapay",
      icon: "assets/icons/instapay.png",
      path: "/subscription/instapay",
    ),
    PaymentMethod(
      method: "Vodafone cash",
      icon: "assets/icons/vodafone.png",
      path: "/subscription/vodafone",
    ),
    PaymentMethod(
      method: "Bank card",
      icon: "assets/icons/bank_card.png",
      path: "/subscription/bankcard",
    ),
    PaymentMethod(
      method: "Bank transfer",
      icon: "assets/icons/bank_transfer.png",
      path: "/subscription/bankTransfer",
    ),
    PaymentMethod(
      method: "Pay at office",
      icon: "assets/icons/pay_at_office.png",
      path: "/subscription/payAtOffice",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).Selectpaymentmethod,
            style: TextStyles.semiNormalBlack17,
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 16),

          // WhatsApp GestureDetector
          GestureDetector(
            onTap: () async {
              const phoneNumber =
                  '+201068386732'; // Replace with your target number
              final Uri whatsappUri = Uri.parse('https://wa.me/$phoneNumber');
              if (await canLaunch(whatsappUri.toString())) {
                await launch(whatsappUri.toString());
              } else {
                throw 'Could not launch $whatsappUri';
              }
            },
            child: Container(
              height: 56,
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border:
                    Border.all(color: const Color(0xFFCAD1D1), width: 0.5.w),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 0,
                    blurRadius: 2,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'WhatsApp', // Payment method name
                    style: TextStyles.normalBlack16,
                  ),
                  SizedBox(width: 8.w),
                  Image.asset(
                    'assets/icons/whatsapp.png', // Replace with the WhatsApp icon path
                    width: 32.w,
                    height: 32.h,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),

          // Payment Methods
          Column(
            children: methods.map((item) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, item.path);
                },
                child: Container(
                  height: 56,
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: const Color(0xFFCAD1D1), width: 0.5.w),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 0,
                        blurRadius: 2,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.method,
                        style: TextStyles.normalBlack16,
                      ),
                      SizedBox(width: 8.w),
                      Image.asset(
                        item.icon,
                        width: 32.w,
                        height: 32.h,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
