import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl; // Define videoUrl in the constructor

  // Constructor for VideoPlayerWidget to accept videoUrl
  VideoPlayerWidget({required this.videoUrl});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize VideoPlayerController with the provided videoUrl
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {}); // Rebuild once the video is initialized
        _controller.play(); // Automatically start playing the video
      });
  }

  @override
  void dispose() {
    _controller.dispose(); // Properly dispose of the video controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _controller.value.isInitialized
          ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller), // Play the video
            )
          : const Center(
              child:
                  CircularProgressIndicator()), // Show loading indicator until the video is initialized
    );
  }
}
