import 'package:flutter/material.dart';
import 'package:hesham_tarek/features/subscription/presentation/views/widgets/instapay_desc.dart';
import 'package:hesham_tarek/generated/l10n.dart';

class Instapay extends StatelessWidget {
  const Instapay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).Instapay),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_rounded),
              color: Colors.white),
        ),
        body: const InstapayDesc()
        // floatingActionButton: WhatsappFloatingWidget()
        );
  }
}
