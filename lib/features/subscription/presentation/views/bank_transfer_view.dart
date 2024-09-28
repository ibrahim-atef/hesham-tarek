import 'package:flutter/material.dart';
import 'package:hesham_tarek/features/subscription/presentation/views/widgets/bank_transfer_desc.dart';
import 'package:hesham_tarek/generated/l10n.dart';

class BankTransferView extends StatelessWidget {
  const BankTransferView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).Banktransfer),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_rounded),
            color: Colors.white),
      ),
      body: const BankTransferDesc(),
      // floatingActionButton: WhatsappFloatingWidget(),
    );
  }
}
