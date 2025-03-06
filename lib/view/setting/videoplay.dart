// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

// class ShowVideoScreen extends StatefulWidget {
//   final String videoUrl;

//   const ShowVideoScreen({required this.videoUrl, Key? key}) : super(key: key);

//   @override
//   State<ShowVideoScreen> createState() => _ShowVideoScreenState();
// }

// class _ShowVideoScreenState extends State<ShowVideoScreen> {
//   late VideoPlayerController _controller;
//   bool _isPlaying = false; // Track if video is playing or paused
//   bool _isLoading = true; // Track if video is still loading
//   bool _hasError = false; // Track if there's an error loading the video

//   @override
//   void initState() {
//     super.initState();
//     _initializeVideoPlayer();
//   }

//   // Initialize the video player
//   void _initializeVideoPlayer() async {
//     try {
//       _controller = VideoPlayerController.network(widget.videoUrl)
//         ..initialize().then((_) {
//           if (mounted) {
//             setState(() {
//               _isLoading = false; // Video is initialized
//             });
//           }
//         }).catchError((error) {
//           if (mounted) {
//             setState(() {
//               _hasError = true; // Set error state if initialization fails
//               _isLoading = false;
//             });
//           }
//         });

//       // Listen for video completion
//       _controller.addListener(() {
//         if (mounted &&
//             _controller.value.isPlaying &&
//             _controller.value.position >= _controller.value.duration) {
//           setState(() {
//             _isPlaying = false; // Pause when video ends
//           });
//         }
//       });
//     } catch (e) {
//       if (mounted) {
//         setState(() {
//           _hasError = true; // Set error state if an exception occurs
//           _isLoading = false;
//         });
//       }
//     }
//   }

//   @override
//   void dispose() {
//     _controller
//         .dispose(); // Dispose of the controller when the widget is disposed
//     super.dispose();
//   }

//   // Toggle play/pause
//   void _togglePlayPause() {
//     setState(() {
//       if (_isPlaying) {
//         _controller.pause();
//       } else {
//         _controller.play();
//       }
//       _isPlaying = !_isPlaying;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Video Player"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Display the video or loading/error states
//             if (_isLoading)
//               const CircularProgressIndicator() // Show loading indicator
//             else if (_hasError)
//               const Text(
//                 "Failed to load video",
//                 style: TextStyle(color: Colors.red),
//               ) // Show error message
//             else
//               AspectRatio(
//                 aspectRatio: _controller.value.aspectRatio,
//                 child: VideoPlayer(_controller), // Display the video player
//               ),

//             const SizedBox(height: 20),

//             // Play/Pause Button
//             if (!_isLoading && !_hasError)
//               ElevatedButton(
//                 onPressed: _togglePlayPause,
//                 child: Text(_isPlaying ? 'Pause' : 'Play'),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
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
