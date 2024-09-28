import 'package:flutter/material.dart';
import 'package:hesham_tarek/core/custom/whatsapp_floating_widget.dart';
import 'package:hesham_tarek/generated/l10n.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).Favorites),
      ),
      body: Container(),
      floatingActionButton: WhatsappFloatingWidget(heroTag: "favorites"),
    );
  }
}
