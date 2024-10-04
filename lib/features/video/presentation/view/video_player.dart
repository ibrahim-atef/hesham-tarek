import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hesham_tarek/core/text_styles.dart';
import 'package:hesham_tarek/features/my_courses/data/models/course_detail/lesson_api_dto.dart';
import 'package:hesham_tarek/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:screen_protector/screen_protector.dart';

class VideoWidget extends StatefulWidget {
  final List<LessonApiDto>? allVideos;
  final int index;
  final String videoDesc;
  final bool isBought;

  const VideoWidget({
    super.key,
    required this.allVideos,
    required this.index,
    required this.videoDesc,
    required this.isBought,
  });

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late YoutubePlayerController _controller;
  bool _isFullscreen = false;
  SharedPreferences? _prefs;
  int _savedPosition = 0;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
    _enableScreenProtection();
    _controller = YoutubePlayerController(
      initialVideoId: widget.allVideos![widget.index].contentUrl!,
      flags: const YoutubePlayerFlags(
        isLive: false,
        autoPlay: true,
        mute: false,
        enableCaption: true,
        hideThumbnail: true,
      ),
    );

    _controller.addListener(_listener);
  }

  Future<void> _enableScreenProtection() async {
    // Enable screen protection
    await ScreenProtector.preventScreenshotOn();
    await ScreenProtector.protectDataLeakageOn();
  }

  Future<void> _disableScreenProtection() async {
    // Disable screen protection
    await ScreenProtector.preventScreenshotOff();
    await ScreenProtector.protectDataLeakageOff();
  }

  void _listener() {
    if (_isPlayerReady && mounted) {
      setState(() {
        _isFullscreen = _controller.value.isFullScreen;
      });
      _saveVideoProgress();
      _updateSystemUIOverlays();
    }
    if (_controller.value.playerState == PlayerState.ended &&
        widget.isBought == true) {
      _goToNextVideo();
    } else if (_controller.value.playerState == PlayerState.ended &&
        widget.isBought == false) {
      Navigator.pop(context);
    }
  }

  void _updateSystemUIOverlays() {
    if (_isFullscreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    }
  }

  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    await _loadSavedPosition();
  }

  void _goToNextVideo() {
    if (widget.index + 1 < widget.allVideos!.length) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => VideoWidget(
            isBought: widget.isBought,
            allVideos: widget.allVideos,
            index: widget.index + 1,
            videoDesc: widget.videoDesc,
          ),
        ),
      );
    }
  }

  Future<void> _loadSavedPosition() async {
    if (_prefs != null) {
      _savedPosition = _prefs!.getInt(
              'video_position_${widget.allVideos![widget.index].contentId}') ??
          0;
      if (_isPlayerReady) {
        _controller.seekTo(Duration(seconds: _savedPosition));
      }
    }
  }

  void _saveVideoProgress() {
    if (_controller.value.isPlaying && _isPlayerReady) {
      int currentPosition = _controller.value.position.inSeconds;
      if (_prefs != null) {
        _prefs!.setInt(
            'video_position_${widget.allVideos![widget.index].contentId}',
            currentPosition);
      }
    }
  }

  @override
  @override
  void dispose() {
    // Ensure orientation is locked to portrait when the widget is disposed
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    _controller.removeListener(_listener);
    _saveVideoProgress();
    _controller.dispose();
    _disableScreenProtection();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Lock the orientation to portrait when not in fullscreen
    if (!_isFullscreen) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }

    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        _updateSystemUIOverlays();
        // When exiting fullscreen, lock the orientation to portrait
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      },
      onEnterFullScreen: () {
        _updateSystemUIOverlays();
        // Allow landscape when entering fullscreen
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);
      },
      player: YoutubePlayer(
        aspectRatio: 21 / 9,
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
        topActions: <Widget>[
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              _controller.metadata.title,
              style: GoogleFonts.openSans(
                color: Colors.white,
                fontSize: 18.0,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
        onReady: () {
          _isPlayerReady = true;
          _loadSavedPosition();
        },
      ),
      builder: (context, player) => Scaffold(
        appBar: !_isFullscreen
            ? AppBar(
                title: Text(widget.allVideos![widget.index].contentName!),
                leading: IconButton(
                  onPressed: () {
                    _saveVideoProgress();
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                  ),
                ),
              )
            : null,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              player,
              if (!_isFullscreen) const SizedBox(height: 5),
              if (!_isFullscreen && widget.isBought == true)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (widget.index != 0)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VideoWidget(
                                  isBought: widget.isBought,
                                  allVideos: widget.allVideos,
                                  index: widget.index - 1,
                                  videoDesc: widget.videoDesc,
                                ),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(
                                Icons.navigate_before_outlined,
                                color: Color(0xff11191A),
                              ),
                              Text(S.of(context).PreviousVideo,
                                  style: GoogleFonts.openSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xff11191A))),
                            ],
                          ),
                        ),
                      ),
                    if (widget.index + 1 != widget.allVideos!.length)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VideoWidget(
                                  isBought: widget.isBought,
                                  allVideos: widget.allVideos,
                                  index: widget.index + 1,
                                  videoDesc: widget.videoDesc,
                                ),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                S.of(context).NextVideo,
                                style: GoogleFonts.openSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xff11191A)),
                              ),
                              const Icon(
                                Icons.navigate_next_rounded,
                                color: Color(0xff11191A),
                              )
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              if (!_isFullscreen)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    widget.allVideos![widget.index].contentName!,
                    style: TextStyles.semiNormalBlack22,
                  ),
                ),
              if (!_isFullscreen)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(widget.videoDesc),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
