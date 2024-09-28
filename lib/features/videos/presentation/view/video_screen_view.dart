import 'package:flutter/material.dart';
import 'package:hesham_tarek/generated/l10n.dart';
import 'widgets/video_screen_body.dart';

class VideoScreenView extends StatelessWidget {
  const VideoScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).Videos),
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
      body: const VidepScreenBody(),
    );
  }
}
