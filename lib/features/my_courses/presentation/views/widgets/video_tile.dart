import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:hesham_tarek/features/my_courses/data/models/course_detail/lesson_api_dto.dart';
import 'package:hesham_tarek/features/video/presentation/view/video_player.dart';
import 'package:hesham_tarek/generated/l10n.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class VideoTile extends StatefulWidget {
  final String videoTitle;
  final double videoPrice;
  final String videoDesc;
  final List<LessonApiDto>? allVideos;
  final int index;
  final String videoId; // This is now used as the video ID
  final bool isBought;

  const VideoTile({
    super.key,
    required this.videoTitle,
    required this.videoPrice,
    required this.videoDesc,
    required this.videoId,
    required this.allVideos,
    required this.index,
    required this.isBought,
  });

  @override
  // ignore: library_private_types_in_public_api
  _VideoTileState createState() => _VideoTileState();
}

class _VideoTileState extends State<VideoTile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.isBought == true || widget.videoPrice == 0.0) {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: VideoWidget(
                index: widget.index,
                videoDesc: widget.videoDesc,
                allVideos: widget.allVideos,
                isBought: widget.isBought),
            withNavBar: false,
            pageTransitionAnimation: PageTransitionAnimation.fade,
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context).colorScheme.primary, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: 120,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                            'https://img.youtube.com/vi/${widget.videoId}/0.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.videoTitle,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (widget.isBought == true || widget.videoPrice == 0.0)
                          ElevatedButton(
                            onPressed: () {
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: VideoWidget(
                                    index: widget.index,
                                    videoDesc: widget.videoDesc,
                                    allVideos: widget.allVideos,
                                    isBought: widget.isBought),
                                withNavBar: false,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.fade,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            child: Text(S.of(context).Preview,
                                style: const TextStyle(color: Colors.black)),
                          )
                        else if (widget.isBought == false &&
                            widget.videoPrice != 0.0)
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            child: Row(children: [
                              Text(S.of(context).Locked,
                                  style: const TextStyle(color: Colors.black)),
                              const Icon(
                                Icons.lock,
                                size: 16,
                                color: Colors.black,
                              )
                            ]),
                          )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
