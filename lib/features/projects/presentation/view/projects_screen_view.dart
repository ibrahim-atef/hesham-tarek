import 'package:flutter/material.dart';

import 'package:hesham_tarek/features/projects/presentation/view/widgets/projects_body.dart';
import 'package:hesham_tarek/generated/l10n.dart';

class ProjectsScreenView extends StatelessWidget {
  const ProjectsScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).Projects),
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
      body: const ProjectsBody(),
      // floatingActionButton: WhatsappFloatingWidget(),
    );
  }
}
