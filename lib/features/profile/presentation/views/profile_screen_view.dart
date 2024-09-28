import 'package:flutter/material.dart';
import 'package:hesham_tarek/core/custom/whatsapp_floating_widget.dart';
import 'package:hesham_tarek/features/profile/presentation/views/widgets/profile_screen_view_body.dart';
import 'package:hesham_tarek/generated/l10n.dart';

class ProfileScreenView extends StatelessWidget {
  const ProfileScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).Profile),
      ),
      body: const ProfileScreenViewBody(),
      floatingActionButton: WhatsappFloatingWidget(
        heroTag: "profile",
      ),
    );
  }
}
