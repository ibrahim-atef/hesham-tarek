import 'package:flutter/material.dart';
import 'package:hesham_tarek/core/custom/whatsapp_floating_widget.dart';
import 'package:hesham_tarek/features/subscription/presentation/views/widgets/subscription_methods.dart';
import 'package:hesham_tarek/generated/l10n.dart';

class Subscription extends StatelessWidget {
  const Subscription({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(S.of(context).Subscription),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_rounded),
              color: Colors.white)),
      body: SubscriptionMethods(),
      floatingActionButton: WhatsappFloatingWidget(
        heroTag: "subscribe",
      ),
    );
  }
}
