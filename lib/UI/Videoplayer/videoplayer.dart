import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple/Reusable/color.dart';
import 'package:simple/UI/Videoplayer/videoItems.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerPage extends StatefulWidget {
  final VideoItem item;
  final bool isDarkMode;

  const VideoPlayerPage({
    required this.item,
    required this.isDarkMode,
    super.key,
  });

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _initializeController();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void didUpdateWidget(covariant VideoPlayerPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reinitialize controller if the video ID has changed
    if (oldWidget.item.id != widget.item.id) {
      _controller.dispose();
      _initializeController();
    }
  }

  void _initializeController() {
    _controller = YoutubePlayerController(
      initialVideoId: widget.item.id,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        enableCaption: true,
      ),
    );
  }

  @override
  void dispose() {
    // Reset to portrait orientation when disposing the controller
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color appBarBackgroundColor =
    widget.isDarkMode ? const Color(0xFF424242) : Colors.blue;
    final Color textColor = widget.isDarkMode ? Colors.white : Colors.black;
    final Color scaffoldBackgroundColor =
    widget.isDarkMode ? Colors.grey[900]! : Colors.white;

    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: appBarBackgroundColor,
        title: Text(
          widget.item.title,
          style: TextStyle(
            color: whiteColor,
            fontFamily: 'Times New Roman',
          ),
        ),
        iconTheme: IconThemeData(color: whiteColor),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              onReady: () {
                // Optional: You can add any actions you want when player is ready
              },
            ),
          ),
        ),
      ),
    );
  }
}