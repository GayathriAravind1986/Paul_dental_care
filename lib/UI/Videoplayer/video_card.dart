import 'package:flutter/material.dart';
import 'package:simple/UI/Videoplayer/videoItems.dart';
import 'package:simple/UI/Videoplayer/videoplayer.dart';

class VideoCard extends StatelessWidget {
  final VideoItem item;
  final bool isDarkMode;

  const VideoCard({required this.item, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    // Define colors for the card based on dark mode state
    final Color cardColor = isDarkMode ? Colors.grey[800]! : Colors.white;
    final Color textColor = isDarkMode ? Colors.white : Colors.black;
    final Color highlightColor = isDarkMode ? Colors.amber : Colors.pink[900]!;

    return InkWell(
      borderRadius: BorderRadius.circular(32),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => VideoPlayerPage(item: item, isDarkMode: isDarkMode)),
      ),
      child: Material(
        color: cardColor,
        elevation: 6,
        borderRadius: BorderRadius.circular(32),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Stack for thumbnail with play button overlay
              Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Image.network(
                        'https://img.youtube.com/vi/${item.id}/hqdefault.jpg',
                        fit: BoxFit.cover,
                        loadingBuilder: (_, child, progress) =>
                        progress == null ? child : const Center(child: CircularProgressIndicator()),
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: const Center(
                              child: Icon(Icons.videocam_off, color: Colors.black54),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  // Play button overlay
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                item.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: highlightColor,
                  fontFamily: 'Times New Roman',
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Date: ${item.date}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Times New Roman',
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}