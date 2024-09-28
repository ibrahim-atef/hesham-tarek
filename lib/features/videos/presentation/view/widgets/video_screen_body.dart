import 'package:flutter/material.dart';
import 'video_button.dart';

class VidepScreenBody extends StatelessWidget {
  const VidepScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          VideoButton(),
          VideoButton(),
          VideoButton(),
          VideoButton(),
          VideoButton(),
          VideoButton(),
          VideoButton(),
          VideoButton(),
          VideoButton(),
        ],
      ),
    );
  }
}
