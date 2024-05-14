import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatelessWidget {
  const VideoPlayerWidget({super.key, required this.file, required this.controller});
  final VideoPlayerController? controller;
  final String file;
  
  @override
  Widget build(BuildContext context) {
    return (controller != null && controller!.value.isInitialized)? Container(alignment: Alignment.topCenter, child: buildVideo())
    : Container(child: CircularProgressIndicator());
  }

  Widget buildVideo() => AspectRatio(
      aspectRatio: controller!.value.aspectRatio,
      child: VideoPlayer(controller!)
    );
}