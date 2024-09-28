import 'package:flutter/material.dart';

import 'package:hesham_tarek/features/files/presentation/view/widgets/files_body.dart';
import 'package:hesham_tarek/generated/l10n.dart';

class FilesScreenView extends StatelessWidget {
  const FilesScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).Files),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: const FilesBody(),
      // floatingActionButton: WhatsappFloatingWidget(),
    );
  }
}
