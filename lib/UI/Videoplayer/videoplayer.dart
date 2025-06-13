import 'package:flutter/material.dart';
import 'package:simple/Reusable/color.dart';
import 'package:simple/UI/Videoplayer/videoItems.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerPage extends StatefulWidget {
  final VideoItem item;
  final bool isDarkMode;

  const VideoPlayerPage(
      {required this.item,
      required this.isDarkMode,
      super.key}); // Updated constructor

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late final YoutubePlayerController
      _controller; // Controller for YouTube player

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.item.id, // Set initial video ID from the item
      flags: const YoutubePlayerFlags(
        autoPlay: true, // Auto-play video
        mute: false, // Video not muted by default
        enableCaption: true, // Enable captions if available
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller when the page is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Define colors for the VideoPlayerPage based on dark mode state
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
        iconTheme: IconThemeData(color: whiteColor), // Dynamic icon color
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16), // Padding around the player
          child: ClipRRect(
            borderRadius:
                BorderRadius.circular(24), // Rounded corners for the player
            child: YoutubePlayer(
              controller: _controller, // Assign the controller
              showVideoProgressIndicator: true, // Show video progress bar
            ),
          ),
        ),
      ),
    );
  }
}
