import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesham_tarek/generated/l10n.dart';

class BankTransferDesc extends StatelessWidget {
  const BankTransferDesc({super.key});

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
                "${S.of(context).Paymentatoffice} ${S.of(context).Banktransfer}",
                style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
                textAlign: TextAlign.start,
              ),
              Image.asset(
                "assets/icons/bank_transfer.png",
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
                    S.of(context).Paycoursepackagepriceusingbankcard,
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
                    "${S.of(context).Bankaccountdetails} :",
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          const SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Text(
                  "Bank: ",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.start,
                ),
                Expanded(
                  child: Text(
                    "National Bank of Egypt (NBE).",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Text(
                  "Beneficiary account currency: ",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.start,
                ),
                Expanded(
                  child: Text(
                    "US dollar",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Text(
                  "Beneficiary name: ",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.start,
                ),
                Expanded(
                  child: Text(
                    "Hesham Tarek Badr Awad",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Text(
                  "Account branch: ",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.start,
                ),
                Expanded(
                  child: Text(
                    "Integrated Care in Katameya",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            alignment: Alignment.centerLeft,
            width: double.infinity,
            child: const Column(
              children: [
                Text(
                  "International bank account number IBAN: ",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.start,
                ),
                Text(
                  "EG220003019350008188519010180",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Text(
                  "Swift code: ",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.start,
                ),
                Expanded(
                  child: Text(
                    "NBEG EG CX 193",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Text(
                  "CIF Customer Number: ",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.start,
                ),
                Expanded(
                  child: Text(
                    "08188519",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 38),
          SizedBox(
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "3. ",
                  style: TextStyle(
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
