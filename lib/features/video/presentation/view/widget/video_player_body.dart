import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CourseBodyWidget extends StatefulWidget {
  final String videoId;
  const CourseBodyWidget({
    super.key,
    required this.videoId,
  });
  @override
  _CourseBodyWidgetState createState() => _CourseBodyWidgetState();
}

class _CourseBodyWidgetState extends State<CourseBodyWidget> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        enableCaption: true,
        isLive: false,
        forceHD: false,
        hideThumbnail: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        onReady: () {
          _controller.addListener(() {});
        },
      ),
      builder: (context, player) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              player, // This displays the Youtube player.
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  '1. Difference Between Instance Pr and Type Pr 2 | revit structure',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
