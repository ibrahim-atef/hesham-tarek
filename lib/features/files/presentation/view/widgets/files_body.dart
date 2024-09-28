import 'package:flutter/material.dart';
import 'package:hesham_tarek/features/files/presentation/view/widgets/files_content.dart';

class FilesBody extends StatelessWidget {
  const FilesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const FilesContent(),
          Container(
            color: Colors.blueGrey,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            height: 0.5,
          ),
          const FilesContent(),
          Container(
            color: Colors.blueGrey,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            height: 0.5,
          ),
          const FilesContent(),
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
