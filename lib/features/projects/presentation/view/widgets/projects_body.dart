import 'package:flutter/material.dart';
import 'package:hesham_tarek/features/projects/presentation/view/widgets/project_content.dart';

class ProjectsBody extends StatelessWidget {
  const ProjectsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const ProjectContent(),
          Container(
            color: Colors.blueGrey,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            height: 0.5,
          ),
          const ProjectContent(),
          Container(
            color: Colors.blueGrey,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            height: 0.5,
          ),
          const ProjectContent(),
          Container(
            color: Colors.blueGrey,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            height: 0.5,
          ),
        ],
      ),
    );
  }
}
