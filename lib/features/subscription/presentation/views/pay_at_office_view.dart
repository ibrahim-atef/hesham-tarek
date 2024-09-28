import 'package:flutter/material.dart';
import 'package:hesham_tarek/features/subscription/presentation/views/widgets/pay_at_office_desc.dart';
import 'package:hesham_tarek/generated/l10n.dart';

class PayAtOfficeView extends StatelessWidget {
  const PayAtOfficeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).Paymentatoffice),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_rounded),
            color: Colors.white),
      ),
      body: const PayAtOfficeDesc(),
      // floatingActionButton: WhatsappFloatingWidget()
    );
  }
}
