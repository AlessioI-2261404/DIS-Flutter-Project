import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:group_9_app/datastructures/video_player_widget.dart';

class StoryPage extends StatefulWidget{
  const StoryPage({Key? key, required this.file, required this.type}) : super(key : key);
  final String file;
  final String type;

  @override
  State<StatefulWidget> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage>{

  VideoPlayerController? _controller;
  
  @override
  void initState() {
    super.initState();
    if (widget.type != 'IMG') { 
      _initVideo();
    }
  }

  void _initVideo() async {
    try {
      _controller = VideoPlayerController.asset(widget.file)
      ..addListener(() => setState(() {}))
      ..initialize()
      .then((value) => _controller?.play()); 
    } catch (e) { if (kDebugMode) {
      print("Error: $e");
    } }
  }

  @override
  void dispose(){
    _controller?.dispose();
    super.dispose();
  }

  void _navigateBack() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  Widget _loadCorrectFileType() {
    if (widget.type != 'IMG'){
      return VideoPlayerWidget(file: widget.file, controller: _controller);
    }
    else {
      return Image.asset(widget.file, fit: BoxFit.fill,);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Positioned(
          child: SizedBox(
            child: _loadCorrectFileType(),
          ),
        ),
        Positioned(
          left: 10.0,
          top: 10.0,
          child: IconButton(
            onPressed: () => _navigateBack(),
            icon: const Icon(Icons.close),
          ),
        ),
      ]);
  }
  
}